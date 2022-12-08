FROM jupyter/tensorflow-notebook

USER root

# from https://rtfm.co.ua/en/docker-configure-tzdata-and-timezone-during-build/
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# endfrom

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
    lolcat fortune \
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
	     -DBUILD_PADCIRC=ON \ 
	     -DBUILD_PADSWAN=ON && \ 
	     make -j6
ENV PATH="${HOME}/adcirc/build:${PATH}"

# FigureGen Local Install
# RUN wget ftp://ftp.soest.hawaii.edu/gmt/gmt-4.5.18-src.tar.bz2 && \
RUN cd "/" && wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/lsa/gmt/gmt-4.5.18-src.tar.bz2 && \
    tar -xf gmt-4.5.18-src.tar.bz2 && cd gmt-4.5.18/ && \
    ./configure --enable-netcdf && make && make install-gmt && \
    make install-data && \
    make clean
RUN cd "/" && cd gmt-4.5.18 && \
    wget https://fossies.org/linux/misc/GMT/gshhg-gmt-2.3.7.tar.gz && \
    tar -zxvf gshhg-gmt-2.3.7.tar.gz && \
    cd share && mkdir coast && cd coast && mv ../../gshhg-gmt-2.3.7/* .
COPY FigureGen/FigureGen.F90 figuregen/
COPY FigureGen/cmake/FindNetCDF.cmake figuregen/cmake/
COPY FigureGen/CMakeLists.txt figuregen/
RUN cd figuregen && ls && mkdir build && cd build && \
    cmake .. -DCMAKE_Fortran_COMPILER=mpif90 \
    	     -DUSE_MPI=ON \
	     -DUSE_NETCDF=ON && \
    make
ENV PATH="${HOME}/figuregen/build:/gmt-4.5.18/bin:${PATH}"
# 
# # Other utilities
# RUN wget https://github.com/dandavison/delta/releases/download/0.14.0/git-delta-musl_0.14.0_amd64.deb && \
#     dpkg -i git-delta-musl_0.14.0_amd64.deb && \
#     rm git-delta-musl_0.14.0_amd64.deb
# RUN wget https://github.com/bootandy/dust/releases/download/v0.8.3/du-dust_0.8.3_amd64.deb && \
#     dpkg -i du-dust_0.8.3_amd64.deb && \
#     rm du-dust_0.8.3_amd64.deb
# 
# ENV LAB_USER=jovyan
# ENV LAB_USER_HOME=/home/jovyan
# 
# # Copy scripts and such
# COPY --chown=$LAB_USER utils/python/jupyter.yml $LAB_USER_HOME/env.yml
# COPY --chown=$LAB_USER utils/python/requirements.txt $LAB_USER_HOME/requirements.txt
# COPY --chown=$LAB_USER utils/git/gitconfig $LAB_USER_HOME/.gitconfig
# COPY --chown=$LAB_USER utils/fish/config.fish $LAB_USER_HOME/config.fish
# COPY --chown=$LAB_USER utils/fish/fish_greeting.fish $LAB_USER_HOME/fish_greeting.fish
# COPY --chown=$LAB_USER utils/containers/jupyter-tensorflow/vimrc $LAB_USER_HOME/.vimrc
# RUN mkdir $LAB_USER_HOME/.tmux
# COPY --chown=$LAB_USER utils/tmux/gpakosz/tmux.conf $LAB_USER_HOME/.tmux/.tmux.conf 
# COPY --chown=$LAB_USER utils/tmux/gpakosz/tmux.conf.local $LAB_USER_HOME/.tmux.conf.local
# RUN ln -sf $LAB_USER_HOME/.tmux/.tmux.conf $LAB_USER_HOME/.tmux.conf
# COPY --chown=$LAB_USER utils/containers/jupyter-tensorflow/fish_install.fish $LAB_USER_HOME/fish_install.fish
# COPY --chown=$LAB_USER utils/containers/jupyter-tensorflow/entry.sh $LAB_USER_HOME/entry.sh
# # RUN chmod +x $LAB_USER_HOME/entry.sh && ./entry.sh
# 
# USER jovyan
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# RUN mamba install -y ptpython \
# 		     ipykernel \
# 		     nodejs \
# 		     jupyterlab \
# 		     flake8 \
# 		     black \
# 		     isort \
# 		     autopep8 \
# 		     ipympl \
# 		     yapf \
# 		     jupyter_bokeh \
# 		     jupyterlab-lsp \
# 		     python-lsp-server  \
# 		     jupyterlab-git \
# 		     jupyterlab-spellchecker \
# 		     jlab-enhanced-cell-toolbar \
# 		     fish \
# 		     tmux \
# 		     vim \
# 		     cmake \
# 		     go \
# 		     jq \
# 		     lazygit \
# 		     fzf \
# 		     htop \
# 		     exa \
# 		     ripgrep \
# 		     the_silver_searcher \
# 		     bat \
# 		     hyperfine \
# 		     httpie \
# 		     broot \
# 		     tokei \
# 		     glow \
# 		     trash-cli \
# 		     ipydrawio \
# 		     curl
# 
# RUN pip install jupyterlab-citation-manager \
# 		aquirdturtle_collapsible_headings \
# 		ipympl \
# 		jupyterlab_code_formatter \
# 		jupyterlab-topbar  \
# 		jupyterlab-topbar-text \
# 		jupyterlab-link-share  \
# 		jupyterlab_recents \
# 		jupyterlab-vim \
# 		jupyterlab_theme_solarized_dark
# 
# RUN jupyter lab build
# 
# RUN mkdir -p $LAB_USER_HOME/.vim/autoload/ && cd $LAB_USER_HOME/.vim/autoload && \
#     wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
#     vim +PlugInstall +qall
# 
# RUN mamba init fish 
# RUN mamba install -y curl -c conda-forge
# RUN fish fish_install.fish && \
#     cat $LAB_USER_HOME/config.fish >> $LAB_USER_HOME/.config/fish/config.fish
# 
# USER root
