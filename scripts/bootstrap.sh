#!/bin/zsh

set -e

source "$(cd -- "$(dirname -- "$0")" && pwd)/base.sh"

INFO "🍞 Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  xcode-select --install || true
else
  INFO "✅ Xcode Command Line Tools already installed"
fi

INFO "🤔 Checking for, or Installing Homebrew..."
if [ ! -f "/opt/homebrew/bin/brew" ]; then
  INFO "🍞 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  INFO "✅ Homebrew already installed"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

INFO "🍺 Updating Homebrew..."
brew update

INFO "🍺 Upgrading Homebrew..."
brew upgrade

INFO "🍺 Installing unix tools..."
brew install zsh

INFO "🍺 Installing fonts..."
brew install --cask font-fira-code
brew install --cask font-maple-mono-nf-cn
brew install --cask font-hack-nerd-font

INFO "🍺 Installing binaries and other packages..."
brew install git
brew install corkscrew
brew install tree
brew install tree-sitter
brew install neovim
brew install tmux
brew install fzf
brew install oven-sh/bun/bun
brew install uv
brew install im-select

INFO "🍞 Installing pnpm"
curl -fsSL https://get.pnpm.io/install.sh | sh -
eval "$(source $HOME/.zshrc)"

INFO "🍞 Installing and using the specified version of Node.js"
pnpm env use --global 24

INFO "🍞 Installing npm packages..."
pnpm add eslint whistle whistle.inspect whistle.vase -g

INFO "🍺 Installing apps..."
brew install --cask raycast
brew install --cask google-chrome
brew install --cask ghostty
brew install --cask windsurf
brew install --cask notion
brew install --cask bitwarden
brew install --cask appcleaner
brew install --cask input-source-pro
brew install --cask jordanbaird-ice

INFO "🍺 Cleaning up Homebrew..."
brew cleanup

INFO "✅ Successfully bootstrapped your system!"
