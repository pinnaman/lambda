FROM amazonlinux:latest

RUN yum update && \
yum groupinstall "Development Tools" -y \
&&  yum install git -y \
&& yum install wget -y

RUN cd /usr/local/bin

RUN git clone https://github.com/festvox/flite.git

RUN cd flite && ./configure && make && make get_voices

RUN ln -s /usr/local/bin/flite/bin/flite /usr/local/bin/tts