if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_vi_key_bindings
    fish_hybrid_key_bindings
end

set fish_greeting
source ~/.bash/aliases.sh
eval "$(fzf --fish)"

set -gx CONFIG_DIR (dirname (realpath (status -f)))
set -gx EDITOR nvim
set -gx VISUAL nvim
set PATH -gx "$PATH:/usr/local/go/bin:$HOME/go/bin:/opt/nvim-linux64/bin:$HOME/.cargo/bin:$HOME/.scripts:$HOME/bin"

function n
    if [ -n "$NNNLVL" ] && [ "$NNNLVL" -ge 1 ]
        echo "nnn is already running"
        return
    end

    set NNN_TMPFILE "$HOME/.config/nnn/.lastd"

    nnn -adeHo "$argv"
    if [ -f "$NNN_TMPFILE" ]
        source "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" >/dev/null
    end
end
function docker_rm_unnamed
    docker image rm $(docker image ls | grep '^<none>' | awk '{print $3}')
end
