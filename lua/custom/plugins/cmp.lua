return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer', -- バッファ内のテキスト用ソース [1]
    'hrsh7th/cmp-path', -- ファイルシステムパス用ソース [1]
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*', -- LuaSnipのスニペットエンジン [1]
      build = 'make install_jsregexp',
    },
    'rafamadriz/friendly-snippets', -- スニペットコレクション [1]
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load() -- VSCode形式のスニペットをロード [1]

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        -- ドキュメントを下にスクロール [1]
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ドキュメントを上にスクロール [1]
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- 補完ウィンドウを開く [1]
        ['<C-Space>'] = cmp.mapping.complete(),
        -- 補完ウィンドウを閉じる [1]
        ['<C-e>'] = cmp.mapping.close(),
        -- 補完を確定する（置換し、選択を有効にする） [1]
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' }, -- LSPクライアントから補完を取得 [1]
        { name = 'luasnip' }, -- LuaSnipからスニペットを取得 [1]
        { name = 'buffer' }, -- 現在のバッファから単語を取得 [1]
        { name = 'path' }, -- ファイルパスから補完を取得 [1]
      },
    }

    -- Neovimの組み込み設定を調整 [1]
    vim.cmd [[ set completeopt=menuone,noinsert,noselect highlight! default link CmpItemKind CmpItemMenuDefault ]]
  end,
}
