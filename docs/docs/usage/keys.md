---
sidebar_position: 7
---

# Keys

`?` shows the same reference inside lazykuma, from the menu, an instance, a monitor's detail and
the server screen. `esc`, `?` or `q` close it.

## Everywhere

| Key | |
|---|---|
| `↑`/`k` `↓`/`j` | move |
| `enter` | open an instance, or log in to it |
| `esc` | back |
| `?` | help, from the menu, an instance, a monitor's detail and the server screen |
| `q` | quit, from the menu |
| `ctrl+c` | quit, from anywhere |

## On an instance

| Key | |
|---|---|
| `enter` on a monitor | open its detail |
| `space`/`enter` on a group | fold or unfold it |
| `n` | create a monitor, in the group under the cursor |
| `g` | create a group |
| `e` | edit the selected monitor, or rename the selected group |
| `d` | delete the selected monitor, or the selected group (keeping or with its monitors) |
| `v` | move the selected monitor into a group |
| `C` | clone the selected monitor |
| `r` | edit the selected monitor's fields directly |
| `p` | pause or resume the selected monitor, or a whole group and everything in it |
| `m` | silence the selected monitor or group |
| `M` | list what is silenced |
| `t` | the instance's tags |
| `c` | the instance's notification channels |
| `i` | the incident timeline |
| `S` | the instance's status pages |
| `A` | the instance's server: API keys, proxies, Docker hosts, database |
| `/` | search names, targets and tags |
| `f` | show only down, up, paused or maintenance monitors |
| `s` | sort by status, name, ping or uptime |
| `esc` | clear the search, or back to the menu |

## On a monitor's detail

| Key | |
|---|---|
| `←`/`→` | chart period: 1h, 6h, 24h, 7d, 30d |
| `j`/`k` | move through the events |
| `x` | clear its events |
| `X` | clear its history |
| `e` | edit |
| `r` | edit its fields |
| `p` | pause or resume |
| `v` | move into a group |
| `C` | clone |
| `m` | silence |
| `d` | delete |
| `esc` | back |

## On status pages

| Key | |
|---|---|
| `n` | new page |
| `e` | edit its settings |
| `s` | its sections |
| `i` | post or edit its incident |
| `u` | take its incident down |
| `o` | open it in the browser |
| `d` | delete it |
| `esc` | back |

## On a page's sections

| Key | |
|---|---|
| `a` | add a section |
| `r` | rename the section |
| `m` | add a monitor |
| `d` | remove the monitor or section |
| `K`/`J` | move up or down |
| `ctrl+s` | save |
| `esc` | back |

## On the server screen

| Key | |
|---|---|
| `tab` `shift+tab` | next and previous tab |
| `1`–`4` | jump to a tab |
| `n` | new |
| `e` | edit |
| `space` | enable or disable an API key |
| `t` | test a Docker host |
| `d` | delete |
| `s` | shrink the database |
| `X` | clear every monitor's statistics |
| `r` | refresh the database size |
| `esc` | back |

## Lists: tags, channels, silenced, incidents

| Screen | Keys |
|---|---|
| Tags (`t`) | `n` new, `e` edit, `d` delete, `esc` back |
| Channels (`c`) | `n` new, `e`/`enter` edit, `t` test, `d` delete, `esc` back |
| Silenced (`M`) | `d` end and delete, `esc` back |
| Incidents (`i`) | `j`/`k` move, `/` filter, `esc` back |

## Forms

| Key | |
|---|---|
| `tab` `shift+tab` | next and previous field |
| `enter` | submit |
| `esc` | cancel |
| `space` | tick a group, tag or channel in a monitor's form; flip a switch |
| `←`/`→` | change a choice: an incident's style, a proxy's protocol, a Docker host's type |
| `ctrl+s` | save an incident |
| `ctrl+t` | test a Docker host before saving it |

In the field editor: `enter` edit, `a` add field, `d` delete, `ctrl+s` save, `esc` back.

Questions that ask before something is lost take `y` or `n`.
