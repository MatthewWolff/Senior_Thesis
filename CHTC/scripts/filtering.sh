#!/bin/bash
set -e -x
GLUST=/mnt/gluster/mwolff3
for file in `ls $GLUST/*.fastq.tar.gz`; do # list all files 
  if [[ ! -f $GLUST/${file%.*}_filtered.tgz ]]; then # make sure hasn't been filtered 
    echo `basename $file .fastq.tar.gz`
  fi  
done > unfiltered_files
METAGENOMES=$(cat unfiltered_files) && rm unfiltered_files

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
mkdir -p metagenomes/
for raw in $METAGENOMES; do
  tar -xzf $GLUST/${raw}.fastq.tar.gz -C metagenomes/ # transfer in
  input=metagenomes/${raw}.fastq; output=${raw}_filtered.fastq
  bbduk.sh in=$input out=$output qtrim=r trimq=10 maq=10 # filter! 
  # efficient disk usage + naming -> won't read in .tgz files -> won't mistakenly read filtered
  rm $input && tar -czvf $GLUST/${output}.tgz $output --remove-files 
done
echo "filtered metagenomes!"
exit
