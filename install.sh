#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

force=false

createHomeLink ()
{
  args="-s"
  $force && args+=" -f"
  ln "$args" "${SCRIPT_DIR}/$1" "${HOME}/$2"
}

createLink ".gitconfig" ".gitconfig"
createLink ".inputrc" ".inputrc"
createLink ".tmux.conf" ".tmux.conf"
createLink ".bash_aliases" ".bash_aliases"

mkdir -p "${HOME}/.config/nvim" 
createLink "init.lua" ".config/nvim"

bashAlias="[ -f ~/.aliasrc ] && . ./.aliasrc"

