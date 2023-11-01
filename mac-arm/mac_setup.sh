#!/bin/bash -i

# Help function to guide the user
helpFunction()
{
    echo ""
    echo "Usage: $0 [-e env_name]"
    echo -e "\t-e Name of the mamba environment to set-up (default: 'dev')"
    exit 1 # Exit script after printing help
}

# Log function to capture the status of operations
log()
{
    echo "$(date) | $1 | $2"
}

# Default environment name
env_name='dev'

# Parse command-line arguments
while getopts "e:" opt
do
    case "$opt" in
        e ) env_name="$OPTARG" ;;
        ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
    esac
done

# Check if the user requested help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    helpFunction
fi

# Check if 'brew' is installed, if not, install it
if ! command -v brew &> /dev/null
then
    log INFO "brew could not be found, installing it now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? -ne 0 ]]; then
        log ERROR "Error: Failed to install brew"
        exit 1
    fi
    # TODO: Print the following and exit:
    # 
    # echo echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/cnegrete/.zprofile
    # eval "$(/opt/homebrew/bin/brew shellenv)"
    log INFO 'Add brew to PATH (see above instructions) and re-run'
else
    log INFO "brew is already installed"
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
        coreutils \
	    mpich \
	    ghostscript \
	    graphicsmagick \
	    gdal \
	    ffmpeg \
	    libxt \
	    netcdf \
        fish \
	    ncview \
        lazygit \
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
	    the_silver_searcher \
	    openjdk@17 \
	    duf \
	    dust \
	    git-delta
if [[ $? -ne 0 ]]; then
    log ERROR "Package installation failed"
    exit 1
fi

if ! command -v mamba &> /dev/null
then
    # Downloading Mambaforge
    log INFO "Downloading Mambaforge..."
    cd $HOME && curl -fsSLo Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-$(uname -m).sh"
    if [[ $? -ne 0 ]]; then
        log ERROR "Mambaforge download failed"
        exit 1
    fi

    # Installing Mambaforge
    log INFO "Installing Mambaforge..."
    cd $HOME && bash Miniforge3.sh -b -p "${HOME}/conda"
    if [[ $? -ne 0 ]]; then
        log ERROR "Mambaforge installation failed"
        exit 1
    fi

    # Create and activate path to conda/mamba
    source "${HOME}/conda/etc/profile.d/conda.sh" && \
    source "${HOME}/conda/etc/profile.d/mamba.sh" # && \
    # echo "source ${HOME}/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    # echo "source ${HOME}/conda/etc/profile.d/mamba.sh" >> ~/.bashrc && \
    # echo "source ${HOME}/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
    # echo "source ${HOME}/conda/etc/profile.d/mamba.sh" >> ~/.zshrc
    if [[ $? -ne 0 ]]; then
        log ERROR "Error activate conda/mamba"
        exit 1
    fi
fi

# Check if mamba environment exists
env_exists=$(mamba env list | grep -w $env_name)

# Ensure mamba environment exists, create it if it doesn't
if [[ -z $env_exists ]]; then
    log INFO "Creating mamba environment $env_name..."
    mamba create -n $env_name -y
    if [[ $? -ne 0 ]]; then
        log ERROR "Mamba environment creation failed"
        exit 1
    fi
else
    log INFO "Mamba environment $env_name already exists"
fi

# Installing packages into the mamba environment
log INFO "Installing packages into mamba environment $env_name..."
mamba install -n $env_name -y \
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
                 tmux \
                 vim \
                 cmake \
                 go \
                 jq \
                 fzf \
                 htop \
                 exa \
                 ripgrep \
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

mamba activate $env_name

# Installing pip packages
log INFO "Installing pip packages..."
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
if [[ $? -ne 0 ]]; then
    log ERROR "Pip package installation failed"
    exit 1
fi

# Setting up vim
# log INFO "Setting up vim..."
# cp $HOME/repos/utils/vim/mac-vimrc $HOME/.vimrc
# mkdir -p $HOME/.vim/autoload/ && cd $HOME/.vim/autoload && \
#     wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
#     vim +PlugInstall +qall && \
#     mkdir -p $HOME/.vim/plugged && \
#     cd $HOME/.vim/plugged/YouCompleteMe && \
#     python install.py --all
# if [[ $? -ne 0 ]]; then
#     log ERROR "Vim setup failed"
#     exit 1
# fi

# Building Jupyter Lab
log INFO "Building Jupyter Lab..."
jupyter lab build
if [[ $? -ne 0 ]]; then
    log ERROR "Jupyter Lab build failed"
    exit 1
fi

# Configuring fish shell
log INFO "Configuring fish shell..."
mkdir -p $HOME/.config/fish/functions && \
    cp $HOME/repos/utils/mac-arm/config.fish $HOME/.config/fish/config.fish && \
	fish $HOME/repos/utils/mac-arm/fish_install.fish && \
	cp $HOME/repos/utils/mac-arm/fish_greeting.fish $HOME/.config/fish/functions/fish_greeting.fish && \
# cp $HOME/repos/utils/ubuntu/fish_variables $HOME/.config/fish/fish_variables
if [[ $? -ne 0 ]]; then
    log ERROR "Fish shell configuration failed"
    exit 1
fi

# Set fish to default shell (mac)
log INFO "Setting fish as default shell..."
sudo sh -c "echo $(which fish) >> /etc/shells" && \
    chsh -s $(which fish)

# Setting up tmux
log INFO "Setting up tmux..."
mkdir -p $HOME/.tmux
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf $HOME/.tmux/.tmux.conf 
cp $HOME/repos/utils/tmux/gpakosz/tmux.conf.local $HOME/.tmux/.tmux.conf.local
if [[ $? -ne 0 ]]; then
    log ERROR "tmux setup failed"
    exit 1
fi

# Set up tmux confs
cd $HOME && \
    ln -sf $HOME/.tmux/.tmux.conf . && \
    ln -sf $HOME/.tmux/.tmux.conf.local .

