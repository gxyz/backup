---
title: virtualenvwrapper的使用
date: 2017-04-11 22:00:27
tags:
    - python
---

## 安装

linux和mac下安装

```
pip install virutalenv virtualenvwrapper
```

windows下安装

```
pip install  virtualenvwrapper-win
```

在使用前需要在shell中执行

```
source /usr/local/bin/virtualenvwrapper.sh
```

将以下命令加入shell的配置文件中

```
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
```

## 列出已有环境

```
workon
```

## 创建环境

```
mkvirtualenv  temp1
mkvirtualenv  temp1
```

## 切换环境

```
workon temp1
workon temp2
```

## 删除环境

```
rmvirtualenv
```

## 退出环境

```
deactivate
```

## 创建项目

```
mkproject name
```

将会在前面配置的PROJECT_HOME下新建一个项目

## 我遇到的问题
在我第一次创建环境时，遇到了一个问题，导致环境创建失败，具体原因我也记不太清，解决办法如下:

```
sudo apt-get install python2.7-dbg
```