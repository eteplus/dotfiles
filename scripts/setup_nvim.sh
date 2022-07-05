#!/bin/zsh

NVIM_CONFIG_DIR=$HOME/.config/nvim
CONFIG_DIR=$HOME/Workspace/Github/dotfiles/config/nvim

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  mkdir "$NVIM_CONFIG_DIR"
fi

if [[ ( -h "$NVIM_CONFIG_DIR/init.vim" || -f "$NVIM_CONFIG_DIR/init.vim" ) ]]; then
  rm "$NVIM_CONFIG_DIR/init.vim"
fi

if [[ ( -h "$NVIM_CONFIG_DIR/vscode.vim" || -f "$NVIM_CONFIG_DIR/vscode.vim" ) ]]; then
  rm "$NVIM_CONFIG_DIR/vscode.vim"
fi

ln -s $CONFIG_DIR/init.vim $NVIM_CONFIG_DIR/init.vim
ln -s $CONFIG_DIR/vscode.vim $NVIM_CONFIG_DIR/vscode.vim