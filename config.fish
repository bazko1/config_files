if status is-interactive
    # Commands to run in interactive sessions can go here
     # fish_vi_key_bindings
     fish_hybrid_key_bindings
end

source ~/.bash/aliases.sh
eval "$(fzf --fish)"
