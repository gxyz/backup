author: me
title: go语言学习-数组-切片-map
date: 2017-07-19 20:42:51
tags:
    - go
    - golang
---


## 数组

go语言中数组的特点:

数组的长度是固定的，并且长度也是数组类型的一部分
是值类型，在赋值或者作为参数传递时，会复制整个数组，而不是指针
定义数组的语法:

```
var arr1 = [5]int{1,2}          // [5]int{1, 2, 0, 0, 0}  未初始化的值，就默认初始化为该类型的默认值

var arr2 = [...]int{1,2,3}      // [3]int{1,2,3}  长度可由初始化的元素个数确定

var arr3 = [5]int{1: 20, 4: 50}  // 可使用索引来初始化，其他值仍然是对应类型的默认值

var arr4 = [2][3]int{{1,2,3}, {2,3,4}}  // 多维数组
```

## 数组常用操作

### 访问数组元素

可以直接使用索引值访问

### 遍历数组

```
var arr = [5]string{"hello", "a", "b", "world", "sss"}

// 这里只接收一个值，那这个值就是索引值
for i := range arr {
    fmt.Println(arr[i]);
}

// 接收两个值，就分别是索引值　和　索引对应的数组值
for i, v := range arr {
    fmt.Println(i, v);
}
```

len 和 cap 方法都可以返回数组长度，即元素数量


## Slice - 切片

slice的底层是数组，它通过内部指针和一些相关属性来引用数组片段，所以slice是可以变长的

slice的结构:

```
struct Slice {
    byte* array;
    uintgo len;
    uintgo cap;
}
```

切片slice的特点:

- 引用类型.本身是结构体
- 属性len表示内部存储的元素数
- cap表示当前切片的容量
- 如果属性slice == nil, 那么len, cap 都应该为0
- 切片可以通过数组来产生，也可以直接创建切片;对切片进行读写，实际上就是操作底层的数组

```
// 通过数组产出切片
var arr = [8]int{2,3,5,7,4,6,9,10}
var s1 = arr[1:5:6]    // 语法 [start: end: max], 此时 len = end - start, cap = max-start

// 直接创建切片
var s2 = []int{2,4,7}  // 注意这里声明的是切片，"[]"没有数字，go会自动分配底层数组

// 使用make动态创建切片
var s3 = make([]int, 6, 8)   // 语法: make([]类型, len, cap); 可以省略cap,此时cap = len

// 通过切片创建新切片, 新切片仍然执行原数组
var s4 = s1[1,2,3]    // 与从数组产生切片是相似的，不过要注意范围
```

### 切片的常用操作

```
func append([]T, t …T) []T
```
从函数的签名就可以看出，作用是向切片的尾部添加元素，可以一次添加多个值,返回新的切片,
⼀旦超出原 slice.cap 限制，就会重新分配底层数组，即便原数组并未填满。

```
s5 := append(s4, 20)
```

```
func copy(dst, src []T) int
```

这个方法将类型为 T 的切片从源地址 src 拷贝到目标地址 dst,覆盖 dst 的相关元素，并且返回拷贝的元素个数。
源地址和目标地址可能会有重叠。拷贝个数是 src 和 dst 的长度最小值。

具体还是得看例子

```
src := []int{1,2,3,4}
dst := []int{2,3,4}
num := copy(dst, src)  // dst=[]int{1,2,3}, num=3

src2 := []int{1,2,3}
dst2 := [2,3,4,5]
num2 := copy(dst2, src2)  // dst2=[]int{1,2,3,5}, num2=3

src3 := []int{1,2,4}
dst3 := []int{1,2,3,5}   
num3 := copy(dst3, src3)   // dst3=[]int{1,2,4,5} num3=3
```

len()和map()方法分别返回切片中的元素数量 和 切片的容量

## map类型

map类型是一种叫哈希表的数据结构，在python中叫字典，还称为关联数组。它是一组无序键值对的集合。给定键可以快速的定位对应的值

特点:

- 引用类型
- 键必须是支持相等比较(== !=)的类型,例如: number,string,array,struct等等
- 值可以是任何类型
- 它可以动态伸缩，不存在限制

定义语法:

```
map[keyType]valueType{
    key1: value1,
    key2: value2,
    ...    
}

// eg:
m := map[string]int{
    "age": 10,
    "month": 12,
    "day": 7,
    "num": 1,    // 这里最后一行必须加上逗号，要不然，就把 "}"放在这个一行
}
```

还可以使用 make 函数来定义一个map,有助于提升性能。因为事先申请⼀⼤块内存，可避免后续操作时频繁扩张。

语法:

```
// 这里的 length 是map的初始容量,可以不加，不过在添加元素时会平凡扩张，影响性能
make(map[keyType][valueType][, length])
```

## map类型的基本操作

### 访问map中的值

可以使用 map[key] 直接访问对应的值

eg:

```
var m = map[int]string{
    1: "hello",
    2: "world",
    5: "你好",
}

// 迭代map
for k := range m {
    fmt.Println(m[k]);
} 

// 还可以直接获得键和值
for k, v := range m {
    fmt.Println(k, v)
}
```

### 测试键是否存在

我们很多时候都会使用到

```
// 这里使用了初始化，如果key存在, ok就是true,　_接收的第一的参数就是值
// 如果key不存在,ok就是false
if _, ok := m[key]; ok {
    //...
}
```

### 删除指定键值对

删除键前，还可以先判断键是否存在，如果键不存在会报错

```
var m = map[int]string{
    1: "hello",
    2: "world",
    5: "你好",
}
delete(m, 1)  // 删除键为1的键值对

```
