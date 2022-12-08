#!/bin/bash

WORK="${WORK:-/home}"

if [[ -z "${MAMBA_ROOT_PREFIX}" ]]; then
    cd $WORK
    mkdir dev
    cd dev
    curl -Ls http://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
    export MAMBA_ROOT_PREFIX=$WORK/dev/micromamba 
    eval "$(./bin/micromamba shell hook -s posix)"
    ./bin/micromamba shell -s bash init -p $WORK/dev/micromamba
    ./bin/micromamba shell -s fish init -p $WORK/dev/micromamba
    ./bin/micromamba create -y -f /home/dev/env.yml
    # ./bin/micromamba create -y -n dev vim fish tmux git -c conda-forge # -f /home/dev/env.yml
    
    cp /home/dev/fish_install.fish .
    ./micromamba/envs/dev/bin/fish fish_install.fish

    echo "" >> $HOME/.bashrc
    echo "micromamba activate dev" >> $HOME/.bashrc
    echo "fish" >> $HOME/.bashrc
fi