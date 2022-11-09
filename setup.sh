#!/bin/bash
# Installation script for ubuntu images

apt install -y curl zip tar wget tmux vim exa bat htop httpie duf fish
apt-get install -y ripgrep silversearcher-ag fzf

# NerdFonts - Meslo
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Meslo.zip
unzip Meslo.zip

# Rust stuff
curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"

cargo install git-delta
cargo install hyperfine
cargo install du-dust
cargo install --locked broot
cargo install tokei


# GO stuff
cd
wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz

# Python stuff
curl micro.mamba.pm/install.sh | bash

# Fish shell
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
