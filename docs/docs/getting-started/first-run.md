---
sidebar_position: 3
---

# First run

Run `lazykuma`. The first time, the menu has nothing to watch yet: **Add instance**,
**Background alerts**, **Help** and **Quit**.

## Add an instance

Pick **Add instance** and fill in:

- **name** — what the menu calls it, such as `home` or `vps`. Two instances cannot share a name.
- **url** — the address you open Kuma at in the browser, `http://` or `https://`, such as
  `https://kuma.example.com` or `http://kuma.home.lan:3001`.

`tab` moves between the fields, `enter` submits, `esc` cancels. The instance is written to
[`config.toml`](/configuration/config-file) and the login opens.

## Log in

Give a Kuma username and password. If the account has two-factor authentication, Kuma says so
after the password, and a third field, **2FA code**, appears for the six digits from your
authenticator app.

The password and the code are sent to Kuma once and never written anywhere. What lazykuma keeps
is the login token Kuma answers with, in [`tokens.json`](/configuration/files), readable only by
you. From then on the instance connects by itself every time lazykuma starts.

A wrong username, password or code says so and lets you try again.

## The menu

Each instance is a line of the menu. Under it: its address, how many monitors it has and how
many are down — or, when it is not connected, why. The footer sums them all up in one line:

```
home ok   vps down   lab no cred
```

| State | Meaning |
|---|---|
| `connecting` | lazykuma is reaching it |
| `ok` | connected and logged in; its monitors are live |
| `down` | it cannot be reached; the line under it in the menu says why |
| `no cred` | there is no login token for it yet: `enter` opens the login |
| `bad cred` | Kuma refused the token — it expired, or the password changed: log in again |
| `unsupported` | it runs Kuma 1.x |

`enter` on an instance opens it, or its login when it has no usable token. `esc` goes back,
`?` shows the help, `q` quits from the menu and `ctrl+c` from anywhere.

## Renaming or removing an instance

There is no menu entry for it yet: edit `config.toml` directly. Renaming an instance, or
changing its URL, means logging in again, because the stored token is tied to the URL it was
issued for, not the name.

## Next

- [Monitors](/usage/monitors): the instance screen.
- [Background alerts](/without-the-tui/background-alerts): outage notifications with lazykuma
  closed.
