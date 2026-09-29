---
sidebar_position: 2
---

# Requirements

## Uptime Kuma 2.x

lazykuma talks to Kuma over the same Socket.IO API Kuma's web UI uses, and that API changed
between 1.x and 2.x. An instance running Kuma 1.x is detected and refused — the menu marks it
`unsupported` — rather than half working.

It needs the address you open Kuma at in the browser, and a Kuma user to log in with. Nothing
is installed on the Kuma side.

## A terminal

Any terminal that shows Unicode and colour. The screens size themselves to the window, so a
wider one shows more of each monitor's target and history; below 75 columns the menu switches
to a compact logo.

## For background alerts

Desktop notifications go through D-Bus on Linux, Notification Center on macOS and toasts on
Windows. Starting the watch at login uses a systemd user unit or XDG autostart on Linux, a
launch agent on macOS and the Run key on Windows — nothing needs admin rights. See
[Background alerts](/without-the-tui/background-alerts).

## Over the network

Use `https://` for any instance not on your own LAN: with an `http://` URL, the password and
the login token cross the network unencrypted.

Besides the websocket, the status page screens read a page's sections and incident over plain
HTTP from `<instance URL>/api/status-page/<slug>`. If a proxy in front of Kuma asks for a login
there, those screens say so and save nothing.
