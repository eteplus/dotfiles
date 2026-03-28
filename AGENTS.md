# AGENTS.md

This file provides guidance to AI coding assistants (Claude Code, Cursor, Windsurf, OpenCode, Codex, etc.) when working with code in this repository.

## Overview

macOS dotfiles repository for personal development environment. Configs are stored in `config/` and symlinked to their system locations via setup scripts.

## Setup Commands

```bash
# Full system bootstrap (Homebrew, CLI tools, fonts, apps)
./scripts/bootstrap.sh

# Individual setup scripts
./scripts/setup_omz.sh      # Oh My Zsh + plugins + symlink zshrc/p10k
./scripts/setup_nvim.sh     # Symlink nvim config to ~/.config/nvim
./scripts/setup_ghostty.sh  # Symlink ghostty config to ~/.config/ghostty
```

All scripts source `scripts/base.sh` for shared logging helpers (INFO, WARN, ERROR) and path variables.

## Architecture

### Symlink Strategy

Setup scripts create symlinks from this repo into the system:
- `config/zshrc` -> `~/.zshrc`
- `config/p10k.zsh` -> `~/.p10k.zsh`
- `config/nvim/` -> `~/.config/nvim/`
- `config/ghostty/` -> `~/.config/ghostty/`
- `.tmux.conf` must be manually copied/linked to `~/.tmux.conf`

### Shell Configuration (`config/zshrc`)

Sources additional files conditionally:
- `config/aliases` — shared aliases (always loaded)
- `config/functions` — shell functions (loaded if exists)
- `config/aliases-internal` — work-specific aliases (gitignored, loaded if exists)
- `config/tokens` — API tokens/secrets (gitignored, loaded if exists)

### Neovim (`config/nvim/`)

Based on **LazyVim** starter template. Extras enabled: biome formatting, JSON, Markdown, TypeScript, Vue, VSCode integration. Lua formatting uses StyLua (`stylua.toml`).

### Sensitive Files

`config/aliases-work` and `config/tokens` are gitignored — never commit these.

## Conventions

- Setup scripts use `set -e` and source `base.sh` at the top
- Setup scripts back up existing configs before overwriting (move to `*.backup`)
- Shell scripts use `#!/bin/zsh`
- Tmux prefix is `C-x` (not default `C-b`)
