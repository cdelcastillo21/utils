#!/bin/bash -i 
#

REPOS=$WORK/repos

# update base environment 
# conda update -n base -y conda
mamba install -y fish \
                 tmux \
                 vim \
                 cmake \
                 go \
                 fzf \
                 htop \
                 exa \
                 ripgrep \
                 the_silver_searcher \
                 bat \
                 broot \
                 bpytop \
                 tokei \
                 rust \
                 trash-cli \
                 curl \
                 rust

# Python pip packages
pip install fortune \
	    pyfiglet \
	    lolcat \

# Configure fish shell
cd $REPOS && \
  fish utils/fish/fish_install.fish && \
  cp utils/DesignSafe/config.fish ~/.config/fish/config.fish && \
  cp utils/DesignSafe/fish_greeting.fish ~/.config/fish/functions/fish_greeting.fish && \
  cp utils/git/gitconfig ~/.gitconfig && \
  conda init fish

# Configure VIM
cd $REPOS && \
    cp utils/DesignSafe/vimrc ~/.vimrc && \
    mkdir -p ~/.vim/autoload/ && cd ~/.vim/autoload && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
    go env -w "CC=gcc" && \
    go env -w "CXX=g++" && \
    cd ~/.vim/plugged/YouCompleteMe && \
    python install.py --all

# tmux set-up
cd $REPOS && \
  mkdir -p ~/.tmux && \
  cp utils/tmux/gpakosz/tmux.conf ~/.tmux/.tmux.conf && \
  cp utils/tmux/gpakosz/tmux.conf.local ~/.tmux/.tmux.conf.local && \
  cd ~ && \ 
  ln -sf ~/.tmux/.tmux.conf . && \
  ln -sf ~/.tmux/.tmux.conf.local .

## UTILITIES

# ls replacement
cargo install exa

# For viewing github repo statistics
cargo install onefetch

# neofetch - system info utility (
cd $REPOS && \
  git clone https://github.com/dylanaraps/neofetch.git && \
  mkdir -p ~/.local/bin
cp neofetch/neofetch ~/.local/bin/ && \
  rm -rf neofetch

# Disk utility -> DU supercharged https://github.com/bootandy/dust
cargo install du-dust 

# Another disk utility -> duf https://github.com/muesli/duf
cd $REPOS && \
  git clone https://github.com/muesli/duf.git
cd duf && \
  go build
cp duf ~/.local/bin/ && \
  cd $REPOS && \
  rm -rf duf

# Configure python dev environment 
conda create -n dev -y
conda activate dev
mamba install -y fish \
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
                 python-lsp-server  \
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
                 bpytop \
                 tokei \
                 rust \
                 glow \
                 trash-cli \
                 ipydrawio \
                 curl \
                 rust

# cp utils/DesignSafe/fish_variables ~/.config/fish/fish_variables && \
cp $REPOS/utils/fortunes.txt ~/.local/share/fortunes.txt

# Python pip packages
pip install ipykernel \
	    httpie \
	    fortune \
	    pyfiglet \
	    lolcat \
	    ipympl

## UTILITIES

# ls replacement
cargo install exa

# For viewing github repo statistics
cargo install onefetch

# Disk utility -> DU supercharged https://github.com/bootandy/dust
cargo install du-dust 

# Jupyter setup -> Don'y have permissions in DesignSafe to build juptyer lab so this will fail
# mamba install -n dev -y jupyter_bokeh \
#                         jupyterlab-lsp \
#                         python-lsp-server  \
#                         jupyterlab-git \
#                         jupyterlab-spellchecker \
#                         jlab-enhanced-cell-toolbar \
# pip install jupyterlab-citation-manager \
#             aquirdturtle_collapsible_headings \
#             jupyterlab_code_formatter \
#             jupyterlab-topbar  \
#             jupyterlab-topbar-text \
#             jupyterlab-link-share  \
#             jupyterlab_recents \
#             jupyterlab-vim \
#             jupyterlab_theme_solarized_dark
# jupyter lab build

# Install dev environment as a kernel
ipython kernel install --user --name=dev

# Append the function to the end of ~/.bashrc
echo "" >> ~/.bashrc
echo "# Function to activate development environment and display system info" >> ~/.bashrc
echo "dev_env() {" >> ~/.bashrc
echo "    conda activate dev" >> ~/.bashrc
echo "    pyfiglet --width 80 -f \$(pyfiglet -l | shuf -n 1) \$(hostname | awk '{print \$1}' FS='.') | lolcat -a -s 500 -F 0.1" >> ~/.bashrc
echo "    ~/.local/bin/neofetch" >> ~/.bashrc
echo "    cowsay \$(fortune ~/.local/share/fortunes.txt) | lolcat" >> ~/.bashrc
echo "    fish" >> ~/.bashrc
echo "}" >> ~/.bashrc
