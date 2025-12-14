return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = false }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = function()
      -- Keep Prettierd as primary and Prettier as fallback; adjust here if you want only one.
      local prettier_fts = {
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'vue',
        'svelte',
        'css',
        'scss',
        'less',
        'html',
        'json',
        'jsonc',
        'yaml',
        'markdown',
        'markdown.mdx',
        'graphql',
        'handlebars',
      }

      local formatters_by_ft = {
        lua = { 'stylua' },
      }

      for _, ft in ipairs(prettier_fts) do
        formatters_by_ft[ft] = { 'prettierd' }
      end

      -- Explicit allow list for using LSP formatting on save.
      -- Set a filetype to true when you intentionally want the LSP formatter instead of external tools.
      local lsp_format_allow = {}

      return {
        notify_on_error = true,
        format_on_save = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          local disable_filetypes = { c = true, cpp = true }

          if disable_filetypes[ft] then
            return nil
          end

          return {
            timeout_ms = 3000,
            lsp_format = lsp_format_allow[ft] or false,
          }
        end,
        formatters_by_ft = formatters_by_ft,
      }
    end,
  },
}
