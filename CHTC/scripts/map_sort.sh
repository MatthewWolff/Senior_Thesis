#!/bin/bash
set -e -x

GLUST=/mnt/gluster/mwolff3
REF=$1 # .fna 
META=${2%*.tgz} # .fastq
OUT=${REF%.*}_vs_${META%.*}.sam

# java installation
tar -xzf $GLUST/jdk-10_linux-x64_bin.tar.gz
export PATH=$(pwd)/jdk-10/bin:$PATH
export JAVA_HOME=$(pwd)/jdk-10
echo "untarred java" && echo
# samtools
tar -xzf $GLUST/samtools.tar.gz
export PATH=$(pwd)/samtools/bin:$PATH
echo "untarred samtools" && echo
# bbmap
wget https://sourceforge.net/projects/bbmap/files/latest/download -O BBMap.tar.gz &>/dev/null
tar -xzf $_ && rm $_
export PATH=$(pwd)/bbmap:$PATH
echo "untarred bbmap" && echo

# transfer files in 
mkdir -p metagenome/ refgenome/ $GLUST/mapping_results/ # make output folder too
echo "transferring in $REF and $META"
cp $GLUST/$REF refgenome/
tar -xzf $GLUST/${META}.tgz -C metagenome/

echo "beginning mapping/sorting pipeline"
MAP_PARAMS='outm=stdout idtag minid=0.9 nodisk -Xmx48g' # minid to capture all strains 
bbmap.sh ref=refgenome/$REF in=metagenome/$META $MAP_PARAMS | samtools sort - -o $OUT
tar -czvf $GLUST/mapping_results/${OUT}.tgz $OUT --remove-files
echo "done. created $OUT!"
exit
