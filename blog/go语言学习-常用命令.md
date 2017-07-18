---
title: go语言学习-常用命令
date: 2017-07-17 20:27:46
tags:
    - go
    - golang
---

上一篇文章中记录了安装 golang 和配置开发环境，本文将学习的 go 命令行命令以及使用场景。

## 查看可用命令

直接在终端中输入 `go help` 即可显示所有的 go 命令以及相应命令功能简介，主要有下面这些:

- build: 编译包和依赖
- clean: 移除对象文件
- doc: 显示包或者符号的文档
- env: 打印go的环境信息
- bug: 启动错误报告
- fix: 运行go tool fix
- fmt: 运行gofmt进行格式化
- generate: 从processing source生成go文件
- get: 下载并安装包和依赖
- install: 编译并安装包和依赖
- list: 列出包
- run: 编译并运行go程序
- test: 运行测试
- tool: 运行go提供的工具
- version: 显示go的版本
- vet: 运行go tool vet

命令的使用方式为: `go command [args]`, 除此之外，可以使用`go help <command>` 来显示指定命令的更多帮助信息。

在运行 go help 时，不仅仅打印了这些命令的基本信息，还给出了一些概念的帮助信息:

- c: Go和c的相互调用
- buildmode: 构建模式的描述
- filetype: 文件类型
- gopath: GOPATH环境变量
- environment: 环境变量
- importpath: 导入路径语法
- packages: 包列表的描述
- testflag: 测试符号描述
- testfunc: 测试函数描述

同样使用 `go help <topic>`来查看这些概念的的信息。

## build 和 run 命令

就像其他静态类型语言一样，要执行 go 程序,需要先编译，然后在执行产生的可执行文件。`go build` 命令就是用来编译 go程序生成可执行文件的。但并不是所以的 go 程序都可以编译生成可执行文件的, 要生成可执行文件，go程序需要满足两个条件:

- 该go程序需要属于main包
- 在main包中必须还得包含main函数

也就是说go程序的入口就是 `main.main`, 即main包下的main函数,　例子(hello.go):

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello World!")
}
```

编译hello.go,然后运行可执行程序:

```bash
$ go run hello.go   # 将会生成可执行文件 hello
$ ./hello           # 运行可执行文件
Hello World!
```

上面就是 go build 的基本用法，另外如果使用 go build 编译的不是一个可执行程序，而是一个包，那么将不会生成可执行文件。

而 `go run` 命令可以将上面两步并为一步执行(不会产生中间文件)。

```bash
$ go run hello.go
Hello World!
```

上面两个命令都是在开发中非常常用的。

此外 go clean 命令，可以用于将清除产生的可执行程序:

```bash
$ go clean    # 不加参数，可以删除当前目录下的所有可执行文件
$ go clean sourcefile.go  # 会删除对应的可执行文件
```

## fmt 和 doc 命令

go 语言有一个褒贬不一的特性，就是对格式的要求很严格，我是很喜欢这个特性的，因为可以保持代码的清晰一致，编译组合开发，并且go还提供了一个非常强大的工具来格式化代码，它就是 `go fmt sourcefile.go`, 不过通常其实不需要我们手动调用，各种编辑器都可以帮助我们自动完成格式化。

`go doc` 命令可以方便我们快速查看包文档，`go doc package` 命令将会在终端中打印出指定 package 的文档。

另外有一个与 `go doc` 命令相关的命令是 `godoc`, 可以通过它启动我们自己的文档服务器:

```
godoc -http=:8080
```

然后我们就可与在浏览器`localhost:8080`中查看go文档了

## get 命令

这个命令同样也是很常用的，我们可以使用它来下载并安装第三方包, 使用方式:

```
go get src
```

从指定源上面下载或者更新指定的代码和依赖，并对他们进行编译和安装，例如我们想使用 beego 来开发web应用，我们首先就需要获取 beego:

```
go get github.com/astaxie/beego
```

这条命令将会自动下载安装 beego 以及它的依赖，然后我们就可以使用下面的方式使用:

```go
package main

import "github.com/astaxie/beego"   # 这里需要使用 src 下的完整路径

func main() {
    beego.Run()
}
```

## install 命令

用来编译和安装go程序，我们可以将它与 build 命令对比:

||install|build|
|---|---|---|
|生成的可执行文件路径|工作目录下的bin目录下|当前目录下|
|可执行文件的名字|与源码所在目录同名|默认与源程序同名，可以使用-o选项指定|
|依赖|将依赖的包放到工作目录下的pkg文件夹下|-|

## test 命令

顾名思义，用来运行测试的命令，这种测试是以包为单位的。需要遵循一定规则：

- 测试源文件是名称以“_test.go”为后缀的
- 测试源文件内含若干测试函数的源码文件
- 测试函数一般是以“Test”为名称前缀, 并有一个类型为“testing.T”的参数。

## 其他命令

其他命令不会经常使用，这里就不介绍了，真的用到的时候，直接使用 `go help command` 即可查看相关命令。