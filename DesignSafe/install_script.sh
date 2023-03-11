#!/bin/bash -i 
#

REPOS=~/MyData/repos


# Create base conda dev environment
mamba create -n dev -y && \
  mamba install -n dev -y ptpython \
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
                         bpytop
                        tokei \
                        rust \
                        glow \
                        trash-cli \
                        ipydrawio \
                        curl \
                        rust && \
                        mamba clean --all -f -y

conda activate dev

# Python pip packages
pip install ipykernel \
	    httpie \
	    ipympl \

cargo install onefetch

# Configure VIM
cd $REPOS && \
    cp utils/vim/ubuntu-vimrc && \
    mkdir -p ~/.vim/autoload/ && cd ~/.vim/autoload && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
    go env -w "CC=gcc" && \
    go env -w "CXX=g++" && \
    cd ~/.vim/plugged/YouCompleteMe && \
    python install.py --all


# Configure fish shell
cd $REPOS && \
  cp  utils/DesignSafe/config.fish ~/.config/fish/config.fish && \
  fish utils/fish/fish_install.fish && \
  cp utils/DesignSafe/fish_greeting.fish ~/.config/fish/functions/fish_greeting.fish && \
  cp utils/DesignSafe/fish_variables ~/.config/fish/fish_variables && \
  cp utils/git/gitconfig ~/.gitconfig && \
  cp utils/fortunes.txt ~/.config/fish/fortunes.txt

# tmux set-up
cd $REPOS && \
  mkdir -p ~/.tmux && \
  cp utils/tmux/gpakosz/tmux.conf ~/.tmux/.tmux.conf && \
  cp utils/tmux/gpakosz/tmux.conf.local ~/.tmux/.tmux.conf.local && \
  cd ~ && \ 
  ln -sf ~/.tmux/.tmux.conf . && \
  ln -sf ~/.tmux/.tmux.conf.local .


# neofetch - system info utility (
cd $REPOS && \
  git clone https://github.com/dylanaraps/neofetch.git && \
  mkdir ~/.local/bin && \
  cp neofetch/neofetch ~/.local/bin/ && \
  rm -rf neofetch

# Disk utility -> DU supercharged https://github.com/bootandy/dust
cargo install du-dust 

# Another disk utility -> duf https://github.com/muesli/duf
cd $REPOS && \
  git clone https://github.com/muesli/duf.git && \
  cd duf && \
  go build && \
  cp duf ~/.local/bin/ && \
  cd $REPOS && \
  rm -rf duf

# Jupyter setup -> Don'y have permissions in DesignSafe to build juptyer lab so this will fail
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

# Start fish shell in environment always
echo "conda activate dev && fish" >> ~/.bashrc
