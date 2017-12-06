author: me
title: python中的几种方法
date: 2017-11-25 10:35:48
tags:
    - python
---

## 静态方法、类方法、实例方法
 
首先来看一个类
 
```python
#coding:utf-8
 
class Fun():
    #实例方法
    def fun(self, x):
        print "executing fun(%s, %s)" % (self, x)
    #类方法
    @classmethod
    def class_fun(cls, x):
        print "executing class_fun(%s, %s)" % (cls, x)
     
    #静态方法
    @staticmethod
    def static_fun(x):
        print "executing static_fun(%s)" % x
 
f = Fun()
 
```
 
- 实例方法：通过self，绑定实例。调用时`f.fun(x)`就相当于`fun(f,x)`
- 类方法：通过cls绑定类
- 静态方法：不依赖类或者实例，就像是在类外定义的函数一样，只不过需要通过类或者实例来调用。
 
如下
 
|        | 实例方法 | 类方法 | 静态方法 |
|--------|--------|--------|--------|
|  f=Fun()  |    f.fun(x)    |   f.class_fun(x)     |   f.statis_fun(x)     |
|   Fun     |    不可用    |    Fun.class_fun(x)    |    Fun.statis_fun(x)    |
