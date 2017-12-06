author: me
title: Dockerfile常用指令简记
date: 2017-11-28 20:27:42
tags: 
    - docker
    - Dockerfile
---


## FROM

指定 base 镜像，新镜像将以此 base 镜像为基础来构建。

```
FROM ubuntu
```

## MAINTAINER

指定镜像的维护者，可以是任意字符串。例如:

```
MAINTAINER gdb
```

## RUN

创建镜像中运行的命令,可以用于安装软件或者运行一些配置命令,
这个命令通常会产生新的镜像层。

```
RUN apt-get update
```

## CMD

指定容器启动时默认运行的命令。一个dockerfile 中可以使用多个 CMD 指令，但只有最后一个会生效。并且可以使用 docker run 命令的参数来覆盖

## ENTRYPOINT

指定容器启动时运行的命令。跟CMD命令类似，可以有多个，但是只有最后一个生效。CMD 或 docker run 之后的参数会被当做参数传递给 ENTRYPOINT。

## COPY

将文件从宿主机复制到镜像中, 例如:

```
COPY src dest
COPY ["src", "dest"]
```

src是宿主机中的文件或目录，dest是复制到镜像中的目标文件或目录。

## ADD

将文件从宿主机添加到镜像中,与COPY命令类型，只是当要添加的文件是归档文件（tar, zip等）时，该文件会被自动解压到目标文件或者目录处。

```
ADD src dest
ADD ["src" "dest"]
```

## ENV

指定环境变量，在此指令之后的命令都可以使用这个环境变量。

```
ENV USERNAME gdb
```

## EXPOSE

指定容器中要监听的端口，并将该端口暴露出来，供我们在容器外使用

```
EXPOSE 80  # 暴露容器的80端口
```

## WORKDIR

指定工作目录，在此指令之后运行的指令都在这个工作目录下工作，例如RUN, CMD, ENTRYPOINT, ADD 或 COPY 指令等等

```
WORKDIR ~/
RUN mkdir tmp
```

上面两条指令，设置工作目录为用户的家目录，然后在该目录下新建了一个 tmp 目录.

## 例子

```
# Dockerfile
# dockerfile中的评论以#开头

FROM ubuntu:latest
MAINTAINER your_name <your_email>
RUN apt-get update
RUN apt-get install vim
RUN cd ~
RUN touch README.txt

// 暴露容器的80端口
EXPOSE 80
CMD echo hello world
```

## 构建方式

```
docker build -t new-image-name dockerfile-path
```
