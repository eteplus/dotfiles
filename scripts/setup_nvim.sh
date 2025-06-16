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

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  if mkdir -p "$NVIM_CONFIG_DIR"; then
    INFO "✅ Successfully created directory: $NVIM_CONFIG_DIR"
  else
    WARN "⚠️ Failed to create directory: $NVIM_CONFIG_DIR"
    exit 1
  fi
else
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
