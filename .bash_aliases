source ~/.bash/aliases.sh
source ~/.bash/functions.sh
source ~/.bash/exports.sh

which kubectl 2>/dev/null 1>&2 && source <(kubectl completion bash) && complete -o default -F __start_kubectl k
which fzf 2>/dev/null 1>&2 && eval "$(fzf --bash)"
which kubefwd 2>/dev/null 1>&2 && source <(kubefwd completion bash)
which helm  2>/dev/null 1>&2 && source <(helm completion bash)
which nelm  2>/dev/null 1>&2 && source <(nelm completion bash)
# git completion
[ -f "/usr/share/bash-completion/completions/git" ] && source "/usr/share/bash-completion/completions/git" && __git_complete g _git_main
