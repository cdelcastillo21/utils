FROM ubuntu:20.04
# FROM jupyter/tensorflow-notebook

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

# Other utilities
RUN wget https://github.com/dandavison/delta/releases/download/0.14.0/git-delta-musl_0.14.0_amd64.deb && \
    dpkg -i git-delta-musl_0.14.0_amd64.deb && \
    rm git-delta-musl_0.14.0_amd64.deb
RUN wget https://github.com/bootandy/dust/releases/download/v0.8.3/du-dust_0.8.3_amd64.deb && \
    dpkg -i du-dust_0.8.3_amd64.deb && \
    rm du-dust_0.8.3_amd64.deb

# ADCIRC Local Install
COPY adcirc adcirc
RUN mkdir -p adcirc/build && cd adcirc/build && cmake .. \
	     -DCMAKE_C_COMPILER=mpicc \
	     -DCMAKE_CXX_COMPILER=mpicxx \
	     -DCMAKE_Fortran_COMPILER=gfortran \
	     -DENABLE_GRIB2=OFF \
	     -DENABLE_DATETIME=ON \
	     -DENABLE_OUTPUT_NETCDF=ON \
	     -DBUILD_ADCPREP=ON \
	     -DBUILD_PADCIRC=ON && make -j6
ENV PATH="/adcirc/build:${PATH}"

# FigureGen Local Install
RUN mkdir -p /data
RUN wget ftp://ftp.soest.hawaii.edu/gmt/gmt-4.5.18-src.tar.bz2 \
    && tar -xf gmt-4.5.18-src.tar.bz2 && cd gmt-4.5.18/ \
    && ./configure --enable-netcdf && make && make install-gmt \
    && make install-data && make clean \
    && wget ftp://ftp.soest.hawaii.edu/gshhg/gshhg-gmt-2.3.7.tar.gz \
    && tar -zxvf gshhg-gmt-2.3.7.tar.gz \
    && cd share && mkdir coast && cd coast && mv /gmt-4.5.18/gshhg-gmt-2.3.7/* .
COPY FigureGen/FigureGen.F90 figuregen/
COPY FigureGen/cmake/FindNetCDF.cmake figuregen/cmake/
COPY FigureGen/CMakeLists.txt figuregen/
RUN cd figuregen && ls && mkdir build && cd build \
    && cmake .. -DCMAKE_Fortran_COMPILER=mpif90 -DUSE_MPI=ON -DUSE_NETCDF=ON && make
ENV PATH="/figuregen/build:/gmt-4.5.18/bin:${PATH}"

ENV LAB_USER=dev
ENV LAB_USER_HOME=/home/dev
ENV LAB_PSW=$psw
RUN useradd -rm -d $LAB_USER_HOME -s /bin/bash -g root -G sudo -u 1001 $LAB_USER && \
    echo "${LAB_USER}:foo" | chpasswd
USER $LAB_USER
WORKDIR $LAB_USER_HOME
ENV LAB_PSW=

# Copy scripts and such
COPY --chown=$LAB_USER utils/python/jupyter.yml env.yml
COPY --chown=$LAB_USER utils/python/requirements.txt requirements.txt
COPY --chown=$LAB_USER utils/git/gitconfig $LAB_USER_HOME/.gitconfig
COPY --chown=$LAB_USER utils/fish/config.fish $LAB_USER_HOME/config.fish
COPY --chown=$LAB_USER utils/fish/fish_greeting.fish $LAB_USER_HOME/fish_greeting.fish
COPY --chown=$LAB_USER utils/containers/ubuntu20/vimrc $LAB_USER_HOME/vimrc
COPY --chown=$LAB_USER utils/tmux/gpakosz/tmux.conf $LAB_USER_HOME/tmux.conf 
COPY --chown=$LAB_USER utils/tmux/gpakosz/tmux.conf.local $LAB_USER_HOME/tmux.conf.local
COPY --chown=$LAB_USER utils/containers/ubuntu20/fish_install.fish $LAB_USER_HOME/fish_install.fish
COPY --chown=$LAB_USER utils/containers/ubuntu20/entry.sh $LAB_USER_HOME/entry.sh

USER root 
RUN apt update && apt install curl
USER $LAB_USER
RUN chmod +x $LAB_USER_HOME/entry.sh && ./entry.sh
USER root 
RUN apt update && apt install curl

