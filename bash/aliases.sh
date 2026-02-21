# aliases
[ -z "$FISH_VERSION" ] && shopt -s expand_aliases

alias docker_rm_stoped='docker rm $(docker ps -a -q)'
alias shortps="PS1='\[\033[01;34m\]\W\[\033[00m\]\$ '"
alias start_nemo='GTK_THEME=Adwaita:dark nemo . 2>/dev/null &'
alias watch_go_lint='watchexec -e go -- golangci-lint run ./...'
alias watch_go_test='watchexec -e go -- go test ./...'
alias fcd='`__fzf_cd__`'
alias v=nvim
alias vm='NVIM_APPNAME=nvim-minimal nvim'
alias oldv='nvim -u $HOME/gitworkspace/config_files/init.lua'
alias g=git
alias k=kubectl
alias d=docker
alias disable_lockout='xset s off -dpms'
alias hdmi_display='xrandr --auto --output eDP-1-1 --off --output HDMI-1-1 --primary'
alias myconfig_update='git -C $CONFIG_DIR pull'
alias myconfig_install='$CONFIG_DIR/install.sh'
alias lss='ls -larth'
alias kind_set_config='kind get kubeconfig --name $(kind get clusters) >  ~/.kube/config '
alias save_clipboard_img='xclip -selection clipboard -t image/png -o > '
alias pandock='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/core'
alias jwtDecode='jq -R '"'"'split(".") | .[1] | @base64d | fromjson'"'"
