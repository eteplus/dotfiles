#!/bin/zsh

set -e

source "$(cd -- "$(dirname -- "$0")" && pwd)/base.sh"

INFO "🤔 Checking for, or Installing Oh My Zsh"
if [ ! -d "$ZSH_DIR" ]; then
  INFO "🍞 Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  eval "$(source $HOME/.zshrc)"
else
  INFO "✅ Oh My Zsh is already installed"
fi

INFO "🧵 Installing plugins and themes"

function INSTALL() {
  local type=$1
  local name=$2
  local repo=$3
  local path="$ZSH_CUSTOM/${type}s/$name"

  if [ -d "$path" ]; then
    WARN "⚠️ Removing existing $path"
    rm -rf "$path"
  fi

  INFO "🍞 Installing $type $repo"
  git clone --depth=1 "$repo" "$path" > /dev/null 2>&1

  if [ $? -ne 0 ]; then
    WARN "⚠️ Failed to install $type $name"
  else
    INFO "✅ Successfully installed $type $name"
  fi
}

INSTALL "theme" "powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"
INSTALL "plugin" "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
INSTALL "plugin" "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
INSTALL "plugin" "zsh-completions" "https://github.com/zsh-users/zsh-completions.git"

WARN "⚠️ Removing existing config files: $HOME/.zshrc $HOME/.p10k.zsh"
rm -rf $HOME/.zshrc $HOME/.p10k.zsh

INFO "🔗 Linking $CONFIG_DIR/zshrc to $HOME/.zshrc"
ln -s $CONFIG_DIR/zshrc $HOME/.zshrc

INFO "🔗 Linking $CONFIG_DIR/p10k.zsh to $HOME/.p10k.zsh"
ln -s $CONFIG_DIR/p10k.zsh $HOME/.p10k.zsh

INFO "🍺 Installing autojump"
brew install autojump --quiet

INFO "✅ Successfully configured Oh My Zsh and plugins"

exec zsh -l
