if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
end

if type -q bat
     alias cat="bat"
end
if type -q exa
    alias ls="exa -l -h --git --tree -L 1 -F --icons"
    alias lst="exa -l -h --git --tree -L 1 -F --icons --sort=time"
    alias lss="exa -l -h --git --tree -L 1 -F --icons --sort=size"
    alias lsty="exa -l -h --git --tree -L 1 -F --icons --sort=type"
end
if type -q delta
    alias diff="delta --side-by-side=True"
end
if type -q vim
    set -Ux EDITOR vim
end
if type -q trash
    alias rm="trash"
end