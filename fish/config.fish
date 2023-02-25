# >>> conda initialize >>>
if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    eval /home/dev/mambaforge/bin/conda "shell.fish" "hook" $argv | source
end

if test -f "/home/dev/mambaforge/etc/fish/conf.d/mamba.fish"
	source "/home/dev/mambaforge/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<

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
    alias diff="delta --side-by-side"
end
if type -q vim
    set -Ux EDITOR vim
end
if type -q trash
    alias rm="trash"
end
if test -d $HOME/go/bin/
     fish_add_path $HOME/go/bin/
end
if test -d $HOME/.cargo/
     fish_add_path $HOME/.cargo/bin/
end
