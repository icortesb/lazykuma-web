---
sidebar_position: 2
---

# Files

Everything lazykuma keeps, and where:

| File | Linux | macOS | Windows |
|---|---|---|---|
| `config.toml` | `~/.config/lazykuma/` | `~/.config/lazykuma/` | `%AppData%\lazykuma\` |
| `tokens.json` | `~/.local/state/lazykuma/` | `~/.local/state/lazykuma/` | `%LocalAppData%\lazykuma\` |
| `watch.lock` | next to `tokens.json` | next to `tokens.json` | next to `tokens.json` |
| `watch.log` | next to `tokens.json` | `~/Library/Logs/lazykuma/` | next to `tokens.json` |

`$XDG_CONFIG_HOME` and `$XDG_STATE_HOME` replace `~/.config` and `~/.local/state` when set.

## config.toml

The instances and the notification settings. No secrets: safe to keep in your dotfiles. See
[config.toml](/configuration/config-file).

## tokens.json

The login token of each instance, readable only by you (on Windows, kept in your user profile
folder, which other users cannot read). Tokens are keyed by the URL they were issued for.

Your password and 2FA code are sent to Kuma once, at login, and never written anywhere. When
Kuma refuses a token — it expired, or you changed your password — the instance says `bad cred`
and asks you to log in again. Deleting `tokens.json` logs you out of every instance.

## watch.lock

The process id of the running `lazykuma watch`, so that only one runs at a time.

## watch.log

What a background watch printed, readable only by you. It is written when the watch was started
by XDG autostart or the Windows Run key — systemd sends the output to the journal instead, and
on macOS launchd writes `~/Library/Logs/lazykuma/watch.log` itself.

`watch.log` stops at 1 MB: it then becomes `watch.log.1`, replacing the previous one, and a new
file starts. The macOS log is not trimmed.

## Security

With an `http://` URL, the password and the token cross the network unencrypted. Use
`https://` for any instance not on your own LAN.
