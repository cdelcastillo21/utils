#!/bin/bash
# Installation script for ubuntu images

# Copy 
cd /data/fish
mkdir -p /root/.config/fish && cp config.fish /root/.config/fish/config.fish

# Fish shell
echo "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" > fisher_install.fish
fish fisher_install.fish

echo "fisher install IlanCosman/tide@v5" > tide_install.fish
fish tide_install.fish

echo "fisher install jethrokuan/z" > z_install.fish
fish z_install.fish

mv fish_variables ~/.config/fish/fish_variables
