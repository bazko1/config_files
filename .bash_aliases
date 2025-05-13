source ~/.bash/aliases.sh
source ~/.bash/functions.sh
source ~/.bash/exports.sh

which fzf 2>/dev/null 1>&2 && eval "$(fzf --bash)"
which kubectl 2>/dev/null 1>&2 && source <(kubectl completion bash) && complete -o default -F __start_kubectl k
