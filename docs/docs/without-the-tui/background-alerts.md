---
sidebar_position: 2
---

# Background alerts

Background alerts are [`lazykuma watch`](/without-the-tui/watch), started for you at login, so
outages reach you with lazykuma closed.

```sh
lazykuma autostart on    # register watch to start at login, and start it now
lazykuma autostart off   # remove it, and stop it
lazykuma autostart       # say whether it is on, and whether a watch runs
```

The **Background alerts** switch in the menu does the same as `on` and `off`.

```
$ lazykuma autostart
background alerts: on (systemd user service)
runs: /home/you/.local/bin/lazykuma
watch: running (pid 4182)
```

## Per system

Nothing needs admin rights. Each system gets its own mechanism, and its own place for the
output:

| System | Registered as | Output |
|---|---|---|
| Linux with a systemd user session | `~/.config/systemd/user/lazykuma-watch.service` | `journalctl --user -u lazykuma-watch` |
| Linux without one | `~/.config/autostart/lazykuma-watch.desktop` (XDG autostart) | `watch.log` in the state folder |
| macOS | `~/Library/LaunchAgents/io.github.icortesb.lazykuma.watch.plist` | `~/Library/Logs/lazykuma/watch.log` |
| Windows | a `lazykuma-watch` value under `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` | `watch.log` in the state folder |

The state folder is `~/.local/state/lazykuma` (`%LocalAppData%\lazykuma` on Windows); see
[Files](/configuration/files).

## Logs

`watch.log` stops at 1 MB: it then becomes `watch.log.1`, replacing the previous one, and a new
file starts. On macOS launchd writes the log itself, and it is not trimmed.

To follow it:

```sh
journalctl --user -u lazykuma-watch -f          # Linux, systemd
tail -f ~/.local/state/lazykuma/watch.log       # Linux, XDG autostart
tail -f ~/Library/Logs/lazykuma/watch.log       # macOS
```

On Windows, open `%LocalAppData%\lazykuma\watch.log`.

## The binary it runs

`on` registers the binary you run it with, so run it again after moving lazykuma or installing
a new one somewhere else. `lazykuma status` warns when the registered binary is not the one
running.

The systemd unit and the launch agent carry your `$XDG_CONFIG_HOME` and `$XDG_STATE_HOME`, if
set, so the background watch reads the same config as the terminal.

## A watch you started by hand

Only one watch runs at a time. A watch you started yourself in a terminal meets the background
one differently per system:

- **XDG autostart and Windows**: nothing supervises the watch, so `on` and `off` stop whatever
  watch runs, yours included, and `on` starts the registered one in its place.
- **systemd and launchd** leave yours alone. It keeps running, and the service tries again every
  30 seconds until yours stops, then takes over.

`lazykuma autostart` says `started by hand` for a watch that runs while autostart is off.

## Troubleshooting

**No notifications, but the watch runs.** Check the output (table above) for
`desktop notification:` errors — on Linux, a notification daemon must be running in your
session. Check `[notify] watch` is not `false` in [config.toml](/configuration/config-file).

**`off` fails on systemd.** `off` needs the user session to answer while the unit file is
there — `systemctl --user` must work. Without it the unit cannot be stopped, and `off` says so
rather than leave a service behind.

**A unit you wrote yourself.** A unit at `~/.config/systemd/user/lazykuma-watch.service`, written
by hand before lazykuma could do it, is taken over by `on`.

**It watches the wrong instances.** The background watch reads the config at the path its
environment gives. If you set `$XDG_CONFIG_HOME` after turning it on, run `lazykuma autostart on`
again.

**`watch already running`.** Another watch holds the lock: `lazykuma autostart` shows its
process id.
