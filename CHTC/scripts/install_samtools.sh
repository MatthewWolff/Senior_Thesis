#!/bin/bash
set -ex
wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
tar -xjf samtools-1.9.tar.bz2 && rm $_
mkdir samtools
cd samtools-1.9
./configure --prefix=$(pwd)/../samtools --disable-lzma
make
make install
cd ..
tar -czf samtools.tar.gz samtools/
