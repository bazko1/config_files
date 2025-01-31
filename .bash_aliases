# functions
gsl(){ git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'; }
gfl() { git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs -I % git diff-tree --no-commit-id --name-only -r %'; }
docker_rm_unnamed() { docker image rm "$(docker image ls | grep '^<none>' | awk '{print $3}')"; }
sshf() { fzf  --preview 'echo {1}@{2}' --bind 'enter:become(ssh {1}@{2})' < ~/.scripts/ssh_connections.txt; }
__git_branch__() { git rev-parse --is-inside-work-tree 1>/dev/null 2>/dev/null && echo "(""$(git branch --show-current)"") "; }


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
alias watch_go_lint='watchexec -e go -- golangci-lint run ./...'
alias watch_go_test='watchexec -e go -- go test ./...'
alias fcd='`__fzf_cd__`'
alias v=nvim
alias k=kubectl
alias d=docker
alias disable_lockout='xset s off -dpms'
alias hdmi_display='xrandr --auto --output eDP-1-1 --off --output HDMI-1-1 --primary'

# exports
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin:/opt/nvim-linux64/bin"
export EDITOR=nvim
export VISUAL=nvim
