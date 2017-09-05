---
title: NumPy学习-数据存取
date: 2017-09-05 21:04:59
tags:
    - python
    - numpy
---

numpy 可以方便的操作数据，自然也少不了存取数据的方法。

## 数据的CSV文件存取

CSV(Comma-Separated Value, 逗号分割值文件), CSV是一种常见的文件格式，用来存储批量数据。

1. 存储

    将数据存储到CSV文件的方法是: `np.savetxt(frame, array, fmt='%.18e', delimiter=None)`

    - frame: 文件、字符串或生成器，可以是 .gz 或 .bz2 的压缩文件(存储的目标文件)
    - array: 存入文件的数组
    - fmt: 写入文件的格式，例如 %d  %.2f  %.18e
    - delimiter: 分割字符串，默认是任何空格

    例子:

    ```
    a = np.arange(100).reshape(5, 20)
    np.savetxt('a.csv', a, fmt="%d", delimiter=',')
    ```

    a.csv的内容:

    ```
    0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
    20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39
    40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59
    60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79
    80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99
    ```

2. 载入

    从CSV文件中载入数据: `np.loadtxt(frame, dtype=np.float, delimiter=None, unpack=False)`

    - frame: 文件、字符串或生成器，可以是 .gz 或 .bz2 的压缩文件(读入的文件来源)
    - dtype: 将载入数据当做指定类型来读取
    - delimiter: 分割字符串，默认是任何空格
    - unpack: 如果为True, 读入属性将分别写入不同变量。

    CSV只能有效的存储一维和二维数组

## 多维数据的存取

而对于多维数组同样有相应的方法来进行存取操作:

1. 存储

    numpy中的数组对象有一个 `tofile(frame, sep='', format='%s')` 方法

    - frame: 文件、字符串
    - sep: 数据分割的字符串，如果是空字符串，写入文件为二进制
    - format: 写入数据的格式

    这种方式输出的文件并不会包含数组中的维度信息，只会将数组中的每一项输出到文件中。

2. 读取

    numpy有一个对应的方法来读取上述方法存储的数据：

    ```
    np.fromfile(fname, dtype=np.float, count=-1, sep='')
    ```

    - fname: 文件、字符串
    - dtype: 读取元素之后使用的数据类型
    - count: 读取元素的个数，-1表示读入整个文件
    - sep: 读取时使用的分隔符，如果空串，就按照二进制方式来读入

    ```python
    import numpy as np

    a = np.arange(100).reshape(5, 10, 2)
    a.tofile('b.dat', sep=",", format="%d")  # 0,1,2,3,4,5, .......(文件中不包含维度信息)
    c = np.fromfile('b.dat', dtype=np.int, sep=',')    # c是数组类型，但是就是一个简单的一维数组，包含所有数据，如果需要还原原数组，还需要使用　reshape　或者 resize, 来改变维度。
    ```

    > 使用这种方式，需要事先知道存入文件时数据的维度，和数据的类型。

    可以通过元数据文件来存储相关信息。


## Numpy的便捷文件存取

np.save(fname, array)  -  正常文件 　
np.savez(fname, array)   -  压缩文件

- fname: 文件名，以 .npy 为扩展名，压缩扩展名为 .npz
- array: 数组变量

np.load(fname)  - 读取

这种方式会记录原数组的元信息，包含数组的维度，数据类型等等，因此在 load 时，就不需要指定维度和类型了。


