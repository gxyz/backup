---
title: Elixir学习之安装与基本使用
date: 2016-12-11 21:04:50
tags: Elixir
---

Elixir是一种基于Erlang VM的一门函数式编程语言，有这Erlang的并发性，稳定性等特点，又有这类似Ruby的语法。值得学一学

## 安装Elixir

很简单，安装[官网](http://elixir-lang.org/install.html)一步一步的来就可以了

这里只说一下在Ubuntu上面安装:

1. 添加Erlang仓库(因为Elixir运行在Erlang虚拟机上面，所以我们要先安装Erlang)

    ```
    wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
    ```

2. 安装Erlang

    ```
    sudo apt-get update
    sudo apt-get install esl-erlang
    ```

3. 安装Elixir

    ```
    sudo apt-get install esl-erlang
    ```

## 简单使用

首先我们来使用一下`iex` --- 一个交互式的Elixir会话，在里面可以交互的输入命令，然后她将返回结果

只需在终端输入: `iex` 就可以进入,如下图:

![iex界面](http://7xo1su.com1.z0.glb.clouddn.com/iex.png)

基本上输出与上图相同，只是版本号可能不同

下面简单介绍一下iex的基本功能:

1. 输入`h`, 然后回车会显示帮助信息
2. 使用`h 模块名`，显示模块的帮助信息
3. 支持一些常用的shell命令，例如: ls, pwd, clear, cd 等等
4. 使用`Tab`键可以自动补全，就像在shell中
5. 退出iex的方法: 按两次Ctrl+C退出 或者　按Ctrl+G,然后按q退出

iex的用处很多，后面用到再说

## Elixir源文件

iex中只能逐行的写命令，并且不能保存。所有我们会使用文件来保存Elixir程序，Elixir程序的源文件通常用两种后缀名: `.ex`和`.exs`。一般以`.ex`文件结尾的文件将编译成字节码来运行，而`.exs`结尾的文件，可以直接使用`elixir`命令像脚本一样运行。

下面写一个hello world!程序:

```elixir
# hello.exs

IO.puts "Hello World!"
```

可以看到Elixir中`#`是用来注释的，并且只是单行注释，`IO.puts` 是输入函数

要运行这个文件用两种方式:

1. 使用 elixir命令直接运行($代表在终端中输入命令)

    ```
    $ elixir hello.exs
    Hello World!
    ```

2. 使用iex

    ```
    $ iex

    iex> c "hello.exs" 
    Hello World!
    []
    iex>
    ```

上面的`c`是 iex中的辅助函数，用来编译并执行源文件中的代码，`[]`是`c`函数的返回值,是用来返回模块名的(之后再说)



