---
sidebar_position: 7
---

# Changelog

Every release has builds for Linux, macOS and Windows on amd64 and arm64, and a
`checksums.txt`, on [GitHub Releases](https://github.com/icortesb/lazykuma/releases).

## v0.7.0 — 2026-09-29

**Background alerts that start at login.** `lazykuma autostart on|off` registers
`lazykuma watch` to start at login — a systemd user service or XDG autostart on Linux, a launch
agent on macOS, the Run key on Windows — and the **Background alerts** switch in the menu does
the same. Output goes to the journal, to `~/Library/Logs/lazykuma/watch.log`, or to a
`watch.log` in the state folder that stops at 1 MB. `lazykuma status` warns when the registered
binary is not the one running. See [Background alerts](/without-the-tui/background-alerts).

## v0.6.0 — 2026-09-28

**Server screen**: `A` on an instance opens its API keys, proxies, Docker hosts and database —
make, enable and delete API keys; add, edit and delete proxies, and set one as the default or
on every monitor; add, edit, test and delete Docker hosts; see the database size, shrink it and
clear every monitor's statistics. See [Server](/usage/server).

## v0.5.0 — 2026-09-27

**Status pages**: `S` lists an instance's status pages. Create one, edit its settings, arrange
its sections and the monitors in each, post, edit or take down its incident, open it in the
browser and delete it. See [Status pages](/usage/status-pages).

## v0.4.0 — 2026-09-27

**Monitor detail**: `enter` on a monitor opens its uptime over a day, 30 days and a year, its
certificate and average ping, a ping chart over 1 hour to 30 days, its latest beats and the
history of its state changes. `x` clears its events and `X` its whole history. See
[Monitor detail](/usage/monitor-detail).

## v0.3.0 — 2026-09-17

**Groups, tags, search, filter, sort and clone.** Kuma's groups and tags, created and used from
lazykuma; `/` searches names, targets and tags, `f` shows only one state, `s` sorts, `C`
clones a monitor. See [Monitors, groups and tags](/usage/monitors).

## v0.2.0 — 2026-09-14

The first release.

- The terminal UI: every instance in one menu, a live monitor list per instance, and logging in,
  with 2FA.
- Monitors created, edited, paused and deleted — forms for HTTP, keyword, ping and TCP port, and
  a field editor for every other type — plus notification channels, silencing and an incident
  timeline.
- `lazykuma watch` for outage notifications and `lazykuma status` for scripts and status bars,
  with desktop notifications on Linux, macOS and Windows.
