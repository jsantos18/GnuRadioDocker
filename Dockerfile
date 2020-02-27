FROM ubuntu:18.04

RUN apt update

ENV TZ=US
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install cmake git g++ libboost-all-dev python-dev python-mako \
python-numpy python-wxgtk3.0 python-sphinx python-cheetah swig libzmq3-dev \
libfftw3-dev libgsl-dev libcppunit-dev doxygen libcomedi-dev libqt4-opengl-dev \
python-qt4 libqwt-dev libsdl1.2-dev libusb-1.0-0-dev python-gtk2 python-lxml \
pkg-config python-sip-dev libboost-all-dev libusb-1.0-0-dev python-mako doxygen python-docutils cmake build-essential -y

WORKDIR /resources
RUN git clone https://github.com/EttusResearch/uhd.git && cd uhd && git checkout UHD-3.9.LTS
WORKDIR /resources/uhd/host
RUN git submodule update --init --recursive && mkdir build 
WORKDIR /resources/uhd/host/build
RUN cmake .. && make -j8 && make install


WORKDIR /resources
RUN git clone https://github.com/gnuradio/gnuradio.git  && cd gnuradio && git checkout v3.7.13.5
WORKDIR /resources/gnuradio
RUN git submodule update --init --recursive && mkdir build
WORKDIR /resources/gnuradio/build
RUN cmake .. && make -j8 && make install

RUN mkdir /root/.local /root/.local/share

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PYTHONPATH=/usr/local/lib/python2.7/dist-packages

CMD [ "/bin/bash" ]