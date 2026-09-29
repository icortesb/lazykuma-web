// @ts-check
import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'lazykuma',
  tagline: 'Uptime Kuma, in the terminal',
  favicon: 'img/favicon.svg',

  headTags: [
    {
      tagName: 'link',
      attributes: {rel: 'alternate icon', href: '/lazykuma-web/docs/img/favicon.ico'},
    },
    {
      tagName: 'link',
      attributes: {rel: 'apple-touch-icon', href: '/lazykuma-web/docs/img/apple-touch-icon.png'},
    },
  ],

  future: {
    v4: true,
  },

  url: 'https://icortesb.github.io',
  baseUrl: '/lazykuma-web/docs/',

  organizationName: 'icortesb',
  projectName: 'lazykuma-web',

  onBrokenLinks: 'throw',

  markdown: {
    hooks: {
      onBrokenMarkdownLinks: 'warn',
    },
  },

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          routeBasePath: '/',
          sidebarPath: './sidebars.js',
          editUrl: 'https://github.com/icortesb/lazykuma-web/edit/main/docs/docs/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: {
        defaultMode: 'dark',
        disableSwitch: false,
        respectPrefersColorScheme: false,
      },
      navbar: {
        title: 'lazykuma',
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'docsSidebar',
            position: 'left',
            label: 'Docs',
          },
          {
            href: 'https://github.com/icortesb/lazykuma',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {label: 'Getting Started', to: '/getting-started/installation'},
              {label: 'Keys', to: '/usage/keys'},
              {label: 'Background alerts', to: '/without-the-tui/background-alerts'},
              {label: 'Changelog', to: '/changelog'},
            ],
          },
          {
            title: 'Project',
            items: [
              {label: 'Source', href: 'https://github.com/icortesb/lazykuma'},
              {label: 'Releases', href: 'https://github.com/icortesb/lazykuma/releases'},
              {label: 'Issues', href: 'https://github.com/icortesb/lazykuma/issues'},
            ],
          },
        ],
        copyright: `lazykuma is MIT licensed. Docs built with Docusaurus.`,
      },
      prism: {
        theme: prismThemes.nightOwlLight,
        darkTheme: prismThemes.nightOwl,
      },
    }),

  themes: [
    [
      require.resolve('@easyops-cn/docusaurus-search-local'),
      /** @type {import('@easyops-cn/docusaurus-search-local').PluginOptions} */
      ({
        hashed: true,
        indexBlog: false,
        docsRouteBasePath: '/',
      }),
    ],
  ],
};

export default config;
