FROM clos21/adcirc:frontera-beta

RUN apt-get update \
    && apt-get install -y ghostscript graphicsmagick gdal-bin ffmpeg libxt-dev libxaw7-dev libhdf5-dev libnetcdff-dev

RUN mkdir -p /data

run wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/lsa/gmt/gmt-4.5.18-src.tar.bz2 && \
    && tar -xf gmt-4.5.18-src.tar.bz2 && cd gmt-4.5.18/ \
    && ./configure --enable-netcdf && make && make install-gmt \
    && make install-data && make clean && \
    wget https://fossies.org/linux/misc/GMT/gshhg-gmt-2.3.7.tar.gz && \
    tar -zxvf gshhg-gmt-2.3.7.tar.gz \
    && cd share && mkdir coast && cd coast && mv /gmt-4.5.18/gshhg-gmt-2.3.7/* .

COPY FigureGen/FigureGen.F90 figuregen/
COPY FigureGen/cmake/FindNetCDF.cmake figuregen/cmake/
COPY FigureGen/CMakeLists.txt figuregen/

RUN cd figuregen && ls && mkdir build && cd build \
    && cmake .. -DCMAKE_Fortran_COMPILER=mpif90 -DUSE_MPI=ON -DUSE_NETCDF=ON && make

ENV PATH="/figuregen/build:/gmt-4.5.18/bin:${PATH}"
