# lazykuma-web

Website for [lazykuma](https://github.com/icortesb/lazykuma), a terminal UI for Uptime Kuma 2,
deployed to GitHub Pages at <https://icortesb.github.io/lazykuma-web/>.

- `docs/` — Docusaurus documentation site, served at `/docs/`
- `landing/` — static landing page, served at the site root, no build step
- `demo/` — the script that records `landing/assets/demo.gif` against throwaway Kuma containers

## Developing the docs

```sh
cd docs
npm ci
npm start
```

## Developing the landing page

`landing/` is plain HTML/CSS/JS — open `landing/index.html` in a browser, or serve it locally:

```sh
cd landing
python3 -m http.server 8000
```

Each lazykuma release, bump the version named in:

- the install commands in `landing/index.html` and `docs/docs/getting-started/installation.md`
  (`v0.7.0`, `lazykuma_0.7.0_…`)
- `softwareVersion` in the JSON-LD block of `landing/index.html`
- `docs/docs/changelog.md`, with the new release's notes

## Building

The `.github/workflows/deploy.yml` workflow builds `docs/`, combines it with `landing/` (copied
to the site root as-is), and publishes to GitHub Pages on every push to `main`.
