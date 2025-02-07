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

