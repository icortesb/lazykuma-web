---
sidebar_position: 5
---

# Server

`A` on an instance opens its server screen. It has four tabs: **API keys**, **proxies**,
**Docker hosts** and **database**. `tab` and `shift+tab` move between them, and `1`–`4` jump
to one. The footer shows the keys of the open tab; `?` lists them all.

## API keys

Keys for Kuma's metrics endpoint, for Prometheus or Grafana to read.

- `n` makes one: a name, such as `grafana`, and when it expires — `never`, a date like
  `2026-12-31`, or a date and time like `2026-12-31 18:00`. The key is shown once: copy it then,
  because lazykuma does not keep it and Kuma does not show it again.
- `space` enables or disables the key under the cursor.
- `d` deletes it, after asking.

## Proxies

Proxies that monitors can check through.

- `n` adds one, `e` edits it, `d` deletes it after asking.
- The form takes the protocol (`http`, `https`, `socks`, `socks5`, `socks5h` or `socks4`,
  switched with `←`/`→`), the host and port, and, with **authentication** ticked, a username
  and password.
- **default for new monitors** makes it the proxy monitors created afterwards use.
- **use it on every existing monitor now** sets it on every monitor of the instance as it
  saves, after asking.

Passwords are never shown. Editing a proxy with the password field left empty keeps the one it
has.

## Docker hosts

Docker daemons that docker monitors check containers on.

- `n` adds one, `e` edits it, `d` deletes it after asking.
- The form takes a name, the connection type — `socket` or `tcp`, switched with `←`/`→` — and
  the daemon: a socket path such as `/var/run/docker.sock`, or an address such as
  `tcp://10.0.0.7:2375`.
- `t` on the list, or `ctrl+t` in the form before saving, tests that Kuma reaches the daemon.

A docker monitor's `docker_host` field, in the [field editor](/usage/monitors#the-field-editor),
takes a host's id.

## Database

The size of Kuma's database.

- `s` shrinks it, after asking. That is for SQLite; on MariaDB there is nothing to shrink.
- `X` clears every monitor's statistics, after you type the instance's name. What lazykuma
  already shows stays on screen; the charts fill again as monitors check.
- `r` asks Kuma for the size again.

## Keys

| Key | |
|---|---|
| `tab` `shift+tab` | next and previous tab |
| `1`–`4` | jump to a tab |
| `n` | new API key, proxy or Docker host |
| `e` | edit the proxy or Docker host |
| `space` | enable or disable the API key |
| `t` | test the Docker host |
| `d` | delete |
| `s` | shrink the database |
| `X` | clear every monitor's statistics |
| `r` | refresh the database size |
| `?` | help |
| `esc` | back |
