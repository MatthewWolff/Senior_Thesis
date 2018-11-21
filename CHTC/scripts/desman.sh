#!/bin/bash
set -e
set -x
cd ~/DESMAN && echo "working directory: `pwd`" && echo
cd .. && ls && pwd && echo
cd DESMAN && ls && pwd && echo
echo "DESMAN binary: `which desman || echo 'no desman in path'`"

find . -name refgenomes
ls -R /
mkdir -p metagenome
echo "created metagenome/ folder, transferring data now..."
#tar -xzf /mnt/gluster/mwolff3/2013-05-23-EBPR.fastq.tar.gz -C metagenome/
cp /mnt/gluster/mwolff3/Acc* refgenomes/
echo "transferred data over"
mkdir -p desman/test && builtin cd desman/test
Variant_Filter.py ../../data/contig_6or16_genesL_scgCOG0015.freq -o COG0015_out -p
desman COG0015_outsel_var.csv -g 5 -e COG0015_outtran_df.csv -o COG0015_out_g5 -i 50
head COG0015_out_g5/*

echo "complete." && exit 0
