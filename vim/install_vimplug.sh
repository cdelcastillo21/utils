#!/bin/bash

mkdir -p $HOME/.vim/autoload
cd $HOME/.vim/autoload
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

cd ~/.vim/plugged/YouCompleteMe
python3 install.py --all
