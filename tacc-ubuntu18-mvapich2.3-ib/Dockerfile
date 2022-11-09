FROM tacc/tacc-ubuntu18-mvapich2.3-ib

RUN apt-get update && \
    apt-get install -y \
    curl zip tar wget \
    tmux \
    vim \
    htop \
    httpie \
    silversearcher-ag \
    software-properties-common \
    expect \
    git \
    g++-8 \
    nodejs \
    npm

# Install exa - LS replacement
COPY utils/tacc-ubuntu18-mvapich2.3-ib/exa_install.sh /data/exa_install.sh
RUN chmod +x /data/exa_install.sh && /data/exa_install.sh

# Instal GO
RUN wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz && \
    tar -xvf go1.19.3.linux-amd64.tar.gz && \
    mv go/ /usr/local/ && \
    echo "export GOPATH=$HOME/go" >> /root/.bashrc && \
    echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> /root/.bashrc

# Configure shell environment
RUN add-apt-repository -y ppa:fish-shell/release-3 && apt update && apt install -y fish

# Configure fish shell
RUN mkdir /data/fish
COPY utils/fish_configs/fish_variables /data/fish/fish_variables
COPY utils/tacc-ubuntu18-mvapich2.3-ib/config.fish /data/fish/config.fish
COPY utils/tacc-ubuntu18-mvapich2.3-ib/fish_setup.sh /data/fish/fish_setup.sh
RUN chmod +x /data/fish/fish_setup.sh && /data/fish/fish_setup.sh

# Configure python
COPY utils/tacc-ubuntu18-mvapich2.3-ib/vim_env.yml /data/vim_env.yml
RUN curl micro.mamba.pm/install.sh | bash && \
    source /root/.bashrc && \
    micromamba shell init && \
    micromamba shell init -s fish -p ~/micromamba && \
    micromamba create -y -f /data/vim_env.yml && \
    echo "set -o vi" >> /root/.bashrc && \
    echo "set -u EDITOR vim" >> /root/.bashrc && \
    echo "alias mm=micromamba" >> /root/.bashrc && \
    echo "micromamba activate dev" >> /root/.bashrc

# VIM setup 
# COPY utils/tacc-ubuntu18-mvapich2.3-ib/vimrc /data/vimrc
# RUN source ~/.bashrc && micromamba activate dev && \
#     cp /data/vimrc ~/.vimrc && \
#     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
#     vim +PlugInstall +qall

# Java17 Download - For YCM
# RUN add-apt-repository -y ppa:linuxuprising/java && \
#     apt update && \
#     echo debconf shared/accepted-oracle-license-v1-3 select true | debconf-set-selections && \
#     echo debconf shared/accepted-oracle-license-v1-3 seen true | debconf-set-selections && \
#     apt install -y oracle-java17-installer

# YouCompleteMe vim set-up
# RUN source ~/.bashrc && cd ~/.vim/plugged/YouCompleteMe && \
#     CC=gcc-8 CXX=g++-8 python3 ./install.py  --force-sudo --all

# Install rust utilities
# COPY utils/tacc-ubuntu18-mvapich2.3-ib/rust_utils.sh /data/rust_utils.sh
# RUN chmod +x /data/rust_utils.sh && /data/rust_utils.sh

