# functions
fcd(){ cd "$(find . -maxdepth 1 -type d | fzf)" || return; }
gsl(){ git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'; }
gfl() { git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs -I % git diff-tree --no-commit-id --name-only -r %'; }
docker_rm_unnamed() { docker rmi "$(docker images | grep '^<none>' | awk '{print $3}')"; }

# aliases
alias docker_rm_stoped='docker rm $(docker ps -a -q)'
alias shortps="PS1='\[\033[01;34m\]\W\[\033[00m\]\$ '"
alias start_nemo='nemo . 2>/dev/null &'
alias vim=nvim

# exports
if [ -f "/etc/wsl.conf" ]; then
  #TODO:
  export ALACRITTY_CONFIG=TODO
else
  export ALACRITTY_CONFIG=~/.config/alacritty/alacritty.yml
fi
