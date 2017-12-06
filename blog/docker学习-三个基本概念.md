author: me
title: docker学习-三个基本概念
date: 2017-08-06 09:57:59
tags:
    - docker
---

容器技术可以说是目前很热门也很重要的技术之一，对目前的软件行业的运维和部署方案提供了很多方便。docker就是其中最热门的技术之一。

## docker的三个基本概念

- 镜像(Image)
- 容器(Container)
- 仓库(Repository)

## 安装docker

我用的是ubuntu 16.04系统,安装docker很方便。

```bash
# 更新系统
sudo apt-get update

# 安装依赖
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# 添加官方GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce
```
 
windows下可以到官网[https://www.docker.com/](https://www.docker.com/)直接下载安装包
 
## 镜像

Docker镜像类似于虚拟机镜像，相当于Docker引擎的只读模板，Docker可以在镜像的基础上创建容器。

### 获取镜像
 
镜像下载的命令是：

```
docker pull NAME[:TAG]
```

NAME指镜像名，TAG指镜像标签,如不指定TAG，则下载最新镜像
 
例如，以下两个命令是相同的：

```
sudo docker pull ubuntu
sudo docker pull ubuntu:latest
```
 
也可以指定其它服务器的仓库

```
sudo docker pull dl.dockerpool.com:5000/ubuntu
```

其中的`dl.dockerpool.com:5000`就是注册服务器,默认的注册服务器是`registry.hub.docker.com`,可以不写
 
### 查看本地镜像
 
```
sudo docker images
```

![docker-images](http://7xo1su.com1.z0.glb.clouddn.com/docker-images.png)
 
- REPOSITORY: 表示来自于那个仓库
- TAG： 镜像的标签
- IMAGE ID： 镜像的ID号(镜像唯一标识)
- CREATED： 镜像创建时间
- SIZE： 镜像大小
 
### 获取镜像详细信息
```
sudo docker inspect <镜像ID(前几个字符就行，只要能区分开)>
```

### 搜寻镜像

`docker search`用来搜索

参数：

```
    --automated=false   #仅显示自动常见的镜像
    --s, --stars=<num>   #显示几星级的镜像
```
### 创建镜像

- 基于已有容器创建镜像

在对正在运行中的容器进行更改之后，可以使用以下命令创建一个**新镜像**

```
docker commit [options] <running_container> [Resposity[:tag]]
```

选项：

```
    -a, --author=""   作者
    -m， --message=""  提交说明信息
    -p, --pause=true   提交时暂停容器运行
```

创建成功后，返回镜像ID

- 基于Dockerfile创建镜像
 
Docker基本语法

```
FROM        指定某个镜像为基础镜像
MAINTAINER  维护者
RUN         要在创建中运行的命令,安装软件
ADD         复制本地文件到镜像中
EXPOSE      向外部开放端口
CMD         容器启动后运行的命令，一个dockerfile只能有一个，多条只执行最后一条
ENV         设置环境变量
#           注释
...
```

简单例子：

```
# Dockerfile
# This is my image
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

Docker写完之后，在当前目录下执行build命令来构建镜像，`-t`用来添加标签

```
docker build -t="mydockerimage" .
```

注意最后有一个点，指的是的Dockerfile所在目录，即当前目录下，可以换成其它
 
- 从本地导入

还有一种方法就是从本地导入镜像，可以使用[下载openvz的模板](http://openvz.org/Download/templates/precreated)来创建
 
然后使用import命令导入
```
sudo cat <templates_name> | docker import - <myimage>
```
 
### 添加标签
`docker tag <IMAGE> <tagname> `
 
 
### 镜像的导入和导出
 
- 导出镜像

```
docker save -o <导出文件的名字.tar> <image_name>
```

- 导入镜像

```
docker load --input <载入文件名字.tar>
```
 
### 删除镜像

`docker rmi <tag>` 只删除该标签的镜像
`docekr rmi <ID>`  先删除该镜像的所有标签，然后删除镜像本身
 
> 删除前，需要删除该镜像的所有容器，若要强行删，使用-f
 
### 上传镜像

使用push上传镜像到共享仓库，需要先注册docker hub账号
 
```
docker push <image_name>
```

## 容器

Docker容器是完整的文件系统，docker就是用它来运行应用，类似于轻量级的虚拟机，可以将其启动、开始、停止、删除等。容器从镜像启动时，docker会在镜像的最上层创建一个可写层。

### 启动容器

docker容器离不开docker镜像，容器以镜像为模板启动的，会在只读的镜像层上挂载一层可读写层，镜像本身是不变的。
 
启动一个新容器很简单,eg:

```
docker run ubuntu:latest /bin/echo "hello world"
```

以上命令运行一个容器，然后在容器中执行`/bin/echo "hello world"`后终止容器, eg:

```
docker run -i -t ubuntu:latest /bin/bash
```

以上会交互式的启动容器的bash,就像本地linux的终端一样，其中`-t`指让docker分配一个伪终端，绑定到容器的标准输出上，`-i`让容器的标准输出保持打开，这样就可以达到本地bash基本一样的效果
 
eg:

```
docker run -d ubuntu:latest /bin/bash
```

以上称之为**守护态运行**，容器会在后台运行，返回该容器的id,可以使用`docker ps`来查看正在运行的镜像，就可以看到在后台运行的容器.`docker logs　<contain_name>`可以用来查看容器的日志信息
 
启动停止的容器, 使用`docker ps -a`可以查看当前所有的容器，找到你想启动的容器

```
docker start <container_id>
```
 
### 终止容器

容器会在执行的应用终结后自动停止，若启动的是bash可通过exit退出
 
或者使用`docker stop`直接终止运行中容器
```
docker stop <container_id>
```

### 进入容器

当容器进入守护态后，有以下方法可以进入容器执行操作
- attach
- nsenter
- ...待补充
 
### 容器的导出和载入

- 导出

```
docker export <导出文件名.tar> <container_name>
```

- 导入

从导出的**容器**快照，载入为**镜像**

```
sudo cat <导入文件名.tar> | docker import - <myimage>
```
 
### 删除容器

```
docker rm <container_name>
```

**注意**:删除镜像用的是`docker rmi <image_name>`,若要删除一个执行中的容器需要使用-f

## 仓库

docker仓库类似于github之类的代码仓库，是托管存放镜像文件的地方。docker仓库分为公开仓库（Docker Hub等）,私有仓库。
 
