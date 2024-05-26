# functions
gsl(){ git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'; }
gfl() { git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs -I % git diff-tree --no-commit-id --name-only -r %'; }
docker_rm_unnamed() { docker rmi "$(docker images | grep '^<none>' | awk '{print $3}')"; }

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
export CONFIG_DIR=$DIR

# aliases
alias docker_rm_stoped='docker rm $(docker ps -a -q)'
alias shortps="PS1='\[\033[01;34m\]\W\[\033[00m\]\$ '"
alias start_nemo='nemo . 2>/dev/null &'
alias v=nvim
alias watch_go_lint='watchexec -e go -- golangci-lint run ./...'
alias watch_go_test='watchexec -e go -- go test ./...'
alias fcd='`__fzf_cd__`'

# exports
if [ -f "/etc/wsl.conf" ]; then
  #TODO:
  export ALACRITTY_CONFIG=TODO
else
  export ALACRITTY_CONFIG=~/.config/alacritty/alacritty.yml
fi

export PATH="$PATH:/opt/nvim-linux64/bin:/usr/local/go/bin:$HOME/go/bin"
export EDITOR=nvim
export VISUAL=nvim
