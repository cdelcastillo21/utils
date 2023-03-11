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
		     curl && \
		     mamba clean --all -f -y

pip install ipykernel httpie \
		jupyterlab-citation-manager \
		aquirdturtle_collapsible_headings \
		ipympl \
		jupyterlab_code_formatter \
		jupyterlab-topbar  \
		jupyterlab-topbar-text \
		jupyterlab-link-share  \
		jupyterlab_recents \
		jupyterlab-vim \
		jupyterlab_theme_solarized_dark

ipython kernel install --user --name=dev


mkdir -p ~/.vim/autoload/ && cd ~/.vim/autoload && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
    go env -w "CC=gcc" && \
    go env -w "CXX=g++" && \
    cd ~/.vim/plugged/YouCompleteMe && \
    python install.py --all

# Don'y have permissions in DesignSafe
# jupyter lab build

cp  utils/containers/jupyter-minimal/config.fish ~/.config/fish/config.fish
fish utils/fish/fish_install.fish && \
     rm ~/fish_install.fish
cp utils/fish/fish_greeting.fish ~/.config/fish/functions/fish_greeting.fish
cp utils/containers/jupyter-minimal/fish_variables ~/.config/fish/fish_variables

# tmux set-up
mkdir -p ~/.tmux
cp utils/tmux/gpakosz/tmux.conf ~/.tmux/.tmux.conf 
cp utils/tmux/gpakosz/tmux.conf.local ~/.tmux/.tmux.conf.local
RUN cd ~ && \ 
    ln -sf ~/.tmux/.tmux.conf . && \
    ln -sf ~/.tmux/.tmux.conf.local .

cp utils/git/gitconfig ~/.gitconfig

echo "conda activate dev && fish" >> ~/.bashrc

