#!/bin/bash

export PATH="/home/clos21-dev/bin/:/home/clos21-dev/micromamba/envs/dev/bin/:$PATH"
echo "echo \"Configuring fish shell...\"" | fish
cp  /home/clos21-dev/.config/fish/config.fish $HOME/.config/fish/config.fish
cp  /home/clos21-dev/.config/fish/functions/fish_greeting.fish $HOME/.config/fish/functions/fish_greeting.fish
fish 
