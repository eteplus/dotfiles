#!/bin/zsh

echo "Installing Xcode Command Line Tools..."
xcode-select --install

echo "Checking for, or Installing Homebrew..."
if [ -z `command -v brew` ]; then
  echo "Brew is missing! Installing it..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi;

echo "Homebrew: updating..."
brew update

echo "Homebrew: upgrading..."
brew upgrade

echo "Homebrew: updating unix tools..."
brew install zsh

echo "Homebrew: install fonts"
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-hack-nerd-font

echo "Homebrew: installing binaries and other packages..."
brew install git
brew install corkscrew
brew install tree
brew install neovim
brew install tmux

echo "Homebrew: cleaning up..."
brew cleanup

echo "Node: install pnpm"
curl -fsSL https://get.pnpm.io/install.sh | sh -

echo "Node: install and use the specified version of Node.js"
pnpm env use --global 18

echo "Node: installing npm packages..."
pnpm add typescript eslint whistle whistle.inspect whistle.vase -g

echo "Homebrew Cask: installing apps..."
brew install --cask raycast
brew install --cask google-chrome
brew install --cask sourcetree
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask bitwarden
brew install --cask rectangle

echo "Homebrew: cleaning up..."
brew cleanup
