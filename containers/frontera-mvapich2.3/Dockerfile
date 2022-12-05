FROM tacc/tacc-ubuntu18-mvapich2.3-ib

ENV LD_PRELOAD=
RUN apt-get update && apt-get install -y bc cmake wget perl git tar gzip ssh zlib1g-dev libnetcdff-dev libgrib-api-dev

COPY adcirc-cg /data/adcirc
RUN mkdir -p /data/adcirc/build && cd /data/adcirc/build && cmake .. \
	     -DCMAKE_C_COMPILER=mpicc \
	     -DCMAKE_CXX_COMPILER=mpicxx \
	     -DCMAKE_Fortran_COMPILER=mpif90 \
	     -DENABLE_GRIB2=ON \
	     -DENABLE_DATETIME=ON \
	     -DENABLE_OUTPUT_NETCDF=ON \
	     -DBUILD_ADCPREP=ON \
	     -DBUILD_PADCIRC=ON \
	     -DCMAKE_Fortran_FLAGS_RELEASE="$CFLAGS" \
	     -DCMAKE_C_FLAGS_RELEASE="$CFLAGS" && make -j6 && \
	     cp /data/adcirc/build/padcirc /data/adcirc/build/adcprep /usr/local/bin/ && \
	     rm -rf /data/adcirc

# COPY adcirc-cg-testsuite/adcirc/adcirc_shinnecock_inlet-parallel /data/si-test
