FROM ubuntu:16.04

# Install dependencies owo
RUN apt-get update && apt-get install -y \
	build-essential \
	libgsl0-dev \
	sudo \
	python3 \ 
	git \
	python3-pip \
	libgsl-dev \
	liblapack-dev \
	liblapacke-dev \
	default-jre \
	samtools \
	bwa \
	r-base 
RUN pip3 install cython numpy biopython setuptools
RUN cd ~ && git clone https://github.com/MatthewWolff/DESMAN.git && \
	cd DESMAN && \
	sudo ./setup.py install && \
	mkdir -p metagenome/ refgenomes/
	

