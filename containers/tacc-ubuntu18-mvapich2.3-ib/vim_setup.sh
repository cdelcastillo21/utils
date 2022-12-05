#!/bin/bash

RUN micromamba activate dev && \
    micromamba install -y vim fzf -c conda-forge && \
    cp /data/vimrc ~/.vimrc && \
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ && \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
