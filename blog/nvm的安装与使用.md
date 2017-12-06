author: me
title: nvm的安装与使用
date: 2017-11-29 20:27:42
tags: 
    - node
    - nvm
---


# nvm的安装与使用


node发展速度很快，因此版本也随之快速变化，因此很有必要使用一个node版本管理工具，之前使用过一个叫[n](https://github.com/tj/n)的工具, 不过好久没有更新了，因此找到了另一个工具 [nvm](https://github.com/creationix/nvm), 还有人用go写了一个[windows版的nvm](https://github.com/coreybutler/nvm-windows)。

## 在linux上安装nvm

使用 curl:

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
```

或者使用wget:

```
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
```

然后将下列的代码加入 ~/.bashrc 或者 `~/.zshrc` 中:

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh" # This loads nvm
```

然后执行:

```
source ~/.bashrc  

#或者  

source ~/.zshrc
```

## 使用nvm安装指定版本的node

由于在国内直接使用 nvm 安装node还是会很慢，因此我们可以自定义下载的来源,
可以使用[淘宝软件源](https://npm.taobao.org/mirrors)，方法如下:

### 第一种

```
NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
```

设置上述环境变量，可以将其加入到 `.bash_profile`, `.bashrc` 或者
`.zshrc`等文件中。然后直接使用 `nvm install version`安装指定版本的node

### 第二种

直接使用下列命令安装指定版本的 node:

```
NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node nvm install version
```

## nvm 的常用命令

除了上述的安装命令，还有一下其他命令需要了解

### nvm ls

查看当前已经安装的 node 版本

### nvm use version

选择要使用的 node 版本

### nvm current

查看当前使用的 node 版本

### nvm ls-remote

查看所有可以安装的 node 版本的列表

### nvm uninstall version

卸载已经安装的 node 版本
