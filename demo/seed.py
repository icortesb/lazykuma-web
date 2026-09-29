"""Seeds the two throwaway Kuma instances of the demo recording.

    uv run --with "python-socketio[client]" --with websocket-client demo/seed.py \
        <home url> <vps url> <user> <password> <tokens out>

Creates the first user on each (setup), logs in, adds the groups, monitors,
tags and status pages the recording shows, and writes the tokens.json the
demo container's lazykuma reads, keyed by instance name and the URL the
container reaches each Kuma at.
"""

import json
import sys
import threading

import socketio

HOME_URL, VPS_URL, USER, PASSWORD, TOKENS_OUT = sys.argv[1:6]

# The URLs lazykuma uses inside the demo network.
INSTANCES = {"home": "http://kuma.home.lan:3001", "vps": "http://status.example.com:3001"}


def connect(url):
    ready = threading.Event()
    sio = socketio.Client(reconnection=False)
    # Kuma ignores anything sent before it asks for a login.
    sio.on("loginRequired", lambda *a: ready.set())
    sio.on("autoLogin", lambda *a: ready.set())
    sio.connect(url, transports=["websocket"])
    if not ready.wait(30):
        sys.exit(f"seed: {url} never asked for a login")
    return sio


def call(sio, event, *args):
    # A tuple is sent as that many arguments, as Kuma's handlers expect.
    return sio.call(event, data=tuple(args), timeout=30)


def ok(r, what):
    if not isinstance(r, dict) or not r.get("ok"):
        sys.exit(f"seed: {what}: {r}")
    return r


def monitor(**kw):
    m = {
        "type": "http", "method": "GET", "interval": 20, "retryInterval": 20, "maxretries": 0,
        "timeout": 8, "accepted_statuscodes": ["200-299"], "notificationIDList": {},
        "conditions": [], "kafkaProducerBrokers": [], "kafkaProducerSaslOptions": {},
        "active": True, "parent": None,
    }
    m.update(kw)
    return m


def group(name):
    return monitor(type="group", name=name, interval=60, retryInterval=60)


def add(sio, m):
    return ok(call(sio, "add", m), f"add {m['name']}")["monitorID"]


def tag(sio, name, color):
    return ok(call(sio, "addTag", {"name": name, "color": color}), f"addTag {name}")["tag"]["id"]


def label(sio, tag_id, monitor_id, value=""):
    ok(call(sio, "addMonitorTag", tag_id, monitor_id, value), "addMonitorTag")


def status_page(sio, title, slug, description, sections):
    ok(call(sio, "addStatusPage", title, slug), f"addStatusPage {slug}")
    cfg = ok(call(sio, "getStatusPage", slug), f"getStatusPage {slug}")["config"]
    cfg["description"] = description
    groups = [{"name": n, "monitorList": [{"id": i} for i in ids]} for n, ids in sections]
    ok(call(sio, "saveStatusPage", slug, cfg, cfg.get("icon") or "/icon.svg", groups), f"saveStatusPage {slug}")


def login(url):
    sio = connect(url)
    call(sio, "setup", USER, PASSWORD)  # not ok once a user exists: fine
    sio.disconnect()
    sio = connect(url)
    token = ok(call(sio, "login", {"username": USER, "password": PASSWORD, "token": ""}), "login")["token"]
    return sio, token


def seed_home(sio):
    prod = tag(sio, "prod", "#7C3AED")
    lan = tag(sio, "lan", "#059669")
    team = tag(sio, "team", "#2563EB")

    shop = add(sio, group("Shop"))
    www = add(sio, monitor(name="www.example.com", url="https://example.com", parent=shop))
    api = add(sio, monitor(name="api.example.com", url="https://example.org", parent=shop))
    for m in (shop, www, api):
        label(sio, prod, m)
    label(sio, team, www, "web")
    label(sio, team, api, "backend")

    lab = add(sio, group("Home lab"))
    nas = add(sio, monitor(name="nas.home.lan", url="http://nas.home.lan:3001", parent=lab))
    router = add(sio, monitor(name="router.home.lan", url="http://10.0.0.99", timeout=4, parent=lab))
    for m in (lab, nas, router):
        label(sio, lan, m)

    docs = add(sio, monitor(name="docs.example.org", url="https://example.org"))
    label(sio, team, docs, "docs")

    status_page(sio, "Shop", "shop", "Storefront and API", [("Storefront", [www, api])])
    status_page(sio, "Home lab", "home-lab", "Things at home", [("Network", [router]), ("Storage", [nas])])


def seed_vps(sio):
    web = add(sio, monitor(name="blog.example.org", url="https://example.org"))
    shop = add(sio, monitor(name="checkout.example.com", type="keyword", url="https://example.com",
                            keyword="Example Domain"))
    tcp = add(sio, monitor(name="smtp.example.com", type="port", hostname="example.com", port=443, url=""))
    prod = tag(sio, "prod", "#7C3AED")
    for m in (web, shop, tcp):
        label(sio, prod, m)
    status_page(sio, "Example status", "example", "Public status of example.com",
                [("Services", [web, shop, tcp])])


tokens = {}
for name, url, seed in (("home", HOME_URL, seed_home), ("vps", VPS_URL, seed_vps)):
    sio, token = login(url)
    seed(sio)
    sio.disconnect()
    tokens[name] = {"url": INSTANCES[name], "token": token}

with open(TOKENS_OUT, "w") as f:
    json.dump(tokens, f)
print("seed: home and vps seeded")
