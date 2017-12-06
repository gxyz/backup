author: me
title: python调试工具pdb
date: 2017-09-03 15:18:15
tags:
    - python
---

pdb 是一个类似与 gdb 的工具，可以方便的在命令行中调试 Python 程序，因此在使用Linux时，用pdb来调试Python程序是非常方便的。

## pdb常用命令介绍

通常使用 pdb 我们会进入一个 pdb 的调试环境，在这个环境中有一些命令可以帮助我们调试程序，常用的命令如下:

|命令|简写|作用|
|---|---|---|
|break|b|设置/查看断点(如果加行号，表示设置断点，不加行号，表示显示全部断点)|
|continue|c|继续执行程序|
|list|l|查看当前行的代码段|
|step|s|进入函数|
|return|r|指向代码直到当前函数返回|
|quit|q|终止并退出|
|next|n|执行下一行|
|print|p|打印变量的值|
|clear|cl|清除断点，参数是断点的编号，而不是断点的行号|
|arguments|a|打印函数的所有形参数据|

## pdb的使用方式

想进入交互式的 pdb 调试环境用下面这几种方式

1. 使用-m指定pdb

    ```
    python -m pdb script.py
    ```

    -m 指定的模块，即使用 pdb模块来运行我们的脚步文件。


2. 交互调试

    进入python或ipython解释器

    ```
    >>> import pdb
    >>> pdb.run('testfun(args)')  # 此时会打开pdb调试，注意：先使用s跳转到这个testfun 函数中，然后就可以使用
    ```

3. 程序里埋点

    在程序文件中导入 pdb, 在需要调试的地方加入 pdb.set_trace(), 程序执行到这个位置会停止并进入pdb调试模式


更多内容可以查看[pdb官方文档](https://docs.python.org/3/library/pdb.html#module-pdb)
