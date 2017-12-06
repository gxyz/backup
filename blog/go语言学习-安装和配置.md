author: me
title: go语言学习-安装和配置
date: 2017-07-16 21:01:49
tags:
    - golang
    - go
    - linux
---

go的安装方式主要有两种，一种直接使用系统自带的软件源来安装，比如 ubuntu 可以直接使用 apt 安装，但通常这种方式安装的都不会是最新的。所以通常直接下载最新的安装包，可以到[GoCN](https://dl.gocn.io/)下载。下面就简述一些go语言的安装与配置。

## 安装go

我使用的是操作系统是 ubuntu16.04，所以下面的安装过程是以 ubuntu 为例的，其他系统安装思路都是相同的。 

1. 到[GoCN](https://dl.gocn.io/)下载对应系统的go的安装包, 这里我下载的是`go1.8.3.linux-amd64.tar.gz`
2. 解压安装包`tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz`
3. 添加环境变量`export PATH=$PATH:/usr/local/go/bin`到`/etc/profile`（全系统安装）或 `.bashrc`(bash中) 或`.zshrc`(zsh中),这里我使用的是 zsh, 所以只需要在 .zshrc中添加该export。
4. 然后执行`source .zshrc`更新更改

至此 go 语言已经安装成功了。

## 安装到指定位置

通常我们都是将 go 安装到 `/usr/local` 中的，但是如果想自定义安装目录，可以使用下面的方法：

1. 将第二步中的`/usr/local`改为你想要的, 例如`$HOME/go`
2. 添加环境变量`export GOROOT=$HOME/go`和`export PATH=$PATH:$GOROOT/bin`到对应文件中

## 设置go的工作空间

安装完go之后，我们还需要设置工作空间目录, Go代码必须放在工作空间内。它其实就是一个目录，其中包含三个子目录：

1. src 目录包含Go的源文件（我们的代码就放在其中），它们被组织成包（每个目录都对应一个包）
2. pkg 目录包含包对象
3. bin 目录包含可执行命令

设置工作空间的环境变量`export GOPATH=$HOME/gowork`，将bin目录加入环境变量里 `export PATH=$PATH:$GOPATH/bin`，同样需要将它们添加到前面说的对应的文件中。


## 初体验

go的源码用该放到工作空间中的src目录中

如果有github账户,应该将`github.com/user_name`作为你的源码路径,这样在上传到github时会很方便,即使不上传也没关系,反正源码可以放到src目录下的任何位置

例子：假设我的github账户是 gogogo, 那么我会在 src 目录下新建一个 `github.com/gogogo` 目录，然后在其中创建一个 `hello.go` 文件，来写我们的第一个go程序:

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello World!")
}
```

然后执行 `go run hello.go` 就可以允许我们的 hello.go 了，具体内容后面再说

## 开发工具

这里使用sublime text作为go的开发工具

只需安装`gosublime`,然后在`Preferences > package setting > gosublime > user setting`中加入以下:

```
{
    "env": {
        "GOPATH": "$HOME/go_work",
        "GOROOT": "/usr/local/go"
    }
}
```

