#!/bin/zsh

echo "Checking for, or Installing Oh My Zsh"
if [ -z `command -v omz`]; then
  echo "Oh My Zsh is missing! Installing it..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  source $HOME/.zshrc
fi;

echo "Oh my Zsh: installing plugins and themes"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Oh my Zsh: symlink config file"
cd ~
rm -rf .zshrc
ln -s $HOME/Workspace/Github/dotfiles/config/zshrc .zshrc
ln -s $HOME/Workspace/Github/dotfiles/config/.p10k.zsh .p10k.zsh
source $HOME/.zshrc

echo "Homebrew: installing autojump and fig"
brew reinstall autojump
brew reinstall fig

source $HOME/.zshrc