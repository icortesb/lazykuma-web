---
sidebar_position: 1
slug: /
---

import useBaseUrl from '@docusaurus/useBaseUrl';

# Introduction

**lazykuma** is a terminal UI for [Uptime Kuma](https://github.com/louislam/uptime-kuma) 2.
Watch every monitor of every instance you run, live, and pause or resume them without opening
the browser.

```
 home · 12 monitors · 11 up · 1 down
╭──────────────────────────────╮╭─────────────────────────────────────────╮
│ ✖ vaultwarden              — ││ nextcloud                               │
│ ● nextcloud             42ms ││ https://cloud.home.lan                  │
│ ● pihole                 3ms ││ up · 99.8% 24h · cert 61 days           │
│ ‖ backup-s3           paused ││ ping  ▁▂▁▃▂▁▇▂▁▂▃▂▁▁▂▁ 42ms              │
│                              ││ beats ████████████████████              │
╰──────────────────────────────╯╰─────────────────────────────────────────╯
```

<img src={useBaseUrl('/img/demo.gif')} alt="Recording of lazykuma: the menu, an instance with groups and tags, a monitor's ping chart, and its status pages." />

More on the [landing page](pathname:///lazykuma-web/).

## What it does

- **Every instance at once.** The menu lists each Kuma you run and says which ones answer:
  `home ok   vps down   lab no cred`.
- **Monitors, managed.** Create, edit, clone, move, pause and delete monitors; forms for HTTP,
  keyword, ping and TCP port, and a field editor for every other type Kuma offers.
- **Groups and tags**, Kuma's own: what you make here shows in Kuma's web UI, and the other way
  round.
- **Monitor detail**: uptime over a day, 30 days and a year, the certificate, a ping chart over
  the last hour to 30 days, the latest beats and the history of state changes.
- **Status pages**: create them, edit their settings, arrange their sections, post an incident.
- **The server**: API keys, proxies, Docker hosts and the database.
- **Notification channels and silencing**: Telegram, webhook and email forms with a test button;
  silence a monitor while you deploy.
- **Without the terminal UI**: `lazykuma watch` reports every outage, `lazykuma autostart on`
  starts it at login, and `lazykuma status` answers once for a script or a status bar such as
  waybar.

## Who it is for

Anyone who runs Uptime Kuma — one instance at home, a few on servers — and lives in a terminal:
over SSH, in a tmux pane, or on a desktop where a browser tab for Kuma is one tab too many.

## Quick install

Take the binary for your system from the
[releases](https://github.com/icortesb/lazykuma/releases), or:

```sh
go install github.com/icortesb/lazykuma/cmd/lazykuma@latest
```

See [Installation](/getting-started/installation) for each system, then
[First run](/getting-started/first-run).

## Requirements

Uptime Kuma 2.x. Kuma 1.x is detected and refused: its API differs. See
[Requirements](/getting-started/requirements).
