#!/usr/bin/env bash
# Records landing/assets/demo.gif (and docs/static/img/demo.gif).
#
#   demo/demo.sh          everything: up, seed, let the monitors run, record, down
#   demo/demo.sh up       network, two Kumas, the demo shell, seeded
#   demo/demo.sh record   vhs demo/demo.tape, optimise, copy to docs
#   demo/demo.sh down     remove every container and the network
#
# Everything on screen lives in podman: two throwaway Uptime Kuma 2
# instances reached as kuma.home.lan and status.example.com, and a shell
# container with the lazykuma release binary. The machine doing the
# recording never appears in the frame, and no real Kuma is touched.
set -euo pipefail

cd "$(dirname "$0")/.."

VERSION=${LAZYKUMA_VERSION:-0.7.0}
NET=lkdemo
KUMA_IMAGE=docker.io/louislam/uptime-kuma:2
SHELL_IMAGE=registry.fedoraproject.org/fedora:latest
HOME_PORT=${LKDEMO_HOME_PORT:-3911}
VPS_PORT=${LKDEMO_VPS_PORT:-3912}
WAIT=${LKDEMO_WAIT:-1200} # seconds of monitor history before recording
CACHE=demo/.cache

down() {
	podman rm -f lkdemo-home lkdemo-vps lkdemo-shell >/dev/null 2>&1 || true
	podman network rm -f "$NET" >/dev/null 2>&1 || true
}

binary() {
	if [[ ! -x "$CACHE/lazykuma" ]]; then
		mkdir -p "$CACHE"
		gh release download "v$VERSION" -R icortesb/lazykuma \
			-p "lazykuma_${VERSION}_linux_amd64.tar.gz" -D "$CACHE" --clobber
		tar -xzf "$CACHE/lazykuma_${VERSION}_linux_amd64.tar.gz" -C "$CACHE" lazykuma
	fi
}

kuma() { # name port alias...
	local name=$1 port=$2
	shift 2
	local aliases=()
	for a in "$@"; do aliases+=(--network-alias "$a"); done
	podman run -d --name "$name" --network "$NET" "${aliases[@]}" \
		-p "127.0.0.1:$port:3001" "$KUMA_IMAGE" >/dev/null
}

ready() { # port: pick SQLite on a fresh v2 and wait for the app
	local url=http://127.0.0.1:$1
	for _ in $(seq 1 90); do
		curl -fs "$url/setup-database-info" >/dev/null 2>&1 && break
		sleep 1
	done
	if curl -fs "$url/setup-database-info" | grep -q '"needSetup":true'; then
		curl -fs -X POST -H 'Content-Type: application/json' \
			-d '{"dbConfig":{"type":"sqlite"}}' "$url/setup-database" >/dev/null
	fi
	for _ in $(seq 1 90); do
		if curl -fs "$url/api/entry-page" 2>/dev/null | grep -qv setup-database; then
			return 0
		fi
		sleep 1
	done
	echo "demo: Kuma on port $1 did not come up" >&2
	return 1
}

up() {
	binary
	down
	# 10.0.0.0/24 is the demo's own: 10.0.0.99 is unassigned in it, so the
	# router monitor fails on every check, and nothing outside is probed.
	podman network create --subnet 10.0.0.0/24 "$NET" >/dev/null
	kuma lkdemo-home "$HOME_PORT" kuma.home.lan nas.home.lan
	kuma lkdemo-vps "$VPS_PORT" status.example.com
	ready "$HOME_PORT"
	ready "$VPS_PORT"

	local tokens pass
	tokens=$(mktemp)
	trap 'rm -f "$tokens"' RETURN
	pass=$(head -c 18 /dev/urandom | base64 | tr -d '/+=')A1
	uv run -q --with "python-socketio[client]" --with websocket-client demo/seed.py \
		"http://127.0.0.1:$HOME_PORT" "http://127.0.0.1:$VPS_PORT" admin "$pass" "$tokens"

	podman run -d --name lkdemo-shell --hostname demo --network "$NET" \
		"$SHELL_IMAGE" sleep infinity >/dev/null
	podman exec lkdemo-shell useradd -m -s /bin/bash ops
	podman cp "$CACHE/lazykuma" lkdemo-shell:/usr/local/bin/lazykuma
	podman exec lkdemo-shell chmod 755 /usr/local/bin/lazykuma
	podman exec --user ops lkdemo-shell mkdir -p /home/ops/.config/lazykuma /home/ops/.local/state/lazykuma
	podman exec -i --user ops lkdemo-shell sh -c 'cat > /home/ops/.config/lazykuma/config.toml' <<-'EOF'
		# lazykuma instances. Tokens live elsewhere; this file is safe to share.

		[[instance]]
		  name = "home"
		  url = "http://kuma.home.lan:3001"

		[[instance]]
		  name = "vps"
		  url = "http://status.example.com:3001"
	EOF
	podman exec -i --user ops lkdemo-shell sh -c \
		'umask 077; cat > /home/ops/.local/state/lazykuma/tokens.json' <"$tokens"
	echo "demo: up and seeded"
}

record() {
	vhs demo/demo.tape
	gifsicle -O3 --lossy=60 landing/assets/demo.gif -o landing/assets/demo.gif.tmp
	mv landing/assets/demo.gif.tmp landing/assets/demo.gif
	mkdir -p docs/static/img
	cp landing/assets/demo.gif docs/static/img/demo.gif
	echo "demo: $(du -h landing/assets/demo.gif | cut -f1) landing/assets/demo.gif"
}

case "${1:-all}" in
up) up ;;
record) record ;;
down) down ;;
all)
	trap down EXIT
	up
	echo "demo: letting the monitors run for ${WAIT}s"
	sleep "$WAIT"
	record
	;;
*)
	echo "usage: $0 [up|record|down|all]" >&2
	exit 2
	;;
esac
