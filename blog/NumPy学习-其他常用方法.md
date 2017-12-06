author: me
title: NumPy学习-其他常用方法
date: 2017-09-05 21:17:40
tags:
    - python
    - numpy
---

## Numpy中的随机数函数

Numpy的 random 子库(numpy.random) 可以用于产生随机数数组，以便一些特殊用途。

的函数:

|函数|描述|
|---|---|
|rand(d0,d1,...,dn)|根据d0-dn创建随机数数组，浮点数，[0,1), 均匀分布|
|randn(d0, d1,..., dn)|根据d0-dn创建随机数数组，标准正态分布|
|randint(low [,high , shape])|根据shape创建随机整数或整数数组，范围是[low, high)|
|seed(s)|随机数种子，s是给定的种子值|

使用相同的随机数种子，会产生相同的结果。

### 一些高级的函数

|函数|说明|
|---|---|
|shuffle(a)|根据数组a的第一轴进行随机排列，改变数组a|
|permutation(a)|根据数组a的第一轴产生一个新的乱序数组，不改变数组a|
|choice(a [,size, replace, p])|从一维数组a中按照概率p来抽取元素，形成一个size形状新数组replace表示是否可以重用元素，默认为False|

### 具有分布特征的随机函数

|函数|说明|
|---|---|
|uniform(low, high, size)|产生具有均匀分布的数组,low为起始值，high为结束值，size为形状|
|normal(loc, scale, size)|产生具有正态分布的数组,loc均值，scale标准差，size为形状|
|poisson(lam, size)|产生具有泊松分布的数组,lam随机事件发生概率，size为形状|

## numpy中的统计函数

Numpy直接提供的统计类函数

|函数|说明|
|---|---|
|np.sum(a, axis=None)|根据给定轴axis计算数组a相关元素之和，axis是整数或者元组|
|np.mean(a, axis=None)|根据给定轴axis计算数组a相关元素的期望，axis是整数或者元组|
|np.average(a, axis=None, weights=None)|根据给定轴axis计算数组a相关元素的加权平均值，axis是整数或者元组|
|np.std(a, axis=None)|根据给定轴axis计算数组a相关元素的标准差，axis是整数或者元组|
|np.var(a, axis=None)|根据给定轴axis计算数组a相关元素的方差，axis是整数或者元组|


axis 为 None, 表示对数组中所有元素进行计算，　axis为0表示的是第一维。

|函数|说明|
|---|---|
|min(a) max(a)|计算a中最小值和最大值|
|argmin(a) argmax(a)|计算a中元素最小值，最大值的降一维后下标|
|unravel_index(index, shape)|根据shape将一维下标index，转换成多维下标|
|ptp(a)|计算数组a中元素最大值与最小值的差|
|median(a)|计算数组a中元素的中位数(中值)|

|函数|说明|
|---|---|
|gradient(f)|计算数组f中元素的梯度，当f为多维时，返回每个维度梯度|
