# mini-env-docker

## 使用说明

### 下载仓库

```sh
git clone --recursive https://github.com/the-soloist/mini-env-docker
```

### 安装依赖

```sh
bash ./setup.sh
```

### 启动/关闭容器

```sh
docker-compose up --build <service-name>
docker-compose down
```

### 容器环境信息

| 镜像                  | 系统版本     | libc 版本 | ssh 端口映射 |
| --------------------- | ------------ | --------- | ------------ |
| mini-env/ubuntu-16.04 | Ubuntu 16.04 | 2.23      | 62160 -> 22  |
| mini-env/ubuntu-17.04 | Ubuntu 17.04 | 2.24      | 62170 -> 22  |
| mini-env/ubuntu-17.10 | Ubuntu 17.10 | 2.26      | 62171 -> 22  |
| mini-env/ubuntu-18.04 | Ubuntu 18.04 | 2.27      | 62180 -> 22  |
| mini-env/ubuntu-18.10 | Ubuntu 18.10 | 2.28      | 62181 -> 22  |
| mini-env/ubuntu-19.04 | Ubuntu 19.04 | 2.29      | 62190 -> 22  |
| mini-env/ubuntu-19.10 | Ubuntu 19.10 | 2.30      | 62191 -> 22  |
| mini-env/ubuntu-20.04 | Ubuntu 20.04 | 2.31      | 62200 -> 22  |
| mini-env/ubuntu-20.10 | Ubuntu 20.10 | 2.32      | 62201 -> 22  |
| mini-env/ubuntu-21.04 | Ubuntu 21.04 | 2.33      | 62210 -> 22  |
| mini-env/ubuntu-22.04 | Ubuntu 22.04 | 2.34      | 62220 -> 22  |
| mini-env/ubuntu-22.10 | Ubuntu 22.10 | 2.36      | 62221 -> 22  |

### ssh 登录

默认没有设置 root 的密码，只能通过密钥登录

```sh
ssh-keygen -b 4096
docker cp $HOME/.ssh/id_rsa.pub <container-id>:/root/.ssh/authorized_keys
ssh root@127.0.0.1 -p <port>
```

或者将本地的 key 复制到容器中，用于远程连接

```sh
docker cp $HOME/.ssh/authorized_keys <container-id>:/root/.ssh/authorized_keys
```

如果是通过 docker-compose 启动，也可以修改 ./ssh 目录下的 authorized_keys 文件

### xinetd 启动

```sh
cd /root/scripts/xinetd
vim xinetd.conf
bash ./xinetd.sh
```

## 工具包

- python3、pip3
- gdb、vim、tmux、socat

## 默认配置

- gdb
  - 插件：peda、gef、pwndbg、Pwngdb
  - 插件对应启动命令：gdb-gef、gdb-peda、gdb-pwndbg
- tmux
  - 插件：
    - tpm、tmux-mem-cpu-load、tmux-prefix-highlight、tmux-sensible、tmux-sidebar、tmux-yank
  - 配置：
    - 默认 prefix 为 C-x
- pip
  - 默认源：https://pypi.tuna.tsinghua.edu.cn/simple
- apt
  - 默认源：http://mirrors.tuna.tsinghua.edu.cn
