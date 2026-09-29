---
sidebar_position: 1
---

# config.toml

`~/.config/lazykuma/config.toml` (`%AppData%\lazykuma\config.toml` on Windows) holds the
instances and the notification settings. It has no secrets in it: it is safe to keep in your
dotfiles. lazykuma writes it when you add an instance; everything else you edit by hand.

```toml
# lazykuma instances. Tokens live elsewhere; this file is safe to share.

[notify]
desktop = false
watch = true
on = "down"

[[instance]]
name = "home"
url = "http://kuma.home.lan:3001"

[[instance]]
name = "vps"
url = "https://status.example.com"
```

A missing file is an empty config. Something in it that cannot be used — a bad URL, a repeated
name, a file that does not parse — is skipped with a warning rather than stopping lazykuma, which
starts with whatever it could read.

## [[instance]]

One block per Kuma, in the order the menu lists them.

| Key | |
|---|---|
| `name` | what the menu calls it. Two instances cannot share a name, whatever the case. |
| `url` | the address you open Kuma at, `http://` or `https://` |

To remove an instance, delete its block. To rename one, or change its URL, edit it and log in
again: the stored token is tied to the URL it was issued for, not the name.

`lazykuma watch` picks up changes to the file within ten seconds, without a restart.

## [notify]

All optional; a missing key keeps its default.

| Key | Default | |
|---|---|---|
| `desktop` | `false` | the terminal UI raises desktop notifications while it is open. Off, so it does not repeat what `lazykuma watch` says. |
| `watch` | `true` | `lazykuma watch` raises desktop notifications. It always prints its lines. |
| `on` | `"down"` | `"down"` to hear about outages only, or `"changes"` to hear about recoveries too |

Any other value of `on` is warned about and read as `"down"`.

These are lazykuma's own notifications, on the machine it runs on. The notifications Kuma itself
sends — Telegram, email, webhooks — are set up under
[notification channels](/usage/channels-and-silencing).

## Environment

`$XDG_CONFIG_HOME` and `$XDG_STATE_HOME` are honoured, if set, in place of `~/.config` and
`~/.local/state` — on Windows too, in place of `%AppData%` and `%LocalAppData%`.
