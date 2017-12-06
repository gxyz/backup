author: me
title: 安装使用oh-my-zsh
date: 2016-12-03 18:21:14
tags:
---

oh-my-zsh是一个很棒的命令行工具,具有很多的工具,并且支持更换主题和安装插件,使shell更加易用.

<!--more-->

# 安装

## 安装zsh

oh-my-zsh是一个zsh shell的框架。

安装oh-my-zsh前需安装zsh

```shell
sudo apt-get install zsh
```
检查zsh是否正确安装
```shell
zsh --version
```
应输出`zsh 5.0.5 or 更高版本`

设置zsh为你的默认shell:
```shell
chsh -s $(which zsh)
```

## 安装oh-my-zsh
使用以下命令安装oh-my-zsh
```shell
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
或者
```shell
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

# 配置

## 更改主题

在用户家目录下有一个`.zshrc`文件，是zsh的配置文件。设置`ZSH_THEME`的值来设置主题,例如`ZSH_THEME="ys" `，这里我用的是ys主题，主题的目录在`~/.oh-my-zsh/themes`,大部分的主题在你安装oh-my-zsh时都已经下载到本地了。

## 使用插件

同样是在`.zshrc`文件中，设置`plugins=(git command-not-found)`,要使用的插件直接将它的名字加到括号中，以空格隔开。插件的目录在`~/.oh-my-zsh/plugins`,在你安装oh-my-zsh时插件也都已经下载到本地了。

更多详细的配置见[oh-my-zsh官网](http://ohmyz.sh/) 和 [github](https://github.com/robbyrussell/oh-my-zsh)
