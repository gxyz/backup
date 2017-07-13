---
title: JavaScript中与数字类型相关的内置函数
date: 2017-03-27 17:50:27
tags: JavaScript
---

## parseInt()

用于将接收的参数值转换为整数，如果转换失败就返回 NaN

> NaN也是一个 number类型的值，表示 Not A Number

例子:

```
> parseInt(1.1)
1
> parseInt(1.6)
1
> parseInt("123hello")
123
> parseInt("hello123")
NaN
> parseInt(false)
NaN
> parseInt(true)
NaN
```

这里需要注意的几点是:

1. 参数为浮点数时，直接去掉小数位，而不是四舍五入
2. 参数为字符串时，只有以数字开头，才可以转换成功，并且结果是，从开头开始连续的数字(遇到字母就停止)
3. 参数为布尔值时，会转换失败，返回 NaN

另外这个函数还有第二个参数，表示第一个参数的基数，在转换时，会将第一个参数按照这个进制, 来将其转换为十进制

例如:

```
> parseInt('FF', 16)
255
> parseInt('1111', 2)
15
```

## parseFloat()

与 parseInt()的功能基本相同，不过这个函数只有一个参数，只支持转换为十进制。

例子:

```
> parseFloat('123')
123
> parseFloat('1.23')
1.23
> parseFloat('1.23abc')
1.23
```

另外还可以接受指数形式的数据，可以正常转换

```
> parseFloat('123e-2')
1.23
```

除此之外，还可以使用强制转换来将其他的数据类型转换为数字类型

```
> Number("123")
123
> Number("123abc")
NaN
> Number(true)
1
> Number(false)
0 
```

可以看到与 parseFloat 还是有很大的不同的，首先只有字符串包含的只有数字才能够转换，否则为NaN; 其次布尔值true转换为整数是1, false 为0

## isNaN()

我们可以确定某个输入值是否是一个可以参与算数运算的数字; 前面已经说过  NaN也是一个 number类型的值，表示 Not A Number, 它有一些特殊的性质:

- NaN 与任何数据都不会相等，甚至于自己都不想等
- NaN 与其他数字类型进行算数运算的结果都是NaN

由于它与自己都不相等，因此JavaScript就提供了 isNaN 这个方法，来判断是个数据是不是 NaN

```
> isNaN(NaN)
true
> isNaN(1.23)
false
> isNaN('1.23')
false
> isNaN('abc')
true
```

## isFinite()

isFinite()可以用来检查输入是否是一个既非 Infinity 也非 NaN 的数字， Finite 是“有限”的意思，即用来检测一个数字是否是一个有限的数字, 并且不能是 NaN

这里又要说说 Infinity, Infinity 也是一个 number 类型的值, 是无穷大的意思，表示超出了 JavaScript 处理范围的数值。例如： 一个数除以0 得到的结果就是无穷大， 对应的 -Infinity 就是指负无穷大

```
> 10 / 0
Infinity
> -10 / 0
-Infinity
```

性质:

- Infinity 与其他任何操作数执行任何算术运算的结果也都等于 Infinity(除了Infinity*0=NaN)
- Infinity - Infinity = NaN
- Infinity / Infinity = NaN


```
> Infinity * 0
NaN
> Infinity / 0
Infinity
> Infinity - Infinity
NaN
> Infinity / 20
Infinity
```

所以 isFinite() 的使用如下:

```
> isFinite(NaN)
false
> isFinite(Infinity)
false
> isFinite(10)
true
> isFinite('1.2')
true
```