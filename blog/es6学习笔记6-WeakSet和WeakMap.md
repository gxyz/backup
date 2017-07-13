---
title: es6学习笔记(6)-WeakSet和WeakMap
date: 2017-05-04 10:06:36
tags:
    - JavaScript
    - ES2015
---


上一节学习了 ES6 新增的 Set 和 Map 类型，这一节就来介绍一下与 Set 和 Map 相关的另外两种类型：WeakSet 和 WeakMap。

## WeakSet

一听名字就知道，它们之间肯定有些什么关系，就拿 Set 和 WeakSet 举例, Weak 就是弱的意思，在这里其实表示的是弱引用。

Set 和 WeakSet 都是用来存储不重复的数据的，并且也都是无序的，它们的区别就在于 WeakSet 的成员只能是对象，而不能是其他类型的值。

它还有一个很重要的特点就是，WeakSet 中的对象是弱引用的，指的是 垃圾回收机制不会考虑 WeakSet 对某个对象的引用，即如果该对象没有被其他变量或者对象引用，那么它就可以直接为垃圾回收机制清除。

定义语法:

```
const arr = [{"name": "es6"}, {"age": 2}]
const weakset1 = new WeakSet();   // 定义一个空 WeakSet
const weakset2 = new WeakSet(arr);   // 可以使用一个数组作为参数初始化
```

这里需要注意， WeakSet()的参数可以是任何可迭代类型，另外它其中的元素也是有要求的，以上面的例子为例，WeakSet会使用 arr的成员作为自己的成员，因此 arr 的成员必须全部是对象。


### WeakSet 常用方法

|方法|描述|
|:---:|---|
|add(value)|向 WeakSet中添加新元素|
|delete(value)|删除WeakSet中的指定元素,删除成功返回true|
|has(value)|判断某个值是否在 WeakSet中|


```javascript
const ws = new WeakSet();
const p1 = {"name": "p1"}
const p2 = {"name": "p2"}

ws.add(p1);
ws.add(p2);

ws.has(p1);   // true
ws.has(p2);   // true

ws.delete(p2)   // 删除成功返回true
ws.has(p2)     // true
```

另外很重要的一点是，我们无法确定 WeakSet 的长度，因此无法来遍历它。只能使用 has 方法判断它是否包含某个元素，可以通过它来查看某个元素的引用情况。 

## WeakMap

首先说一说它与Map的异同点.相同点：都是用于存储键值对的；不同点： WeakMap的键必须是对象,除null之外。另外一点与 WeakSet的特点类似，即WeakSet中键名指向的对象，垃圾回收机制也不会它的引用

定义语法:

```javascript
// 定义一个空的 WeakMap
const  wm = new WeakMap()

// 声明一个对象
const p1 = {"name": "p1"}
// 使用一个对象作为键，值可以是其他类型
wm.set(p1, "nihao")
wm.has(p1);    // true
wm.get(p1);    // "nihao" 
```

这里需要注意，键必须值对象类型，但是值可以是其他类型。下面说一说上面用到的几个方法。


### WeakMap常用方法

WeakMap与 WeakSet一样无法知道内部数据的数量，因此也无法遍历，因此Map的 keys(), values(), entries(), size 等方法或属性都不能使用，只有以下几个方法可以使用

|方法|描述|
|:---:|---|
|get(key)|用来获取某个键对应的值|
|set(key, value)|用来设置某个键的值，或者添加新键值对|
|has(key)|判断是否包含某个键|
|delete(key)|删除某个键对应的键值对|

这些方法都很简单，这里就不说了。

## 总结

通过对比这两种类型与Map和Set的异同点，了解了WeakSet和WeakMap的特点，其中最需要注意的特点就是:

1. WeakSet的值必须是对象，WeakMap的键必须是对象
2. 垃圾回收不会考虑 WeakSet的值和WeakMap的键对对象的引用，一旦该对象没有其他引用，它将自动从WeakSet 和 WeakMap中删除。
