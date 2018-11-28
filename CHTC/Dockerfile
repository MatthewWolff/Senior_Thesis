FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
	build-essential \
	libgsl0-dev \
	git-core \
	cmake \
	zlib1g-dev \
	libncurses-dev \
	patch \
	sudo \
	python3 \
	git \
	wget \
	parallel \
	bedtools \
	python3-pip \
	libcurl4-openssl-dev \
	libssl-dev \
	libgsl-dev \
	liblapack-dev \
	liblapacke-dev \
	default-jre \
	bwa \
	r-base
RUN pip3 install cython numpy biopython setuptools
RUN mkdir -p ~/bin ~/repos
RUN cd ~/repos && git clone https://github.com/MatthewWolff/DESMAN.git && \
        cd DESMAN && \
        sudo ./setup.py install && \
        mkdir -p metagenome/ refgenomes/
RUN cd ~/repos && git clone https://github.com/genome/bam-readcount.git && \
        mkdir bam-readcount-build && \
        cd bam-readcount-build && \
        cmake ../bam-readcount && \
        make && \
        cp bin/bam-readcount ~/bin
RUN cd ~/repos && wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2 && \
        tar -xjf samtools-1.3.1.tar.bz2 && \
	rm samtools-1.3.1.tar.bz2 && \
        cd samtools-1.3.1/ && \
        ./configure --enable-plugins --enable-libcurl --with-plugin-path=$PWD/htslib-1.3.1 && \
        make all plugins-htslib && \
        cp samtools ~/bin
RUN wget https://github.com/hyattpd/Prodigal/releases/download/v2.6.3/prodigal.linux && \
        mv prodigal.linux ~/bin/prodigal && \
        chmod +rwx ~/bin/prodigal
RUN wget https://desmandatabases.s3.climb.ac.uk/ncbi-blast-2.5.0+-x64-linux.tar.gz && \
        tar -xzf ncbi-blast-2.5.0+-x64-linux.tar.gz && \
        rm ncbi-blast-2.5.0+-x64-linux.tar.gz && \
        mv ncbi-blast-2.5.0+/bin/* ~/bin && \
        rm -rf ncbi-blast-2.5.0+/
RUN cd ~/repos && \
        mkdir diamond && \
        cd diamond && \
        wget http://github.com/bbuchfink/diamond/releases/download/v0.8.31/diamond-linux64.tar.gz && \
        tar -xzf diamond-linux64.tar.gz && \
	rm diamond-linux64.tar.gz && \
        cp diamond ~/bin

