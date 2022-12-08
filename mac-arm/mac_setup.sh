#!/bin/bash -i

brew update --auto-update
brew upgrade
brew install wget \
	     mpich \
	     ghostscript \
	     graphicsmagick \
	     gdal \
	     ffmpeg \
	     libxt \
	     netcdf \
	     ncview \
             libxaw \
	     hdf5 \
	     gfortran \
	     libxml2 \
             perl \
	     gcc \
	     git \
	     gzip \
             gnupg2 \
             lolcat \
	     fortune \
	     onefetch \
	     neofetch \
	     openjdk@17 \
	     duf \
	     dust \
	     git-delta

cd $HOME 
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh
chmod +x Mambaforge-MacOSX-arm64.sh
./Mambaforge-MacOSX-arm64.sh -b -p $HOME/.mm
rm Mambaforge-MacOSX-arm64.sh
$HOME/.mm/bin/mamba install -y -p $HOME/.mm \
                 ptpython \
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
		 sshfs \
		 curl \
		 -c conda-forge

$HOME/.mm/bin/pip install jupyterlab-citation-manager \
		  aquirdturtle_collapsible_headings \
		  ipympl \
		  jupyterlab_code_formatter \
		  jupyterlab-topbar  \
		  jupyterlab-topbar-text \
		  jupyterlab-link-share  \
		  jupyterlab_recents \
		  jupyterlab-vim \
		  jupyterlab_theme_solarized_dark

mv utils/vimrc/mac-vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/autoload/ && cd $HOME/.vim/autoload && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
    cd $HOME/.vim/plugged/YouCompleteMe && \
#     $HOME/.mm/bin/python install.py --all

$HOME/.mm/bin/jupyter lab build

cp $HOME/repos/utils/mac/config.fish $HOME/.config/fish/config.fish
fish $HOME/repos/utils/ubuntu/fish_install.fish 
cp $HOME/repos/utils/ubuntu/fish_greeting.fish $HOME/.config/fish/functions/fish_greeting.fish
# cp $HOME/repos/utils/ubuntu/fish_variables $HOME/.config/fish/fish_variables

# tmux set-up
mkdir -p $HOME/.tmux
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf $HOME/.tmux/.tmux.conf 
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf.local $HOME/.tmux/.tmux.conf.local
# Do manually
# cd $HOME && \ 
#     ln -sf $HOME/.tmux/.tmux.conf . && \
#     ln -sf $HOME/.tmux/.tmux.conf.local .
