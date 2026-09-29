---
sidebar_position: 2
---

# Monitors, groups and tags

Everything here happens on an instance's screen, on the monitor or group under the cursor.
Whatever you change is written to Kuma straight away, and shows in Kuma's web UI too.

## Create a monitor

`n` asks what the monitor should watch:

| Type | Watches | Fields |
|---|---|---|
| HTTP | a URL answers | name, url, interval, retries, accepted status codes |
| Keyword | a URL answers and contains a word | the same, plus the keyword and whether it is inverted |
| Ping | a host answers | name, host, interval, retries |
| Port | a TCP port accepts connections | name, host, port, interval, retries |
| Other type… | anything else Kuma offers | the field editor, below |

Under the fields, three lists: the **group** it goes in (one, or none), the **tags** it
carries and the notification channels it **notifies through**. `space` chooses or ticks an
entry, `tab` moves to the next list, `enter` saves.

A monitor made with the cursor inside a group goes into that group.

## Edit, clone, delete

- `e` opens the monitor's form with its current values.
- `C` clones it: the form opens on a new monitor with the same settings, group and tags, named
  `copy of …`, and saving creates it. A push monitor's clone gets a push token of its own.
- `d` deletes it, after asking.
- `v` moves it into another group, or to **No group**. Groups move the same way.

## Pause and resume

`p` pauses the monitor under the cursor, or resumes it if it is paused.

On a group, `p` pauses the group and every monitor and group it contains, after asking — Kuma's
own group pause keeps checking the monitors inside it, so lazykuma pauses each one. Resuming a
group resumes everything in it, including anything that was paused on its own.

## The field editor

Kuma does not publish each monitor type's fields; its own web UI hardcodes them, one type at a
time. So for every type without a form, and for the fields a form does not show, lazykuma edits
the object Kuma stores directly.

`r` opens it on any monitor. **Other type…** in `n` opens it on a new one, after you pick the
type from the ones this Kuma supports.

| Key | |
|---|---|
| `enter` | edit the field under the cursor |
| `a` | add a field |
| `d` | delete the field |
| `ctrl+s` | save |
| `esc` | back |

Values are JSON: `"text"`, `20`, `true`. A docker monitor's `docker_host` takes the id of one of
the instance's [Docker hosts](/usage/server#docker-hosts).

## Groups

Groups are Kuma's own: a group made here shows in Kuma's web UI, and the other way round.

- `g` creates one.
- `v` moves the monitor under the cursor into a group.
- `space` or `enter` on a group folds or unfolds it.
- `e` on a group renames it.
- `d` on a group asks whether to delete it alone, keeping its monitors, or with everything in it.

A group shows its worst monitor's state. Pausing or silencing a group covers everything in it.

## Tags

Tags are Kuma's too. `t` lists the instance's tags:

| Key | |
|---|---|
| `n` | new tag |
| `e` | edit its name and colour |
| `d` | delete it, after asking |
| `esc` | back |

A monitor's form ticks which tags it carries. The side panel shows them in their own colours,
as `name` or `name:value`, and `/` searches tag names and values along with
monitor names and targets.
