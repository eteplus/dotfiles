#!/bin/zsh

set -e

source "$(cd -- "$(dirname -- "$0")" && pwd)/base.sh"

INFO "🍞 Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  xcode-select --install || true
else
  INFO "✅ Xcode Command Line Tools already installed"
fi

exit 0

INFO "🤔 Checking for, or Installing Homebrew..."
if [ -z `command -v brew` ]; then
  INFO "🍞 Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi;

INFO "🍺 Updating Homebrew..."
brew update

INFO "🍺 Upgrading Homebrew..."
brew upgrade

INFO "🍺 Installing unix tools..."
brew install zsh

INFO "🍺 Installing fonts..."
brew tap homebrew/cask-fonts
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
brew install bun
brew install uv

INFO "🍞 Installing pnpm"
curl -fsSL https://get.pnpm.io/install.sh | sh -

INFO "🍞 Installing and using the specified version of Node.js"
pnpm env use --global 20

INFO "🍞 Installing npm packages..."
pnpm add eslint whistle whistle.inspect whistle.vase -g

INFO "🍺 Installing apps..."
brew install --cask raycast
brew install --cask google-chrome
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask windsurf
brew install --cask notion
brew install --cask bitwarden
brew install --cask appcleaner
brew install --cask input-source-pro
brew install --cask jordanbaird-ice

INFO "🍺 Cleaning up Homebrew..."
brew cleanup

INFO "✅ Successfully bootstrapped your system!"
