FROM ubuntu:20.04

# from https://rtfm.co.ua/en/docker-configure-tzdata-and-timezone-during-build/
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# endfrom

RUN apt-get update \
    && apt-get install -y wget mpich ghostscript graphicsmagick gdal-bin ffmpeg cmake libxt-dev libxaw7-dev libhdf5-dev libnetcdff-dev libopenmpi-dev bc gfortran libxml2-dev perl gcc g++ git tar gzip ssh ca-certificates zlib1g-dev

RUN mkdir /data

COPY ShinnecockInlet si
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


# RUN apt-get install -y vim
ENV PATH="/adcirc/build:${PATH}"

RUN apt-get install -y python3-pip
RUN apt-get install netcdf-bin
