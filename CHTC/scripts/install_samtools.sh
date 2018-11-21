#!/bin/bash
wget https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2
tar -xjvf samtools-1.8.tar.bz2 && rm samtools-1.8.tar.bz2
mkdir samtools
cd samtools-1.8
./configure --prefix=$(pwd)/../samtools --disable-lzma
make
make install
cd ..
tar -czf samtools.tar.gz samtools/
