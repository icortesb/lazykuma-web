---
sidebar_position: 1
---

# The menu and instances

## The menu

The menu is where lazykuma starts: the **LAZYKUMA** logo, one line per instance, then
**Add instance**, **Background alerts**, **Help** and **Quit**. `↑`/`k` and `↓`/`j` move,
`enter` chooses.

Under each instance is its address and how many monitors it has, and how many are down — or,
when it is not connected, why. The footer sums up every instance at once:

```
home ok   vps down   lab no cred
```

The states are explained in [First run](/getting-started/first-run#the-menu).
**Background alerts** is a switch: see [Background alerts](/without-the-tui/background-alerts).

## The instance screen

`enter` on a connected instance opens it. The top line counts its monitors:

```
 home · 12 monitors · 11 up · 1 down
```

Below it, the monitor list on the left and, on the right, the monitor under the cursor: its
target, its tags, its state, its uptime over 24 hours, the days left on its certificate, a
sparkline of its pings and a bar of its latest beats, then its newest messages.

Each monitor's mark says its state:

| Mark | |
|---|---|
| `●` | up |
| `✖` | down |
| `◐` | pending |
| `◆` | under maintenance |
| `‖` | paused |
| `○` | no beat yet |

Groups show `▾` when open and `▸` when folded, with their worst monitor's state beside them.

If the connection drops, the screen keeps what it last had and says so in the top line:
`stale since 15:04 · down`.

## Search, show, sort

- `/` searches as you type: names, targets, and tag names and values. `enter` keeps the search
  and returns to the list; `esc` clears it.
- `f` cycles which monitors are shown: all, down, up, paused, maintenance.
- `s` cycles the order: by status (down first), by name, by ping (slowest first) or by uptime
  (worst 24-hour uptime first).

While a search or a `show` is on, groups are shown open, so a match is never hidden in a folded
group. The top line says which `show` and `sort` are on.

`esc` with a search typed clears it; with none, it goes back to the menu.
