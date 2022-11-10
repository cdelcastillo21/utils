#!/bin/bash
# Python env installation script for ubuntu images
# 
# # Download miniconda and install
# mkdir /data/python
# cd /data/python
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# chmod +x Miniconda3-latest-Linux-x86_64.sh
# ./Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/src/conda
#  /usr/local/src/conda/bin/conda init
#  source ~/.bashrc
#  conda install -y mamba -n base -c conda-forge
# 
# mamba create --name dev
# conda activate dev
# 
# Packages in default dev environment 
# mamba install -y -c conda-forge fzf  # For file searching
#
#
RUN curl micro.mamba.pm/install.sh | bash && \
    micromamba shell init && \
    source ~/.bashrc && \
    micromamba shell init -s fish -p ~/micromamba && \
    micromamba create -y -n dev --rc-file /data/vim_env.config && \
    echo "set -ux EDITOR vim" >> /root/.bashrc && \
    echo "alias mm=micromamba" >> /root/.bashrc && \
    echo "micromamba activate dev" >> /root/.bashrc
