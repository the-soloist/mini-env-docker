FROM ubuntu:17.04

ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.ustc.edu.cn\/ubuntu-old-releases/g" /etc/apt/sources.list && \
    sed -i "s/http:\/\/security.ubuntu.com/http:\/\/mirrors.ustc.edu.cn\/ubuntu-old-releases/g" /etc/apt/sources.list && \
    sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list && \
    sed -i "s/^[^#].*archive\.canonical\.com*/#&/g" /etc/apt/sources.list

RUN apt-get update && apt-get -y dist-upgrade locales && \
    apt-get install -y tzdata

RUN locale-gen zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8


### config root env ###
WORKDIR /root

COPY ./docker/scripts/ /root/scripts/
COPY ./docker/tools/ /root/tools/
COPY ./config/bashrc /root/.bashrc
COPY ./config/pip /root/.pip

RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get install -y gcc g++ make cmake python3 python3-pip build-essential && \
    apt-get install -y gdb openssh-server git vim tmux && \
    apt-get install -y socat net-tools iputils-ping wget curl tcpdump && \
    apt-get install -y lib32z1

# edit configurations
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

# remove cached file
RUN apt-get clean


### end ###
COPY ./docker/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

EXPOSE 22
