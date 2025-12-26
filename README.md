# kickstart.nvim セットアップメモ

kickstart.nvim をベースに、読みやすさと軽さを優先した個人用セットアップです。必要なものは `lua/custom/plugins` に小さく追加し、不要になったらファイルごと削除する運用にしています。

## この構成のポイント

- プラグイン管理は lazy.nvim。kickstart 付属の一部（debug/indent_line/autopairs/gitsigns）も `custom/plugins/init.lua` で明示的に有効化。
- UI/操作まわり: tokyonight-night テーマ、`mini.statusline` / `mini.ai` / `mini.surround`、`indent-blankline`、`todo-comments`。
- ナビゲーション: Telescope 一式に加え、Neo-tree のトグル/リビール (`<leader>e`, `<leader>r`, `\` )。
- Git: gitsigns の推奨キーマップを導入（`[c` / `]c` でハンク移動、`<leader>hs/hr/hp/hd` など）。
- LSP/補完: `nvim-lspconfig` + `mason` + `mason-tool-installer` に `blink.cmp` + `LuaSnip` を組み合わせたシンプル構成。デフォルトサーバーは `ts_ls` と `lua_ls`。
- Markdown: `marksman` を追加して見出し/リンクなどの補完を有効化。
- デバッグ: `nvim-dap` + `dap-ui` + `dap-go`。`<F5>/<F1>/<F2>/<F3>/<F7>` を基本に利用。
- フォーマット: `conform.nvim`。Lua は `stylua`、Web 系は `prettierd`、保存時自動整形（c/cpp は除外）。`<leader>f` で手動実行。
- リント: `nvim-lint` は土台のみ用意し、デフォルトの linters は空。必要なものを `require('lint').linters_by_ft` に追加して使う。

## 使い方

- リーダーキー: `<Space>`
- ファイル検索: `<leader>sf`（Telescope）
- バッファ切替: `<leader><leader>`
- 設定/ヘルプ検索: `<leader>sh`, `<leader>sk`, `<leader>ss`
- Neo-tree: `<leader>e` トグル / `<leader>r` フォーカス / `\` で現在ファイルを開閉
- gitsigns: `[c` / `]c` でハンク移動、`<leader>hs` ステージ、`<leader>hr` リセット、`<leader>hp` プレビュー
- DAP: `<F5>` 実行、`<F1>/<F2>/<F3>` ステップ、`<F7>` で UI トグル
- 診断: `<leader>q` で loclist に診断を集約
- ウィンドウ移動: `<C-h/j/k/l>`
- ハイライト解除: `<Esc>`
- フォーマット: 保存時に自動実行。手動なら `<leader>f`

## フォーマット

- `conform.nvim` を `BufWritePre` で実行（c/cpp のみ除外）。`format_on_save` で LSP フォーマットはオフ。
- Lua は `stylua`、Web 系は `prettierd`（js/ts/jsx/tsx/vue/svelte/css/scss/less/html/json/jsonc/yaml/markdown/mdx/graphql/handlebars など）。
- `:ConformInfo` で有効なフォーマッタを確認。`<leader>f` で手動整形。
- Mason が `stylua` / `prettierd` を自動インストールします。

## リント

- `nvim-lint` を読み込むだけの最小設定。`BufEnter` / `BufWritePost` / `InsertLeave` で `lint.try_lint()` が走ります。
- デフォルト linters は空なので、必要な言語だけ `require('lint').linters_by_ft` に追記してください。

## LSP と補完

- `mason-lspconfig` で `cssls` / `eslint` / `html` / `jsonls` / `tailwindcss` / `ts_ls` を ensure。`custom/lsp.lua` に追加すれば `mason-tool-installer` 経由で自動導入されます。
- `blink.cmp` + `LuaSnip` を採用。`<c-space>` でドキュメント表示、`<c-n>/<c-p>` で候補移動などデフォルトキーマップで運用。

## 構成の見方

- `init.lua`: 基本設定と主要プラグインの登録。行動やキーマップはここで確認。
- `lua/custom/plugins/*.lua`: 追加プラグインを小分けに定義。不要になったらファイルごと削除するだけ。
- `lua/kickstart/plugins/*`: kickstart 付属のモジュール。使うものだけを `custom/plugins/init.lua` から読み込んでいます。

## プラグインを追加する

1. `lua/custom/plugins` に新しいファイルを作り、lazy.nvim の仕様に沿ったテーブルを `return` する。
2. `lua/custom/plugins/init.lua` のテーブルに `require 'custom.plugins.<name>'` を足す。
3. Neovim を再起動するか `:Lazy sync` を実行。

## メンテナンス

- アップデート: `:Lazy update` でプラグインを更新。
- LSP/ツール確認: `:Mason` でインストール状態を確認。必要なら `:MasonToolsInstall`.
- 設定変更: なるべく `lua/custom/plugins` 側に追記し、`init.lua` はシンプルに保つ。
- 動作確認: `:checkhealth` でヘルスチェック。フォーマッタは `:ConformInfo` が便利。

## 初期セットアップ

Neovim の設定ディレクトリにクローンし、起動するだけで自動セットアップされます。

```sh
git clone <this-repo> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim
```

必要な外部コマンド: `git`, `make`, `unzip`, `ripgrep`, `fd`、Nerd Font（任意）

この構成を土台に、必要な機能だけを小さく積み上げていってください。
