#!/bin/bash -i

sudo ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	sudo apt-get update && \
        DEBIAN_FRONTEND=noninteractive && \
	sudo apt-get install -y \
    	wget \
	sshfs \
        mpich \
	ghostscript graphicsmagick \
        gdal-bin \
	ffmpeg \
	cmake \
	libxt-dev \
	netcdf-bin \
        libxaw7-dev \
	libhdf5-dev \
	libnetcdff-dev \
        libopenmpi-dev \
	bc \
	gfortran \
	libxml2-dev \
        perl \
	gcc \
	g++ \
	git \
	tar \
	gzip \
	ssh \
        ca-certificates \
	zlib1g-dev \
        libcurl4-openssl-dev \
        software-properties-common \
        gnupg2 \
        lolcat \
	fortune \
	tzdata && \
	sudo dpkg-reconfigure --frontend noninteractive tzdata
sudo add-apt-repository -y ppa:o2sh/onefetch && \
    sudo apt-get update && \
    sudo apt-get install -y onefetch

# Install java 
sudo apt update -y
sudo apt install -y openjdk-17-jre-headless
sudo apt install -y neofetch

sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    sudo apt-get autoremove -y

# Other utilities
wget https://github.com/dandavison/delta/releases/download/0.14.0/git-delta-musl_0.14.0_amd64.deb && \
    sudo dpkg -i git-delta-musl_0.14.0_amd64.deb && \
    rm git-delta-musl_0.14.0_amd64.deb
wget https://github.com/bootandy/dust/releases/download/v0.8.3/du-dust_0.8.3_amd64.deb && \
    sudo dpkg -i du-dust_0.8.3_amd64.deb && \
    rm du-dust_0.8.3_amd64.deb
wget https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb
    sudo dpkg -i duf_0.8.1_linux_amd64.deb && \
    rm duf_0.8.1_linux_amd64.deb 

mamba install -y ptpython \
		 ipykernel \
		 nodejs \
		 jupyterlab \
		 flake8 \
		 black \
		 isort \
		 autopep8 \
		 ipympl \
		 yapf \
		 jupyter_bokeh \
		 jupyterlab-lsp \
		 python-lsp-server  \
		 jupyterlab-git \
		 jupyterlab-spellchecker \
		 jlab-enhanced-cell-toolbar \
		 fish \
		 tmux \
		 vim \
		 cmake \
		 go \
		 jq \
		 lazygit \
		 fzf \
		 htop \
		 exa \
		 ripgrep \
		 the_silver_searcher \
		 bat \
		 hyperfine \
		 httpie \
		 broot \
		 tokei \
		 glow \
		 trash-cli \
		 ipydrawio \
		 curl && \
		 mamba clean --all -f -y

pip install jupyterlab-citation-manager \
		aquirdturtle_collapsible_headings \
		ipympl \
		jupyterlab_code_formatter \
		jupyterlab-topbar  \
		jupyterlab-topbar-text \
		jupyterlab-link-share  \
		jupyterlab_recents \
		jupyterlab-vim \
		jupyterlab_theme_solarized_dark

mv utils/containers/jupyter-minimal/vimrc $HOME/.vimrc

mkdir -p $HOME/.vim/autoload/ && cd $HOME/.vim/autoload && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
    go env -w "CC=gcc" && \
    go env -w "CXX=g++" && \
    cd $HOME/.vim/plugged/YouCompleteMe && \
    python install.py --all

jupyter lab build

PATH="/usr/games/:${PATH}"
cp $HOME/repos/utils/ubuntu/config.fish $HOME/.config/fish/config.fish
fish $HOME/repos/utils/ubuntu/fish_install.fish 
cp $HOME/repos/utils/ubuntu/fish_greeting.fish $HOME/.config/fish/functions/fish_greeting.fish
# cp $HOME/repos/utils/ubuntu/fish_variables $HOME/.config/fish/fish_variables

# tmux set-up
mkdir -p $HOME/.tmux
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf $HOME/.tmux/.tmux.conf 
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf.local $HOME/.tmux/.tmux.conf.local
cd $HOME && \ 
    ln -sf $HOME/.tmux/.tmux.conf . && \
    ln -sf $HOME/.tmux/.tmux.conf.local .
