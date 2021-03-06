FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    wget git python-dev cython libgsl0-dev cython gcc python-numpy python-scipy python-matplotlib x11-xserver-utils\
    && rm -rf /var/lib/apt/lists/* && echo "backend: svg" >> /etc/matplotlib

ENV MPLBACKEND=SVG 

WORKDIR /faststructure

RUN wget --no-check-certificate \
	https://github.com/rajanil/fastStructure/archive/master.tar.gz && \
	tar --strip-components=1 -xvzf master.tar.gz && \
	cd vars/ && \
	python setup.py build_ext --inplace && \
	cd .. && \
	python setup.py build_ext --inplace && \
	mkdir data/

WORKDIR /mnt

ENTRYPOINT ["/mnt"]
