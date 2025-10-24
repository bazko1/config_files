# functions

gsl(){ git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'; }
gfl() { git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs -I % git diff-tree --no-commit-id --name-only -r %'; }
docker_rm_unnamed() { docker image rm "$(docker image ls | grep '^<none>' | awk '{print $3}')"; }
sshf() { fzf  --preview 'echo {1}@{2}' --bind 'enter:become(ssh {1}@{2})' < ~/.scripts/ssh_connections.txt; }
__git_branch__() { git rev-parse --is-inside-work-tree 1>/dev/null 2>/dev/null && echo "(""$(git branch --show-current)"") "; }
n() {
  if [ -n "$NNNLVL" ] && [ "$NNNLVL" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  export NNN_TMPFILE="$HOME/.config/nnn/.lastd"
  nnn -adeHo "$@"
  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

jwt_decode(){
    jq -R 'split(".") | .[1] | @base64d | fromjson' <<< "$1"
}
