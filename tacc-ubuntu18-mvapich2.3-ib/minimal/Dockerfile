FROM tacc/tacc-ubuntu18-mvapich2.3-ib

ENV LD_PRELOAD=
RUN apt-get update && \
    apt-get install -y \
    curl zip tar wget \
    libcurl4-openssl-dev \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y

# ARG user=clos21j
ARG user
ARG tacc_dir
RUN echo $user
RUN echo $tacc_dir
RUN echo $psw

ENV TACC_DEV_USER=$user-dev
ENV TACC_DEV_USER_HOME=/home/$user-dev/
ENV TACC_DEV_PSW=$psw
RUN useradd -rm -d $TACC_DEV_USER_HOME -s /bin/bash -g root -G sudo -u 1001 $TACC_DEV_USER && \
    echo "${TACC_DEV_USER}:foo" | chpasswd
USER $TACC_DEV_USER
WORKDIR $TACC_DEV_USER_HOME
ENV TACC_DEV_PSW=

# Copy scripts and such
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/dev-full.yml env.yml
COPY --chown=$TACC_DEV_USER utils/fish/config.fish $TACC_DEV_USER_HOME/config.fish
COPY --chown=$TACC_DEV_USER utils/fish/fish_greeting.fish $TACC_DEV_USER_HOME/fish_greeting.fish
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/install_scripts/fish_install.fish $TACC_DEV_USER_HOME/fish_install.fish
# COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/fish_variables $TACC_DEV_USER_HOME/fish_variables
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/vimrc $TACC_DEV_USER_HOME/vimrc
COPY --chown=$TACC_DEV_USER utils/tmux/gpakosz/tmux.conf $TACC_DEV_USER_HOME/tmux.conf 
COPY --chown=$TACC_DEV_USER utils/tmux/gpakosz/tmux.conf.local $TACC_DEV_USER_HOME/tmux.conf.local
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/entry.sh $TACC_DEV_USER_HOME/entry.sh

# RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
# RUN ./bin/micromamba shell init -s bash


# VIM setup 
# RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
# 	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # && \
#     # $TACC_DEV_USER_HOME/micromamba/envs/dev/bin/vim +PlugInstall +qall

# tmux configuration
COPY --chown=$user  utils/tmux/gpakosz/tmux.conf $TACC_DEV_USER_HOME/tmux.conf 
COPY --chown=$user  utils/tmux/gpakosz/tmux.conf.local $TACC_DEV_USER_HOME/tmux.conf.local

# Configure fish shell test
#COPY --chown=$TACC_DEV_USER utils/fish/config.fish $TACC_DEV_USER_HOME/.config/fish/config.fish
#COPY --chown=$TACC_DEV_USER utils/fish/fish_greeting.fish $TACC_DEV_USER_HOME/.config/fish/functions/fish_greeting.fish
#RUN ./bin/micromamba shell init -s fish && \
    #echo "alias mm=\"micromamba\"" >> $HOME/.config/fish/config.fish && \
    #echo "mm activate dev" >> $HOME/.config/fish/config.fish && \
    #echo "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" > fisher_install.fish && \
    #echo "fisher install IlanCosman/tide@v5" >> fisher_install.fish && \
    #echo "fisher install jethrokuan/z" >> fisher_install.fish && \
    #echo "fisher install jorgebucaran/nvm.fish" >> fisher_install.fish && \
    #echo "nvm install 17.0.0 --latest-npm" >> fisher_install.fish && \
    #echo "npm install --global trash-cli && \\" >> fisher_install.fish && \
    #echo "alias rm=\"trash\"" >> $HOME/.config/fish/config.fish && \
    #echo "npm install --global vtop" >> fisher_install.fish && \
    #echo "npm install --global tldr" >> fisher_install.fish && \
    #echo "tldr --update" >> fisher_install.fish && \
    #echo "npm install --global figlet-cli" >> fisher_install.fish && \
    #echo "npm install --global cowsay" >> fisher_install.fish && \
    #echo "node -v > $HOME/.nvmrc" >> fisher_install.fish && \
    #$HOME/micromamba/envs/dev/bin/fish fisher_install.fish && rm fisher_install.fish # && \
    ## echo "nvm install v17.0.0" >> $HOME/.config/fish/config.fish && \
    ## echo "fish" >> $HOME/.bashrc
#COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/fish_variables $TACC_DEV_USER_HOME/.config/fish/fish_variables
 
## VIM setup 
#COPY --chown=$user utils/tacc-ubuntu18-mvapich2.3-ib/vimrc $TACC_DEV_USER_HOME/.vimrc
#RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	#https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    #$TACC_DEV_USER_HOME/micromamba/envs/dev/bin/vim +PlugInstall +qall


#COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/entry.sh $TACC_DEV_USER_HOME/entry.sh
#RUN chmod +x $TACC_DEV_USER_HOME/entry.sh
# ENTRYPOINT $TACC_DEV_USER_HOME/entry.sh

#ENV PATH="${PATH}:/${HOME}/go/bin/"
#ENV PATH="${PATH}:/${HOME}/.cargo/bin/"
#ENV PATH="${PATH}:/usr/games/"
    ## echo "export PATH=\"\$HOME/go/bin/:\$PATH\"" >> $HOME/.bashrc && \

## Other utility packages
#COPY --chown=$user utils/git/gitconfig /work/$user/.gitconfig
#ENV gcc="/usr/bin/gcc" CC="/usr/bin/gcc"
#RUN $HOME/micromamba/envs/dev/bin/go install github.com/cheat/cheat/cmd/cheat@latest
#COPY --chown=$user utils/cheatsheets/git-emoji /root/.config/cheat/cheatsheets/personal/git-emoji

## tmux configuration
#COPY --chown=$user  utils/tmux/tmux.conf /home/$user/.tmux.conf 
#COPY --chown=$user  utils/tmux/tmux.conf.local /home/$user/.tmux.conf.local

#RUN /work/clos21/micromamba/envs/dev/bin/cargo install onefetch

## Java17 Download - For YCM
## RUN add-apt-repository -y ppa:linuxuprising/java && \
##     apt update && \
##     echo debconf shared/accepted-oracle-license-v1-3 select true | debconf-set-selections && \
##     echo debconf shared/accepted-oracle-license-v1-3 seen true | debconf-set-selections && \
##     apt install -y oracle-java17-installer

## YouCompleteMe vim set-up
## RUN source ~/.bashrc && cd ~/.vim/plugged/YouCompleteMe && \
##     CC=gcc-8 CXX=g++-8 python3 ./install.py  --force-sudo --all

