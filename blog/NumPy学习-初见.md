author: me
title: NumPy学习-初见
date: 2017-07-01 00:26:36
tags:
    - python
    - numpy
---


NumPy 是 Python 中科学计算的基础包，很多其他的科学计算库都是构建在这个库之上，在 [Numpy 官网](http://www.numpy.org/)上的描述是:

- 包含一个强大的n维数组对象
- 成熟精致的(broadcasting)函数库
- 用于集成 C/C++ 和 Fortran 代码的工具
- 非常有用的线性代数，傅里叶变换和随机数生成能力

除了在科学计算中的用途，NumPy也可以用作通用数据的高效多维容器。可以定义任意数据类型。 这使NumPy能够无缝地，快速地与各种数据库集成。

## 安装

可以直接使用 pip 安装

```
pip install numpy
```

## 基本使用

Numpy包中一个很重要的对象就是ndarray对象。它就是我们前面所说的一个强大的n为数组对象，它是一个同质数组(其中的元素都是同一种类型)。


一个小例子:

```
import numpy as np

arr = np.array([[1,2,3], [4,5,6]])
print(arr)
```

打印出:

```
[[1 2 3]
 [4 5 6]]
```

由上面例子展示了 numpy 使用时的几个特点:

- 通常使用 np 作为 numpy 的别名
- ndarray 对象可以使用 np.array 来创建

下面介绍几个ndarray对象的属性，来就说明 ndarray对象的特点:

- ndim: 表示秩，即数组轴的数量或者说是维度
- shape: 数组对象的尺寸，例如对于二维数组，尺寸可以表示为n行m列
- size: 数组对象元素的个数，相当于 .shape 中 n*m 的值
- dtype: 数组中元素的类型
- itemsize: 数组中每个元素的大小，以字节为单位
- data: 包含数组的实际元素,很少使用

实例:

```python
import numpy as np

arr = np.array([[1,2,3], [4,5,6]])
print(arr.ndim)    # 2, 表示ndarray对象是一个二维数组
print(arr.shape)   # (3, 2), 表示每个维度对应的元素数目，即数组的尺寸
print(arr.size)    # 6, 3*2, 数组中元素的总个数
print(arr.dtype)   # 数组中元素的类型
print(arr.itemsize)  # 数组中元素的大小，以字节为单位
print(arr.data)     
```

输出:

```
2    
(2, 3)
6
int64
8
<memory at 0x7f4724a7a990>
```

## 数组的创建

前面我们学习了一种使用 np.array() 创建 ndarray数组的方式，它的完整形式如下:

```
np.array(list/tuple, dtype=np.float32)
```

- 第一个参数可以是嵌套的列表或者元组
- 第二个参数用来指定数组中的元素类型

关于数据类型的更多信息可以到[这里](https://docs.scipy.org/doc/numpy-dev/user/basics.types.html)查看

除了上面的创建方式，实际上 numpy 还提供了很多方便的函数用来快速生成数组:

|函数|说明|
|---|---|
|arange(n)|类似range()函数，返回ndarray类型，元素从0到n-1|
|ones(shape)|根据shape生成一个全1数组，shape是元组类型|
|zeros(shape)|根据shape生成一个全0数组，shape是元组类型|
|full(shape, val)|根据shape生成一个数组，每个元素值都是val|
|eye(n)|创建一个正方的n*n单位矩阵，对角线为1,其余为0|
|ones_like(a)|根据数组a的形状生成一个全1数组|
|zeros_like(a)|根据数组a的形状生成一个全0数组|
|full_like(a)|根据数组a的形状生成一个数组, 每个元素的值都是val|


这些函数使用起来都很简单，并且它们都支持一个参数就是 dtype 用来设置数据类型，下面是一个简单的例子:

```
>>> import numpy as np
>>> np.arange(10)
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
>>> np.ones((3, 4))
array([[ 1.,  1.,  1.,  1.],
       [ 1.,  1.,  1.,  1.],
       [ 1.,  1.,  1.,  1.]])
>>> np.zeros((3, 4))
array([[ 0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.]])
>>> a = np.array([[1, 2, 3], [4, 5, 6]])
>>> np.ones_like(a)
array([[1, 1, 1],
       [1, 1, 1]])
```

其他的函数用法都是类似的。

## 总结

ndarray 函数是 numpy 中最核心的部分之一，很多操作都是基于数组的，本文主要讨论了 numpy 库的特点，以及 ndarray 对象的产生，后续将介绍 ndarray 对象的相关操作.
