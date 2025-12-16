/** Prettier configuration for kickstart.nvim */
module.exports = {
  plugins: ['./prettier-plugins/markdown-cjk-spacing.js'],
  overrides: [
    {
      files: '*.md',
      options: {
        proseWrap: 'preserve',
      },
    },
  ],
}
