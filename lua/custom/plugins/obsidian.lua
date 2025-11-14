return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "zettelkasten",
        path = "/workspace/zettelkasten",
      },
    },
    templates = {
      folder = "projects/00 system-management area/00 system-management category/00.11 nvim template",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S+09:00",
      substitutions = {
        datetime = function()
          return os.date("%Y%m%d%H%M%S", os.time() + 9 * 60 * 60)
        end,
        datetimeFormat = function()
          return os.date("%Y-%m-%dT%H:%M:%S+09:00", os.time() + 9 * 60 * 60)
        end,
      },
    },
    -- see below for full list of options 👇
  },
}