FROM clos21/adcirc:frontera-beta

RUN apt-get update && \
    apt-get install -y \
    curl zip tar wget \
    libcurl4-openssl-dev \
    software-properties-common \
    lolcat fortune \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y

RUN wget https://github.com/dandavison/delta/releases/download/0.14.0/git-delta-musl_0.14.0_amd64.deb && \
    dpkg -i git-delta-musl_0.14.0_amd64.deb && \
    rm git-delta-musl_0.14.0_amd64.deb
RUN wget https://github.com/bootandy/dust/releases/download/v0.8.3/du-dust_0.8.3_amd64.deb && \
    dpkg -i du-dust_0.8.3_amd64.deb && \
    rm du-dust_0.8.3_amd64.deb
    
ENV TACC_DEV_USER=dev
ENV TACC_DEV_USER_HOME=/home/dev/
ENV TACC_DEV_PSW=$psw
RUN useradd -rm -d $TACC_DEV_USER_HOME -s /bin/bash -g root -G sudo -u 1001 $TACC_DEV_USER && \
    echo "${TACC_DEV_USER}:foo" | chpasswd
USER $TACC_DEV_USER
WORKDIR $TACC_DEV_USER_HOME
ENV TACC_DEV_PSW=

# Copy scripts and such
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/dev-full.yml env.yml
COPY --chown=$user utils/git/gitconfig /work/$user/.gitconfig
COPY --chown=$TACC_DEV_USER utils/fish/config.fish $TACC_DEV_USER_HOME/config.fish
COPY --chown=$TACC_DEV_USER utils/fish/fish_greeting.fish $TACC_DEV_USER_HOME/fish_greeting.fish
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/install_scripts/fish_install.fish $TACC_DEV_USER_HOME/fish_install.fish
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/vimrc $TACC_DEV_USER_HOME/vimrc
COPY --chown=$TACC_DEV_USER utils/tmux/gpakosz/tmux.conf $TACC_DEV_USER_HOME/tmux.conf 
COPY --chown=$TACC_DEV_USER utils/tmux/gpakosz/tmux.conf.local $TACC_DEV_USER_HOME/tmux.conf.local
COPY --chown=$TACC_DEV_USER utils/tacc-ubuntu18-mvapich2.3-ib/entry.sh $TACC_DEV_USER_HOME/entry.sh
RUN chmod +x $TACC_DEV_USER_HOME/entry.sh

## Other utility packages
#ENV gcc="/usr/bin/gcc" CC="/usr/bin/gcc"
#RUN $HOME/micromamba/envs/dev/bin/go install github.com/cheat/cheat/cmd/cheat@latest
#COPY --chown=$user utils/cheatsheets/git-emoji /root/.config/cheat/cheatsheets/personal/git-emoji
