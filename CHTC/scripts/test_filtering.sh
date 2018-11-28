#!/bin/bash
set -e -x
mkdir -p files/
wget http://opengene.org/fastp/fastp &>/dev/null && chmod +x fastp && mv fastp files/

tar -xzf /mnt/gluster/mwolff3/2010-07-15-EBPR_filtered.fastq.tgz -C files/ 
files/fastp -i files/2010-07-15-EBPR_filtered.fastq -o files/2010-07-15-EBPR.filtered --cut_by_quality3
rm files/2010-07-15-EBPR* && mv fastp.html postfilter_2010-07-15.html

tar -xzf /mnt/gluster/mwolff3/2010-07-15-EBPR.fastq.tar.gz -C files/
files/fastp -i files/2010-07-15-EBPR.fastq -o files/2010-07-15-EBPR.filtered --cut_by_quality3
rm files/2010-07-15-EBPR* && mv fastp.html prefilter_2010-07-15.html

rm fastp.json

exit
