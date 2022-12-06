#!/bin/bash

WORK="${HOME:-/home}"

if [[ -z "${MAMBA_ROOT_PREFIX}" ]]; then
    cd $WORK
    wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
    export MAMBA_ROOT_PREFIX=$WORK/micromamba 
    eval "$(./bin/micromamba shell hook -s posix)"
    ./bin/micromamba shell -s bash init -p $WORK/micromamba
    ./bin/micromamba shell -s fish init -p $WORK/micromamba
    ./bin/micromamba create -y -f env.yml
    
    mv $HOME/config.fish $HOME/.config/fish/config.fish
    mv $HOME/fish_greeting.fish $HOME/.config/fish/functions/
    ./micromamba/envs/dev/bin/fish fish_install.fish
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ./micromamba/envs/dev/bin/vim +PluginInstall +qall
    # ./micromamba/envs/dev/bin/pip install -r requirements.txt

    echo "" >> $HOME/.bashrc
    echo "micromamba activate dev" >> $HOME/.bashrc
    echo "fish" >> $HOME/.bashrc
fi
