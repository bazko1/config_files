#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# User definable variables
INSTALL_DIR="${INSTALL_DIR:-$HOME}"
FORCE="${FORCE:-false}"

echo "Installing configuration to $INSTALL_DIR"

createLink ()
{
  args="-s"
  $FORCE && args+="f"
  ln "$args" "${SCRIPT_DIR}/$1" "${INSTALL_DIR}/$2"
}

createLink ".gitconfig" ".gitconfig"
createLink ".inputrc" ".inputrc"
createLink ".tmux.conf" ".tmux.conf"
createLink ".bash_aliases" ".bash_aliases"

mkdir -p "${INSTALL_DIR}/.config/nvim"
createLink "init.lua" ".config/nvim"

if ! [ -f "/etc/wsl.conf" ]; then
  mkdir -p "${INSTALL_DIR}/.config/alacritty"
  createLink "alacritty-linux.yml" ".config/alacritty/alacritty.yml"
fi
