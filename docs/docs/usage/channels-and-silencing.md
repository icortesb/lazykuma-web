---
sidebar_position: 6
---

# Notification channels and silencing

## Notification channels

These are Kuma's own notifications — the ones Kuma sends when a monitor goes down, whether or not
lazykuma is running. (lazykuma's desktop alerts are separate: see
[`lazykuma watch`](/without-the-tui/watch).)

`c` on an instance lists its channels. A `★` marks a default channel: Kuma applies it to
monitors created afterwards.

| Key | |
|---|---|
| `n` | new channel |
| `e` or `enter` | edit it |
| `t` | send a test, so a wrong token says so immediately |
| `d` | delete it, after asking |
| `esc` | back |

Three services have a form of their own:

| Service | Fields |
|---|---|
| Telegram | bot token, chat id, silent |
| Webhook | url, content type |
| Email (SMTP) | host, port, TLS, username, password, from, to |

Each also has **name** and **default**. Kuma supports about ninety services; any other one is
set up through **Other service…**, which opens the [field editor](/usage/monitors#the-field-editor)
on Kuma's own keys for it.

Tokens and passwords are typed masked, sent to Kuma and never written by lazykuma.

Which channels a monitor notifies through is ticked in the monitor's form, under
**notify through**.

## Silencing

`m` silences the monitor under the cursor while you deploy, so it stops alerting. On a group it
silences everything in the group. Give it a title, such as `deploy`, and either:

- leave **from** and **to** empty to silence it **now, until you end it**, or
- fill both, as `2026-09-12 15:04`, for a window between two times.

A silence is a Kuma maintenance window, so Kuma's web UI shows it too, and a silenced monitor
shows `◆` in the list.

`M` lists what is silenced on the instance, the ones silencing something now first. `d` ends a
silence and deletes it, after asking: every monitor it covers speaks again. `esc` goes back.

## The incident timeline

`i` shows when monitors went down and came back, and why. See
[Monitor detail](/usage/monitor-detail#the-incident-timeline).
