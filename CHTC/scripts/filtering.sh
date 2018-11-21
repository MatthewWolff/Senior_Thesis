#!/bin/bash
set -e -x
GLUST=/mnt/gluster/mwolff3
METAGENOME=`basename $1 .fastq.tar.gz` # filename should be argument
echo "filtering $METAGENOME" && echo

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


# transfer & filter metagenomes, then move to gluster
echo "beginning filtering..."
mkdir -p metagenome/
tar -xzf $GLUST/${METAGENOME}.fastq.tar.gz -C metagenome/ # transfer in
input=metagenome/${METAGENOME}.fastq; output=metagenome/${METAGENOME}_filtered.fastq
bbduk.sh in=$input out=$output qtrim=r trimq=10 maq=10 # filter! 
rm $input && tar -czvf $GLUST/$(basename $output).tgz $output --remove-files 
echo "filtered metagenome!"
