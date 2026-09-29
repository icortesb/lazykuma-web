---
sidebar_position: 3
---

# lazykuma status and waybar

```sh
lazykuma status [--json] [--timeout 10s]
```

Answers once and exits. It connects and logs in to every instance, waits for each to answer —
or for `--timeout`, 10 seconds by default — and prints what it found. The first line is the
summary; when something is wrong, the details follow, indented.

```sh
$ lazykuma status
6 up
$ lazykuma status
1 down: shop.example.com
  shop.example.com: connect: connection refused
```

## Exit codes

| Code | |
|---|---|
| `0` | everything is up |
| `1` | something is down, or one of the instances could not be reached |
| `2` | no instance could be reached, or none is configured or logged in to |

So a script can tell "down" from "cannot tell":

```sh
lazykuma status > /dev/null
case $? in
  0) ;;
  1) echo "something is down" ;;
  2) echo "cannot reach Kuma" ;;
esac
```

## --json

`--json` prints the shape waybar and similar bars read:

```sh
$ lazykuma status --json
{"text":"1 down: shop.example.com","tooltip":"shop.example.com: connect: connection refused","class":"down","up":5,"down":1,"pending":0,"paused":0,"maintenance":0}
```

- `text` is the summary line, `tooltip` the details.
- `class` is `up`, `down` or `unreachable`.
- `up`, `down`, `pending`, `paused` and `maintenance` count monitors.

With `--json` the exit code is always `0`, because waybar hides a module whose command fails,
which would make it vanish exactly when something is down. `class` carries the state instead.
Even a config lazykuma cannot read gives JSON, with the reason in `tooltip`.

## A waybar module

In waybar's `config`:

```json
"custom/kuma": {
  "exec": "lazykuma status --json",
  "return-type": "json",
  "interval": 60
}
```

and add `"custom/kuma"` to one of `modules-left`, `modules-center` or `modules-right`. waybar
puts `class` on the module, so `style.css` can colour it:

```css
#custom-kuma.down { color: #f7768e; }
#custom-kuma.unreachable { color: #e0af68; }
```

Each run connects and logs in to every instance afresh, so poll every minute or so, not every
second.

## Warnings

`status` writes warnings to standard error, where a status bar reading standard output will not
mistake them for the answer: a problem in the config, or background alerts running a different
lazykuma binary than this one.
