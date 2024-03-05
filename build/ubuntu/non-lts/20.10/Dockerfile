FROM ubuntu:20.10

ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.ustc.edu.cn\/ubuntu-old-releases/g" /etc/apt/sources.list && \
    sed -i "s/http:\/\/security.ubuntu.com/http:\/\/mirrors.ustc.edu.cn\/ubuntu-old-releases/g" /etc/apt/sources.list && \
    sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list && \
    sed -i "s/^[^#].*archive\.canonical\.com*/#&/g" /etc/apt/sources.list

RUN apt-get update && apt-get -y dist-upgrade locales && \
    apt-get install -y tzdata lib32z1 xinetd tcpdump

RUN locale-gen zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8


### config root env ###
WORKDIR /root

COPY ./config/bashrc /root/.bashrc
COPY ./config/pip /root/.pip

RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get install -y gcc g++ make python3 python3-pip ruby ruby-dev build-essential && \
    apt-get install -y libc6-dbg libc6-dbg:i386 libseccomp-dev libgmp-dev libmpfr-dev libmpc-dev libssl-dev libffi-dev && \
    apt-get install -y gdb socat openssh-server net-tools iputils-ping && \
    apt-get install -y git vim tmux wget curl

# install pwn tools
RUN pip3 install pip --upgrade

# edit configurations
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

# remove cached file
RUN rm -rf /root/.cache && \
    rm -rf /root/.gem && \
    rm -rf /root/.pip && \
    rm -rf /root/files/glibc_* && \
    rm -rf /tmp/scripts
RUN apt-get clean


### end ###
COPY ./docker/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

EXPOSE 22
