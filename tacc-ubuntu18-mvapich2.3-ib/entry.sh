#!/bin/bash

cd $WORK
mkdir dev
cd dev
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
export MAMBA_ROOT_PREFIX=$WORK/dev/micromamba 
eval "$(./bin/micromamba shell hook -s posix)"
./bin/micromamba shell -s bash init -p $WORK/dev/micromamba
./bin/micromamba create -y -n dev vim fish tmux git -c conda-forge # -f /home/clos21-dev/env.yml

cp /home/clos21-dev/fish_install.fish .
./micromamba/envs/dev/bin/fish fish_install.fish

cp /home/clos21-dev/vimrc $HOME/.vimrc
cp /home/clos21-dev/tmux.conf $HOME/.tmux.conf
cp /home/clos21-dev/tmux.conf.local $HOME/.tmux.conf.local
cp /home/clos21-dev/fish_greeting.fish $HOME/.config/fish/functions/fish_greeting.fish
