#!/bin/zsh

set -e

source "$(cd -- "$(dirname -- "$0")" && pwd)/base.sh"

LAZYVIM_CONFIG_DIR="$CONFIG_DIR/lazyvim"

messages=(
  "🧵 Starting Neovim configuration setup..."
  "📁 Target directory: $NVIM_CONFIG_DIR"
  "📁 Source directory: $LAZYVIM_CONFIG_DIR"
)

for message in "${messages[@]}"; do
  INFO "$message"
done

if [ ! -d "$USER_CONFIG_DIR" ]; then
  mkdir -p "$USER_CONFIG_DIR"
  INFO "📁 Successfully created directory: $USER_CONFIG_DIR"
fi

if [ -d "$NVIM_CONFIG_DIR" ]; then
  BACKUP_DIR="${NVIM_CONFIG_DIR}.backup"
  if [ -d "$BACKUP_DIR" ]; then
    rm -rf "$BACKUP_DIR"
  fi

  if mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"; then
    INFO "✅ Successfully backed up directory: $NVIM_CONFIG_DIR -> $BACKUP_DIR"
  else
    WARN "⚠️ Failed to backup directory: $NVIM_CONFIG_DIR"
    exit 1
  fi

  if rm -rf "$NVIM_CONFIG_DIR"; then
    INFO "📁 Successfully removed existing directory: $NVIM_CONFIG_DIR"
  else
    WARN "⚠️ Failed to remove existing directory: $NVIM_CONFIG_DIR"
    exit 1
  fi
fi

if ln -s "$LAZYVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR"; then
  INFO "🔗 Successfully created symlink: $NVIM_CONFIG_DIR -> $LAZYVIM_CONFIG_DIR"
else
  WARN "⚠️ Failed to create symlink from $LAZYVIM_CONFIG_DIR to $NVIM_CONFIG_DIR"
  exit 1
fi

INFO "✅ Neovim configuration setup completed successfully!"
