FROM jupyter/tensorflow-notebook

USER root
WORKDIR /

# FigureGen Install
# from https://rtfm.co.ua/en/docker-configure-tzdata-and-timezone-during-build/
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# endfrom

RUN apt-get update \
    && apt-get install -y wget mpich ghostscript graphicsmagick gdal-bin ffmpeg cmake libxt-dev libxaw7-dev libhdf5-dev libnetcdff-dev

RUN mkdir /data

RUN wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/lsa/gmt/gmt-4.5.18-src.tar.bz2 \
    && tar -xf gmt-4.5.18-src.tar.bz2 && cd gmt-4.5.18/ \
    && ./configure --enable-netcdf && make && make install-gmt \
    && make install-data && make clean \
    && wget https://fossies.org/linux/misc/GMT/gshhg-gmt-2.3.7.tar.gz \
    && tar -zxvf gshhg-gmt-2.3.7.tar.gz \
    && cd share && mkdir coast && cd coast && mv /gmt-4.5.18/gshhg-gmt-2.3.7/* .

COPY FigureGen/FigureGen.F90 figuregen/
COPY FigureGen/cmake/FindNetCDF.cmake figuregen/cmake/
COPY FigureGen/CMakeLists.txt figuregen/

RUN cd figuregen && ls && mkdir build && cd build \
    && cmake .. -DUSE_MPI=ON -DUSE_NETCDF=ON && make

RUN apt-get remove -y cmake

ENV PATH="/figuregen/build:/gmt-4.5.18/bin:${PATH}"

USER root
WORKDIR /

RUN apt-get update \
    && apt-get install -y wget sshfs \
    mpich ghostscript graphicsmagick \
    gdal-bin ffmpeg cmake libxt-dev netcdf-bin \
    libxaw7-dev libhdf5-dev libnetcdff-dev \
    libopenmpi-dev bc gfortran libxml2-dev \
    perl gcc g++ git tar gzip ssh \
    ca-certificates zlib1g-dev \
    libcurl4-openssl-dev \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y

# ADCIRC Local Install
COPY adcirc adcirc
RUN mkdir -p adcirc/build && cd adcirc/build && cmake .. \
	     -DCMAKE_C_COMPILER=mpicc \
	     -DCMAKE_CXX_COMPILER=mpicxx \
	     -DCMAKE_Fortran_COMPILER=gfortran \
	     -DENABLE_GRIB2=ON \
	     -DENABLE_DATETIME=ON \
	     -DENABLE_OUTPUT_NETCDF=ON \
	     -DBUILD_ADCPREP=ON \
	     -DBUILD_ADCIRC=ON \
	     -DBUILD_PADCIRC=ON \
	     -DBUILD_ADCSWAN=ON \
	     -DBUILD_PADCSWAN=ON \
	     && make -j6 && \
	     mv adcirc padcirc adcprep adcswan padcswan /usr/bin/

WORKDIR /home/jovyan
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	apt-get update && \
        DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y \
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
	dpkg-reconfigure --frontend noninteractive tzdata
RUN DEBIAN_FRONTEND=noninteractive && \
    add-apt-repository ppa:o2sh/onefetch && \
    apt-get update && \
    apt-get install -y onefetch

# Install java 
RUN apt update -y && \
    apt install -y \ 
    	openjdk-17-jre-headless \
	tzdata \
	neofetch

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y

# Other utilities
RUN wget https://github.com/dandavison/delta/releases/download/0.14.0/git-delta-musl_0.14.0_amd64.deb && \
    dpkg -i git-delta-musl_0.14.0_amd64.deb && \
    rm git-delta-musl_0.14.0_amd64.deb
RUN wget https://github.com/bootandy/dust/releases/download/v0.8.3/du-dust_0.8.3_amd64.deb && \
    dpkg -i du-dust_0.8.3_amd64.deb && \
    rm du-dust_0.8.3_amd64.deb
RUN wget https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb && \
    sudo dpkg -i duf_0.8.1_linux_amd64.deb && \
    rm duf_0.8.1_linux_amd64.deb 

ENV LAB_USER=jovyan
ENV LAB_USER_HOME=/home/jovyan
# RUN useradd -rm -d $LAB_USER_HOME -s /bin/bash -g root -G sudo -u 1001 $LAB_USER && \
RUN echo "${LAB_USER}:foo" | chpasswd
USER $LAB_USER
WORKDIR $LAB_USER_HOME

USER $LAB_USER
SHELL ["/bin/bash", "-o", "pipefail", "-c", "-i"]
RUN mamba install -y ptpython \
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

RUN pip install jupyterlab-citation-manager \
		aquirdturtle_collapsible_headings \
		ipympl \
		jupyterlab_code_formatter \
		jupyterlab-topbar  \
		jupyterlab-topbar-text \
		jupyterlab-link-share  \
		jupyterlab_recents \
		jupyterlab-vim \
		jupyterlab_theme_solarized_dark

COPY --chown=$LAB_USER utils/containers/ubuntu22/vimrc $LAB_USER_HOME/.vimrc
RUN mkdir -p $LAB_USER_HOME/.vim/autoload/ && cd $LAB_USER_HOME/.vim/autoload && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall && \
    go env -w "CC=gcc" && \
    go env -w "CXX=g++" && \
    cd $LAB_USER_HOME/.vim/plugged/YouCompleteMe && \
    python install.py --all

RUN jupyter lab build

ENV PATH="/usr/games/:${PATH}"
COPY --chown=$LAB_USER utils/containers/jupyter-minimal/config.fish $LAB_USER_HOME/.config/fish/config.fish
COPY --chown=$LAB_USER utils/fish/fish_install.fish $LAB_USER_HOME/fish_install.fish
RUN fish fish_install.fish && \
    rm $LAB_USER_HOME/fish_install.fish
COPY --chown=$LAB_USER utils/fish/fish_greeting.fish $LAB_USER_HOME/.config/fish/functions/fish_greeting.fish
COPY --chown=$LAB_USER utils/containers/jupyter-minimal/fish_variables $LAB_USER_HOME/.config/fish/fish_variables

# tmux set-up
RUN mkdir -p $LAB_USER_HOME/.tmux
COPY --chown=$LAB_USER utils/tmux/gpakosz/tmux.conf $LAB_USER_HOME/.tmux/.tmux.conf 
COPY --chown=$LAB_USER utils/tmux/gpakosz/tmux.conf.local $LAB_USER_HOME/.tmux/.tmux.conf.local
RUN cd $LAB_USER_HOME && \ 
    ln -sf $LAB_USER_HOME/.tmux/.tmux.conf . && \
    ln -sf $LAB_USER_HOME/.tmux/.tmux.conf.local .

COPY --chown=$LAB_USER utils/git/gitconfig $LAB_USER_HOME/.gitconfig

RUN echo "fish" >> $LAB_USER_HOME/.bashrc

USER root

