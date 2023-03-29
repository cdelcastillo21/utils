if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
	eval /work/06307/clos21/ls6/mambaforge/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
end

if type -q bat
     alias cat="bat"
end
# if type -q exa
#     alias ls="exa -l -h --tree -L 1 -F --icons"
#     alias lst="exa -l -h --tree -L 1 -F --icons --sort=time"
#     alias lss="exa -l -h --tree -L 1 -F --icons --sort=size"
#     alias lsty="exa -l -h --tree -L 1 -F --icons --sort=type"
# end
if type -q delta
    alias diff="delta --side-by-side"
end
if type -q vim
    set -Ux EDITOR vim
end
if type -q trash
    # Doesn't work on TACC envs
    # alias rm="trash --trash-dir $SCRATCH/.trash"
end
# if test -d $HOME/go/bin/
#      fish_add_path $HOME/go/bin/
# end
if test -d $HOME/.cargo/
     fish_add_path $HOME/.cargo/bin/
end

# fish_add_path $HOME/.local/bin/

# Add DesignSafe ProjectPaths
#
set PUB $WORK/../pub
set DSPROJ /corral-repl/projects/NHERI/projects
set AKPROJ $DSPROJ/5391485568726068755-242ac11a-0001-012
