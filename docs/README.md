# docs

The Docusaurus site served at <https://icortesb.github.io/lazykuma-web/docs/>. Pages live in
`docs/`; the sidebar is generated from its folders.

```sh
npm ci
npm start       # local dev server
npm run build   # what the deploy workflow runs
```

Publishing is done by `.github/workflows/deploy.yml` — see the [repo README](../README.md).
