---
sidebar_position: 4
---

# Status pages

A status page is a public web page Kuma serves at `/status/<slug>` that shows how some of your
monitors are doing — for your users, your team, or a TV on the office wall. Visitors need no
login. A page is split into sections, each a heading with monitors under it, and it can carry
an incident: a notice at the top saying what is wrong and what is being done.

`S` on an instance lists its status pages: title, slug, whether it is published or hidden, and
its address.

## Create one, step by step

Say you want a page for a shop, with the website and the API on it.

1. **Open the list.** On the instance, press `S`.
2. **Create the page.** Press `n` and type a title, `Shop status`. The slug follows the title
   (`shop-status`) until you type your own; it is the page's address, `/status/shop-status`,
   and takes letters, digits and single dashes. `enter` creates it, empty.
3. **Add a section.** Move to the new page and press `s` to open its sections, then
   `a` and name the section, `Services`.
4. **Add monitors to it.** Press `m` and pick a monitor — `www.example.com` — then `m` again
   for `api.example.com`. A group can be added too, and shows as one line.
5. **Save.** Press `ctrl+s`. Nothing in the sections editor reaches Kuma until you do; `esc`
   with unsaved changes asks whether to discard them.
6. **Set it up.** Back in the list, `e` opens its settings — see below.
7. **Look at it.** `o` opens the page in your browser.

## Settings

`e` edits:

| Field | |
|---|---|
| title | the page's heading |
| description | shown under the title |
| footer | text at the bottom of the page |
| refresh | how often, in seconds, the page reloads itself (300 by default, up to a day) |
| domains | extra domain names that serve the page, such as `status.example.com` |
| theme | `auto`, `light` or `dark` |

And three switches, under the fields: **show tags**, **certificate expiry** and **only last
beat**. `tab` walks through the fields and onto the switches, `space` flips one, `enter` saves.

Everything else the page has — its logo, custom CSS, analytics — stays as it is. Logos and
custom CSS are set in Kuma's web UI.

## Sections

`s` opens the sections editor:

| Key | |
|---|---|
| `a` | add a section |
| `r` | rename the section under the cursor |
| `m` | add a monitor, or a group, to the section under the cursor |
| `d` | remove the monitor under the cursor, or the whole section, from the page |
| `K`/`J` | move the section or monitor up or down |
| `ctrl+s` | save |
| `esc` | back |

Removing a monitor from a page leaves the monitor alone in Kuma.

## Incidents

`i` posts an incident on the page, or edits the one it has: a title, the text (what happened,
and what is being done) and a style — `info`, `warning`, `danger`, `primary`, `light` or `dark`,
switched with `←`/`→`. `ctrl+s` posts it.

`u` takes the incident down, after asking: the page stops showing it, and Kuma keeps it in its
history.

## Delete

`d` deletes the page after you type its slug. Kuma deletes it with its sections and incidents.

## Behind a proxy

Kuma gives a page's sections and incident only on the page itself, so `e`, `s` and `i` read them
over plain HTTP from `<instance URL>/api/status-page/<slug>`. If a proxy asks for a login there,
they say so and save nothing.

## Keys

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
