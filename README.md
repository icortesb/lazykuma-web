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

The install commands on the landing page and in `docs/docs/getting-started/installation.md`
name a release (`v0.7.0`); bump them with each lazykuma release.

## Building

The `.github/workflows/deploy.yml` workflow builds `docs/`, combines it with `landing/` (copied
to the site root as-is), and publishes to GitHub Pages on every push to `main`.
