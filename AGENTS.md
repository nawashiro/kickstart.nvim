# Repository Guidelines

This repository is a personal Neovim configuration based on kickstart.nvim. Keep changes small, readable, and modular so settings remain easy to audit.

## Project Structure & Module Organization

- `init.lua`: entry point; core options, keymaps, and plugin bootstrapping.
- `lua/custom/plugins/`: small, focused plugin specs; add one file per plugin or feature.
- `lua/custom/lsp.lua`: LSP, formatter, and tool configuration.
- `lua/kickstart/plugins/`: upstream kickstart modules referenced by `lua/custom/plugins/init.lua`.
- `doc/`: documentation; `doc/kickstart.txt` mirrors kickstart help.
- `tmp/`: local scratch files; avoid relying on it in production configs.

## Build, Test, and Development Commands

This is a config repo; there is no build step. Use Neovim commands for setup and maintenance:

```vim
:Lazy sync        " install/update plugins
:Lazy update      " update plugins
:Mason            " manage external tools
:MasonToolsInstall
:ConformInfo      " formatter status
:checkhealth      " diagnostics
```

External dependencies expected: `git`, `make`, `unzip`, `rg`, `fd`, and a Nerd Font (optional).

## Coding Style & Naming Conventions

- Lua indentation is 2 spaces; keep lines compact and readable.
- Prefer single-purpose modules in `lua/custom/plugins/` (e.g., `formatting.lua`, `lint.lua`).
- Keep `init.lua` minimal; push new behavior into `lua/custom/` modules.
- Use lower_snake_case for Lua locals and filenames.

## Testing Guidelines

There are no automated tests. Validate changes by launching Neovim and running `:checkhealth`, then confirm key workflows (LSP attach, formatting, file search).

## Commit & Pull Request Guidelines

Commit messages are short and action-oriented, often with prefixes like `feat:`, `add:`, `remove:`, or `Revert`.
Follow that style and keep commits focused on one topic.

For pull requests, include:

- A brief summary of the behavior change.
- Any relevant commands or `:help` notes for reviewers.
- Screenshots are not required unless UI behavior changes.

## Configuration Tips

When adding plugins:

1. Create `lua/custom/plugins/<name>.lua` with a lazy.nvim spec.
2. Add it to `lua/custom/plugins/init.lua`.
3. Restart Neovim or run `:Lazy sync`.
