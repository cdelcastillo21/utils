#!/bin/bash
# Install DUF on ubuntu18 - https://github.com/muesli/duf

mkdir /data/duf-install
cd /data/duf-install
wget https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb
dpkg -i duf_0.6.2_linux_amd64.deb
cd ..
rm -rf duf-install
