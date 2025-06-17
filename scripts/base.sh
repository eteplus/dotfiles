#!/bin/zsh

DATE=$(date '+%Y-%m-%d %H:%M:%S')

function LOG() {
  echo -e "[$DATE] $1"
}

function INFO() {
  echo -e "\033[32m[$DATE] INFO: $1\033[0m"
}

export INFO

function WARN() {
  echo -e "\033[33m[$DATE] WARN: $1\033[0m" >&2
}

export WARN

function ERROR() {
  echo -e "\033[31m[$DATE] ERROR: $1\033[0m" >&2
}

export ERROR

function MAX_LENGTH() {
  local lines=("$@")
  local max=0
  for line in "${lines[@]}"; do
    if (( ${#line} > max )); then
      max=${#line}
    fi
  done
  echo "$max"
}

export MAX_LENGTH

function SEPARATOR() {
  local length=$1
  LOG $(printf '%*s' "$((length + 6))" | tr ' ' '━')
}

export SEPARATOR

DIR=$(cd -- "$(dirname -- "$0")/.." && pwd)

export SCRIPTS_DIR=$DIR/scripts
export CONFIG_DIR=$DIR/config
export ZSH_DIR=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$ZSH_DIR/custom
export ZSH_CONFIG_FILE=$HOME/.zshrc
export USER_CONFIG_DIR=$HOME/.config
export NVIM_CONFIG_DIR=$USER_CONFIG_DIR/nvim

messages=(
  "🏠 Home directory:          $HOME"
  "📁 Config directory:        $CONFIG_DIR"
  "📜 Scripts directory:       $SCRIPTS_DIR"
  "🗃️  User config directory:   $USER_CONFIG_DIR"
  "🚀 Neovim config directory: $NVIM_CONFIG_DIR"
  "🗄️  ZSH directory:           $ZSH_DIR"
  "🔧 ZSH custom directory:    $ZSH_CUSTOM"
  "⚙️  ZSH config file:         $ZSH_CONFIG_FILE"
)

max_length=$(MAX_LENGTH "${messages[@]}")

SEPARATOR $max_length
for message in "${messages[@]}"; do
  LOG "$message"
done
SEPARATOR $max_length
