---
sidebar_position: 1
---

# lazykuma watch

```sh
lazykuma watch
```

Runs until stopped and reports every outage: one line per change on standard output, and a
desktop notification — D-Bus on Linux, Notification Center on macOS, toasts on Windows.

```
2026-09-28 14:02:11  watching home, vps; notifying on outages
2026-09-28 14:02:12  home: ok
2026-09-28 14:02:12  vps: ok
2026-09-28 14:31:40  down  home / nas.home.lan  connect: connection refused
```

- **No alert storm on start.** The state each monitor has when watch starts is its starting
  point, so a fresh start never raises an alert per monitor that is already down.
- **Restarts are not outages.** An instance that drops is reported only after 30 seconds
  unreachable, so a Kuma restart or a container update does not raise an alert.
- **It says when it goes blind.** Every connection change is printed too, including a refused
  login token, so a watch that can no longer see an instance says so.
- **It follows the config.** An instance added, removed or logged in to from the terminal UI is
  picked up within ten seconds, without a restart.
- **One at a time.** Only one watch runs at a time; a second one says which is running (its
  process id) and exits.

## Where to run it

In a tmux pane, or let lazykuma start it at login: see
[Background alerts](/without-the-tui/background-alerts).

## What it notifies about

By default a watch reports outages only. The `[notify]` section of the config changes that:
`on = "changes"` adds recoveries (`back` lines, and a notification each), and `watch = false`
keeps the lines but drops the desktop notifications.

```toml
[notify]
watch = true     # lazykuma watch notifies (it always prints)
on = "down"      # "down", or "changes" to hear about recoveries too
```

See [config.toml](/configuration/config-file#notify).

## The terminal UI and watch

The terminal UI can raise the same notifications while it is open (`desktop = true`), but that
is off by default so that it does not repeat what watch already says.
