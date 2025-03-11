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
  [ -d "${INSTALL_DIR}/$2" ] && ! $FORCE && return
  ln "$args" "${SCRIPT_DIR}/$1" "${INSTALL_DIR}/$2"
}

createLink ".gitconfig" ".gitextra"
git config --global include.path .gitextra
createLink ".inputrc" ".inputrc"
createLink ".tmux.conf" ".tmux.conf"

. /etc/os-release
if [ "$ID" == "rhel" ]; then
  mkdir -p "${INSTALL_DIR}/.bashrc.d"
  createLink ".bash_aliases" ".bashrc.d/bash_aliases"
else
  createLink ".bash_aliases" ".bash_aliases"
fi
createLink "bash/" ".bash"

mkdir -p "${INSTALL_DIR}/.config/nvim"
createLink "init.lua" ".config/nvim"

mkdir -p "${INSTALL_DIR}/.config/fish"
createLink "config.fish" ".config/fish/config.fish"

mkdir -p "${INSTALL_DIR}/.config/fish/functions"
createLink "fish/functions/fish_prompt.fish" ".config/fish/functions/fish_prompt.fish"
createLink "fish/functions/fish_user_key_bindings.fish" ".config/fish/functions/fish_user_key_bindings.fish"

mkdir -p "${INSTALL_DIR}/.config/i3"
createLink "i3/config" ".config/i3"
createLink "i3status.conf" ".i3status.conf"

mkdir -p "${INSTALL_DIR}/.config/rofi"
createLink "config.rasi" ".config/rofi"
createLink "onedark.rasi" ".config/rofi"

createLink "scripts" ".scripts"

if ! [ -f "/etc/wsl.conf" ]; then
  mkdir -p "${INSTALL_DIR}/.config/alacritty"
  createLink "alacritty-linux.yml" ".config/alacritty/alacritty.yml"
  createLink "wezterm-linux.lua" ".wezterm.lua"
else
  # FIXME: This should be taken via cmd.exe but need to fix some decoding issues.
  WIN_USER="${WIN_USER:-bazyli}"
  # links does not work cross platform so we just make copy
  cp "alacritty-windows.yml" "/mnt/c/Users/${WIN_USER}/AppData/Roaming/alacritty/alacritty.yml"
  cp "wezterm-windows.lua" "/mnt/c/Users/${WIN_USER}/.wezterm.lua"
fi
