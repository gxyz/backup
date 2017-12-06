author: me
title: es6学习笔记(5)-set和map
date: 2017-05-03 10:28:26
tags:
    - JavaScript
    - ES2015
---

在 es6 中，新增加了几种数据类型，这一节主要学习一下 Set 和 Map。 Array、Set 和 Map都 属于集合类的数据类型，这里指存放一系列元素的集合。其中: 

- Array(数组)是一系列元素的有序集合，其中元素可重复，可以使用索引来访问
- Set(集合)是一系列元素的无序集合，其中元素不可以重复，无序因此就不能使用索引来访问了
- Map(映射)是一系列键值对的集合，其中键是唯一的，并且是无序的

下面就来详细的介绍一下 Set 和 Map

## Set

Set - 无序集合，主要的特点就是其中的元素是无序的，而由于是无序的所以不能使用索引来访问，另外 Set 中的元素不能重复。定义的语法如下:

```javascript
new Set([iterable])
```

这里的参数可以是一个可迭代的数据，例如数组；也可以是空的,例如

```javascript
let s1 = new Set();   // 此时声明的就是一个空集合
let s2 = new Set([1, 2, 3, 4])  // 使用数组为参数，声明一个Set
```

### Set 常用方法和属性

其实 Set 的方法，无非就是给 Set 添加元素、删除元素、遍历元素等等，下面看看几个常用的方法

|方法|描述|
|---|---|
|add(value)|向Set添加元素|
|delete(value)|从Set删除指定的元素|
|clear()|清空Set|
|has(value)|检测Set中是否有指定元素|
|forEach(cb[, context])|遍历的方法|


由于 Set 的特性，使得 Set 比 Array 简单很多，因为是无序集合，因此按索引进行的操作就没有任何意义了，并且其中每个元素都是唯一的，所有删除其实也很方便。我们来试试上面的方法:

```javascript
// 定义一个空 Set
let s = new Set();

// 添加三个元素
s.add(1);
s.add(2);
s.add(3);

// 添加一个Set中已经存在的元素
s.add(3);

// 打印
console.log(s)  // Set(3) {1, 2, 3}

// 遍历集合中的元素
s.forEach(function(item) {
    console.log(item)
})
```

其他的方法都很简单，注意说一下， forEach 这个函数，它的第一个参数是一个回调函数，参数为集合中的每一项，另外还有第二个可选参数，是一个上下文对象，就类似于之前使用函数时，使用的 bind() 方法的参数。

另外 Set 有一个 size 属性，用来获取 Set 中元素的数量。

## Map

Map - 映射，其实它有很多的名字，在不同语言中叫法不同，例如字典、哈希、关键数组等等。是一系列键值对的集合。有点像JavaScript对象中一个属性对应一个值。那么Map和对象有什么区别呢?

主要有几个区别:

1. Map 支持使用任何对象作为键，而对象的所有键名都是字符串，所以加不加引号(不符合标识名的条件下，必须加引号)都可以，既是不是字符串也会被转换为字符串，否则会报错
2. Map有可以方便获取内部元素的方法，而Object没有
3. 另外可能就是实现和使用层面的不同了

定义 Map 的语法:

```
new Map([iterable])
```

例如：

```javascript
const map = new Map([["k1", "v1"], ["k2", "v2"]])
```

由于Map中的键名是唯一的，因此如果存入多个同名的键，后面的值会覆盖前面的值

### Map常用操作

常用的方法：

|方法|描述|
|---|---|
|set(key,value)|添加指定的键值对到Map中，如果键存在就覆盖之前的|
|get(key)|获取Map中指定键的值|
|has(key)|判断Map中是否包含某个键|
|delete(key)|移除Map中指定键对应的键值对，删除成功返回true|
|clear()|清空Map|
|entries()|返回一个包含Map中所有键值对的MapIterator对象|
|keys()|返回一个包含Map中所有键的MapIterator对象|
|values()|返回一个包含Map中所有值的MapIterator对象|


另外 Map 也有一个属性 size，表示Map中键值对的数量

例子:

```javascript
const map = new Map([["k1", "v1"], ["k2", "v2"], ["k3", "v3"]])
console.log(map.size)   // 3

map.set("k4", "v4")   
console.log(map.size)   // 4
map.set("k3", "v5");  
console.log(map.size)   // 4, 因为 k3 已经存在了

console.log(map.get("k3"))  // "v5"
console.log(map.entries())  // MapIterator { [ 'k1', 'v1' ], [ 'k2', 'v2' ], [ 'k3', 'v5' ], [ 'k4', 'v4' ] }
console.log(map.keys())     // MapIterator {"k1", "k2", "k4", "k3"}
console.log(map.values())   // MapIterator {"v1", "v2", "v4", "v5"}

map.clear()
console.log(map.size)  // 0
```

上面这些代码可以直接在 chrome 开发者工具中的 Console 中执行

需要注意的是这里 entries, keys，values 方法返回的都是 MapIterator 对象，这是一个可迭代对象。这个对象有一个 next 方法可以用于获取下一组元素，因此我们可以使用它实现对map中元素的遍历:

例如:

```javascript
const map = new Map([["k1", "v1"], ["k2", "v2"], ["k3", "v3"]])
let e = map.entries()
e.next()   // { value: [ 'k1', 'v1' ], done: false }
e.next()   // { value: [ 'k2', 'v2' ], done: false }
e.next()   // { value: [ 'k3', 'v3' ], done: false }
e.next()   // { value: undefined, done: true }
```

可以看到每次对 MapIterator 对象调用 next 方法时，会返回一个对象，包含两个属性，分别为: value(当前迭代的值) 和 done(是否已经迭代完成)，由上面的例子可以很容易理解。

这种对象都可以使用 for...of 来进行遍历，这是 ES2015 中新增的循环语句，可以对所有的可迭代对象进行遍历，这些以后再写。因此我们可以使用 for...of 来遍历 Map

```javascript
const map = new Map([["k1", "v1"], ["k2", "v2"], ["k3", "v3"]])

for (let entry of map) {
    console.log(entry)
}
/*
[ 'k1', 'v1' ]
[ 'k2', 'v2' ]
[ 'k3', 'v3' ]
undefined
*/

let e = map.entries()
for (let entry of e) {
    console.log(entry)
} 
/*
[ 'k1', 'v1' ]
[ 'k2', 'v2' ]
[ 'k3', 'v3' ]
undefined
*/

let keys = map.keys()
for (let key of keys) {
    console.log(key)
} 

/*
k1
k2
k3
undefined
*/
```



