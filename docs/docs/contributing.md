---
sidebar_position: 6
---

# Contributing

lazykuma lives at [github.com/icortesb/lazykuma](https://github.com/icortesb/lazykuma), MIT
licensed. Issues and pull requests go there. This site is
[icortesb/lazykuma-web](https://github.com/icortesb/lazykuma-web): "Edit this page" at the
bottom of each page leads to its source.

## Building

```sh
git clone https://github.com/icortesb/lazykuma
cd lazykuma
make build         # static binary, ./lazykuma
make test          # unit tests, with the race detector
make vet
make integration   # starts a throwaway Kuma 2 in podman or docker and tests against it
```

`make integration` needs podman or docker; the Kuma container it starts is removed again when
the tests end.

## How it talks to Kuma

lazykuma talks to Kuma over its Socket.IO API, which it speaks itself over a websocket: see
`internal/kuma`. `testdata/kuma-v2` holds payloads captured from a real Kuma 2.5.3, so the
decoding is tested without a server.

## Reporting a problem

Include the lazykuma version (`lazykuma --version`), the Kuma version, your system, and what
the screen or `lazykuma status` said. For background alerts, `lazykuma autostart` and the watch
output ([where it goes](/without-the-tui/background-alerts#per-system)) answer most questions.

Open issues on the [main repo](https://github.com/icortesb/lazykuma/issues).

## Re-recording the demo

The recording on the landing page is made from this site's repository, in `demo/`, against
throwaway Kuma containers — never a real instance.
