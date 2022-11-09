if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
end

alias ls="exa -l -h --git --tree -L 1 -F --icons"
alias lst="exa -l -h --git --tree -L 1 -F --icons --sort=time"
alias lss="exa -l -h --git --tree -L 1 -F --icons --sort=size"
alias lsty="exa -l -h --git --tree -L 1 -F --icons --sort=type"
set -Ux EDITOR vim

