-- You can add your own plugins here or in other files in this directory!
-- I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'custom.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'custom.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',
  require 'custom.plugins.obsidian',
  require 'custom.plugins.cmp',

  vim.keymap.set({ 'n', 'x' }, 'gp', '"+p'),
}

