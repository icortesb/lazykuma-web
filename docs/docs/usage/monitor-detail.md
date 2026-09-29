---
sidebar_position: 3
---

# Monitor detail

`enter` on a monitor opens it at full size. From top to bottom:

- its name and state, then its target, type, check interval and the group it is in, and its tags
- its **uptime** over the last 24 hours, 30 days and year, the days left on its certificate, and
  its average ping
- a **chart of its pings** over the last hour, 6 hours, 24 hours, 7 days or 30 days, with the
  lowest and highest ping of the period — `←`/`→` (or `h`/`l`) switch the period; it opens on 24
  hours
- a bar of its **latest beats**
- its **events**: the history of its state changes, newest first, each with the time and Kuma's
  message. They are fetched from Kuma as you scroll down with `j`/`k`.

```
nextcloud   up
https://cloud.home.lan · http · every 60s · Home lab

uptime  24h 99.8%   30d 99.9%   1y 99.7%     cert 61 days     avg 42ms

ping · 24h   min 31ms · max 180ms
▁▂▁▃▂▁▇▂▁▂▃▂▁▁▂▁▂▁▃▂▁▁▂▁▂▃▂▁▁▂▁
beats  ████████████████████████████

events
 2026-09-28 03:12  ● up    200 - OK
 2026-09-28 03:10  ✖ down  timeout of 48000ms exceeded
```

## Keys

| Key | |
|---|---|
| `←`/`→` | switch the chart's period |
| `j`/`k` | move through the events |
| `x` | clear its events: removes its past state changes, keeping its beats and uptime |
| `X` | clear its history: deletes all of its beats, state changes and uptime statistics, so the chart starts again from now |
| `e` | edit it |
| `r` | edit its fields directly |
| `p` | pause or resume it |
| `v` | move it into a group |
| `C` | clone it |
| `m` | silence it |
| `d` | delete it |
| `?` | help |
| `esc` | back to the list |

`x` and `X` each ask first: nothing brings back what they remove.

## The incident timeline

`i` on the instance screen lists when monitors went down and came back, and why, across the
whole instance: time, `✖ down` or `✔ up`, the monitor and Kuma's message. `j`/`k` move, `/`
filters, `esc` goes back.
