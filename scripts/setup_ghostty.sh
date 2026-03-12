#!/bin/zsh

set -e

source "$(cd -- "$(dirname -- "$0")" && pwd)/base.sh"

GHOSTTY_CONFIG_DIR="$CONFIG_DIR/ghostty"
TARGET_GHOSTTY_DIR="$USER_CONFIG_DIR/ghostty"

messages=(
  "👻 Starting Ghostty configuration setup..."
  "📁 Target directory: $TARGET_GHOSTTY_DIR"
  "📁 Source directory: $GHOSTTY_CONFIG_DIR"
)

for message in "${messages[@]}"; do
  INFO "$message"
done

if [ ! -d "$USER_CONFIG_DIR" ]; then
  mkdir -p "$USER_CONFIG_DIR"
  INFO "📁 Successfully created directory: $USER_CONFIG_DIR"
fi

if [ -d "$TARGET_GHOSTTY_DIR" ]; then
  BACKUP_DIR="${TARGET_GHOSTTY_DIR}.backup"
  if [ -d "$BACKUP_DIR" ]; then
    rm -rf "$BACKUP_DIR"
  fi

  if mv "$TARGET_GHOSTTY_DIR" "$BACKUP_DIR"; then
    INFO "✅ Successfully backed up directory: $TARGET_GHOSTTY_DIR -> $BACKUP_DIR"
  else
    WARN "⚠️ Failed to backup directory: $TARGET_GHOSTTY_DIR"
    exit 1
  fi

  if rm -rf "$TARGET_GHOSTTY_DIR"; then
    INFO "📁 Successfully removed existing directory: $TARGET_GHOSTTY_DIR"
  else
    WARN "⚠️ Failed to remove existing directory: $TARGET_GHOSTTY_DIR"
    exit 1
  fi
elif [ -L "$TARGET_GHOSTTY_DIR" ]; then
  if rm -f "$TARGET_GHOSTTY_DIR"; then
    INFO "📁 Successfully removed existing symlink: $TARGET_GHOSTTY_DIR"
  else
    WARN "⚠️ Failed to remove existing symlink: $TARGET_GHOSTTY_DIR"
    exit 1
  fi
fi

if ln -s "$GHOSTTY_CONFIG_DIR" "$TARGET_GHOSTTY_DIR"; then
  INFO "🔗 Successfully created symlink: $TARGET_GHOSTTY_DIR -> $GHOSTTY_CONFIG_DIR"
else
  WARN "⚠️ Failed to create symlink from $GHOSTTY_CONFIG_DIR to $TARGET_GHOSTTY_DIR"
  exit 1
fi

INFO "✅ Ghostty configuration setup completed successfully!"
