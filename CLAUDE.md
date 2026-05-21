# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles tracked under `~/.config`. Tools covered: Neovim (`nvim/`), Zsh (`zsh/`), Tmux (`tmux/`), Aerospace (macOS tiling WM, `aerospace/`), Lazygit (`lazygit/`), Ghostty (`ghostty/`), Alacritty (`alacritty/`). The repo is used on both macOS and Linux — aerospace is macOS-only but lives in the repo regardless, and other platform-specific bits (homebrew PATH, Ghostty terminfo path, the multi-user `brew` alias, BSD vs GNU `ls` coloring, fzf's macOS `XDG_RUNTIME_DIR` fallback) are guarded by capability checks (`[ -d ... ]`, `command -v ...`, `[[ "$OSTYPE" == darwin* ]]`) so a single config tree boots cleanly on both OSes. When adding new shell or nvim config that depends on a Mac-only path or tool, follow the same pattern — guard, don't branch on uname unless you must.

## Gitignore is an inverse allowlist

`.gitignore` starts with `*` and re-includes specific paths with `!`. **A new config file is invisible to git until it is whitelisted in `.gitignore`.** When adding a new tool, add both the directory and the specific file(s) — e.g. `!newtool` and `!newtool/config.toml`. Whole-directory whitelists alone won't pick up nested files.

## Machine-local zsh files (not in repo)

`zsh/.zshenv` and `zsh/.zshrc` both conditionally source `~/.config/zsh/custom/{zshenv,zshrc}` (guarded with `[ -f ... ] && source ...` so missing files are silent). The `custom/` directory is intentionally untracked and holds per-machine secrets, PATH entries, and aliases. Do not commit `zsh/custom/`.

## Neovim architecture

Entry point `nvim/init.lua` loads four modules from `nvim/lua/config/`: `settings`, `lazy`, `colors`, `keymaps`. The `lazy.lua` module bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim) and auto-imports every file under `nvim/lua/plugins/` as a plugin spec — **dropping a new file in `plugins/` is enough to register a plugin; no manual wiring needed.**

Leader is `<space>` (both `mapleader` and `maplocalleader`). Which-key groups under `<leader>` are declared in `plugins/which-key.lua` — when adding a new keymap group prefix, register it there so the popup labels it.

### LSP wiring (`plugins/lsp.lua`)

- Capabilities come from `blink.cmp` (not nvim-cmp).
- Per-server config uses the new `vim.lsp.config(name, {...})` API. Dart is intentionally commented out because Dart LSP is configured by `flutter-tools.nvim` instead (`plugins/dart.lua`); don't re-enable `dartls` here without removing flutter-tools' version.
- A `RaffLspAttach` autocmd installs the buffer-local keymaps (`gd`, `gr`, `<leader>ca`, etc.) and, if the client supports formatting, registers a `BufWritePre` format hook on a separate `RaffLspFormatOnSave` group (cleared per-buffer to avoid duplicate registration).
- There is a non-trivial monkey-patch of `lspsaga.diagnostic.goto_pos`: Neovim 0.12 made `vim.diagnostic.jump`'s `on_jump` async, which closed the saga float before code-action enrichment ran. The patch reopens the float synchronously inside `vim.schedule` after the jump. Preserve this behavior if upgrading lspsaga.

### Dart/Flutter (`plugins/dart.lua`)

flutter-tools is configured with `onlyAnalyzeProjectsWithOpenFiles = true`, `debounce_text_changes = 500`, and excludes `~/.pub-cache`, `~/fvm`, `build`, `.dart_tool`, `.android`, `.ios` from analysis. This is a deliberate perf trade-off (see commits `469c7b7`, `c9ed872`) — removing those exclusions will tank LSP responsiveness in larger Flutter apps.

### Other plugin notes

- `plugins/fzf.lua` forcibly sets `XDG_RUNTIME_DIR` to `/tmp/nvim-$USER` on startup. This is a macOS workaround (no `/run`); leave it in place.
- `plugins/snacks.lua` builds its own LSP-progress notifier on `LspProgress` autocmds and enables `Snacks.input` to override `vim.ui.input` on `VeryLazy`.
- Format-on-save is registered in **two** places: `plugins/lsp.lua` (generic LspAttach) and `plugins/dart.lua` (flutter-tools' own `on_attach`). Don't add a third.

## Tmux

Prefix is `C-Space`. Panes/windows are 1-indexed with `renumber-windows on`. Pane navigation via `h/j/k/l` after prefix; window switching with `M-H`/`M-L` (no prefix). Catppuccin Mocha theme; plugins managed by TPM, auto-installed on first run.

## Commands

- Reload tmux config: prefix + `r` (rebound to `source-file ~/.config/tmux/tmux.conf`).
- Reload aerospace: enter service mode with `alt-shift-;`, then `esc` (bound to `reload-config`).
- Lazy plugin sync: `:Lazy sync` inside nvim. Lockfile lives at `nvim/lazy-lock.json` and **is committed** — bump it intentionally.
- Treesitter parsers: `:TSUpdate` (runs automatically on plugin install via `build`).
