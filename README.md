# kickstart.nvim セットアップメモ

このリポジトリは kickstart.nvim をベースに、余計な肥大化を避けつつ日常使いに必要な最低限の機能だけを整えた構成です。リーダブルでシンプル、必要なものは `lua/custom/plugins` に小さく積み上げる方針です。

- プラグイン管理: lazy.nvim
- LSP: `nvim-lspconfig` + `mason` + `mason-tool-installer`
- 補完: `blink.cmp`（余計な重複を排除）
- フォーマッタ: conform.nvim + Prettier（対応言語は保存時自動整形）
- 主な追加: Neo-tree, gitsigns, autopairs, obsidian.nvim など

## 使い方
- リーダーキー: `<Space>`
- ファイル検索: `<leader>sf`（Telescope）
- バッファ切替: `<leader><leader>`
- 設定/ヘルプ検索: `<leader>sh`, `<leader>sk`, `<leader>ss`
- Neo-tree: `<leader>e` トグル / `<leader>r` フォーカス / `\` で現在ファイルを開閉
- 診断: `<leader>q` で loclist に診断を集約
- ウィンドウ移動: `<C-h/j/k/l>`
- ハイライト解除: `<Esc>`
- フォーマット: 保存時に自動実行。手動なら `<leader>f`

## フォーマッタ設定（Prettier）
- conform.nvim で `BufWritePre` に自動整形を掛けています。c/cpp だけは除外。
- Prettier がデフォルトで扱う言語を一通り設定済み（js/ts/jsx/tsx/vue/svelte/css/scss/less/html/json/jsonc/yaml/markdown/mdx/graphql/handlebars など）。
- Lua は `stylua` で整形。
- Mason が `prettier` を自動インストールします。追加で必要な場合は `:Mason` からインストール状況を確認してください。
- 一括整形のデフォルトキーマップは `<leader>f`。追加設定は不要です。

## 構成の見方
- `init.lua`: 基本設定と主要プラグインの登録。行動やキーマップはここで確認。
- `lua/custom/plugins/*.lua`: 追加プラグインを小分けに定義。不要になったらファイルごと削除するだけ。
- `lua/kickstart/plugins/*`: kickstart 付属のモジュール。必要なものだけを `custom/plugins/init.lua` から読み込んでいます。

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

必要な外部コマンド: `git`, `make`, `unzip`, `ripgrep`, `fd`, `prettier`（Mason が導入）, Nerd Font（任意）

この構成を土台に、必要な機能だけを小さく積み上げていってください。
