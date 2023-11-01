#!/bin/bash -i

# Help function to guide the user
helpFunction()
{
    echo ""
    echo "Usage: $0"
    echo -e "Automates the setup of a development environment on a Mac (arm)."
    exit 1 # Exit script after printing help
}

# Log function to capture the status of operations
log()
{
    echo "$(date) | $1 | $2"
}

# Check if the user requested help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    helpFunction
fi

# Check if 'brew' is installed, if not, install it
if ! command -v brew &> /dev/null
then
    echo "brew could not be found, installing it now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to install brew"
        exit 1
    fi
else
    echo "brew is already installed"
fi

# Updating brew
log INFO "Updating brew..."
brew update --auto-update
if [[ $? -ne 0 ]]; then
    log ERROR "Brew update failed"
    exit 1
fi

# Upgrading brew
log INFO "Upgrading brew..."
brew upgrade
if [[ $? -ne 0 ]]; then
    log ERROR "Brew upgrade failed"
    exit 1
fi

# Installing necessary packages
log INFO "Installing homebrew packages..."
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
if [[ $? -ne 0 ]]; then
    log ERROR "Package installation failed"
    exit 1
fi

# Downloading Mambaforge
log INFO "Downloading Mambaforge..."
cd $HOME && wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh
if [[ $? -ne 0 ]]; then
    log ERROR "Mambaforge download failed"
    exit 1
fi

# Installing Mambaforge
log INFO "Installing Mambaforge..."
chmod +x Mambaforge-MacOSX-arm64.sh && \
	./Mambaforge-MacOSX-arm64.sh -b -p $HOME/.mm && \
	rm Mambaforge-MacOSX-arm64.sh
if [[ $? -ne 0 ]]; then
    log ERROR "Mambaforge installation failed"
    exit 1
fi

# Installing packages with mamba
log INFO "Installing packages with mamba..."
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
if [[ $? -ne 0 ]]; then
    log ERROR "Mamba package installation failed"
    exit 1
fi

# Installing pip packages
log INFO "Installing pip packages..."
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
if [[ $? -ne 0 ]]; then
    log ERROR "Pip package installation failed"
    exit 1
fi

# Setting up vim
log INFO "Setting up vim..."
mv utils/vimrc/mac-vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/autoload/ && cd $HOME/.vim/autoload && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
    cd $HOME/.vim/plugged/YouCompleteMe && \
    $HOME/.mm/bin/python install.py --all
if [[ $? -ne 0 ]]; then
    log ERROR "Vim setup failed"
    exit 1
fi

# Building Jupyter Lab
log INFO "Building Jupyter Lab..."
$HOME/.mm/bin/jupyter lab build
if [[ $? -ne 0 ]]; then
    log ERROR "Jupyter Lab build failed"
    exit 1
fi

# Configuring fish shell
log INFO "Configuring fish shell..."
cp $HOME/repos/utils/mac/config.fish $HOME/.config/fish/config.fish && \
	fish $HOME/repos/utils/ubuntu/fish_install.fish && \
	cp $HOME/repos/utils/ubuntu/fish_greeting.fish $HOME/.config/fish/functions/fish_greeting.fish
# cp $HOME/repos/utils/ubuntu/fish_variables $HOME/.config/fish/fish_variables
if [[ $? -ne 0 ]]; then
    log ERROR "Fish shell configuration failed"
    exit 1
fi

# Setting up tmux
log INFO "Setting up tmux..."
mkdir -p $HOME/.tmux
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf $HOME/.tmux/.tmux.conf 
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf.local $HOME/.tmux/.tmux.conf.local
if [[ $? -ne 0 ]]; then
    log ERROR "tmux setup failed"
    exit 1
fi

# Manual steps reminder for tmux
echo "Manual steps:"
echo "cd $HOME && \\"
echo "    ln -sf $HOME/.tmux/.tmux.conf . && \\"
echo "    ln -sf $HOME/.tmux/.tmux.conf.local ."