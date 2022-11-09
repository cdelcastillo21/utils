#!/bin/bash
# Installation script for ubuntu images

echo "Skip"
# Rust stuff - should be < 30 secs for install
# curl https://sh.rustup.rs -sSf | sh -s -- -y
# source "$HOME/.cargo/env"
# 
# cargo install git-delta
# cargo install hyperfine
# cargo install du-dust
# cargo install --locked broot
# cargo install tokei
# cargo install ripgrep
# 
# cargo install git-delta hyperfine du-dust broot tokei ripgrep
#
#
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sed 's#/proc/self/exe#$SHELL#g' | sh -s -- -y
