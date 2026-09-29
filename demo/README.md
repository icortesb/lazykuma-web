# demo

Records the demo GIF: `landing/assets/demo.gif`, copied to `docs/static/img/demo.gif`.

```sh
demo/demo.sh
```

Needs podman, vhs (with ttyd and ffmpeg), gifsicle, uv and gh. From the repo root it:

1. downloads the lazykuma release binary (`LAZYKUMA_VERSION`, default 0.7.0) into `demo/.cache`
2. creates the podman network `lkdemo` (10.0.0.0/24) and two throwaway Uptime Kuma 2 containers:
   `lkdemo-home` (reached as `kuma.home.lan` and `nas.home.lan`) and `lkdemo-vps`
   (`status.example.com`), published only on 127.0.0.1:3911 and :3912 for seeding
3. seeds them with `seed.py` (a random password, never printed): on home, the groups Shop
   (www.example.com, api.example.com) and Home lab (nas.home.lan, up; router.home.lan at
   10.0.0.99, down), docs.example.org, tags prod/lan/team, and the status pages Shop and Home lab;
   on vps, three monitors and one status page
4. starts `lkdemo-shell` with lazykuma, its config and its login tokens for both instances
5. lets the monitors run for `LKDEMO_WAIT` seconds (default 1200) so the hour chart has data
6. records `demo.tape` through `podman exec`, optimises the GIF, copies it to the docs
7. removes every container and the network

`demo/demo.sh up`, `record` and `down` run the steps separately, to adjust the tape without
seeding again. Nothing on screen comes from the recording machine, and no real Kuma is touched.
