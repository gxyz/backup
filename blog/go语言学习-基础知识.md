---
title: go语言学习-基础知识
date: 2017-07-18 19:51:59
tags:
    - go
    - golang
---


## go程序的基本结构

一个可以最简单的可运行的go程序需要满足下面两个条件:

- 有一个main()函数
- main()函数在main包中

例如: 在go语言中的 hello world 程序如下:

```go
// main.go
package main

func main() {
    println("hello world");
}
```

程序中的 `package` 关键字，用来声明文件所属的包(文件所属的包跟文件名是没有关系的)，每一个go文件都需要有一个包声明； 而 func 关键字用来定义函数, 这里我们定义了一个main函数(main函数的形式是固定的)。println 函数是用来向标准输出打印数据的，不过我们一般情况下是不使用它的。

go在编译程序时，会自动在语句的结尾加上分号，所有这里函数的第一的大括号，必须与()在同一行，否则返回就会加在()之后，就会出现错误，后面的一些流程控制语句也是如此

运行程序:

```
go build main.go  // 编译程序
./main         // 运行程序

```

我们可以将两步合成一步:

```
go run main.go    // 不会生成中间文件
```

在运行go程序时的入口就是 main 包下的 main 函数。

## 变量

go语言使用 var 声明或者定义变量，它可以用在函数之外定义，此时就是全局变量；而在函数内声明时，就是局部变量。

还有一种简略的定义方式，使用 := 来定义，这种方式只能用在函数中，即定义局部变量

且局部变量声明之后必须使用

```
package main

import "fmt"

var age int = 10   // 显式的声明变量的类型 int
var name = "Tom"    // go也可以自动推断处变量类型,这里是 string

func main() {
    var sex = "man"

    hello := "hello"   // 简略声明方式

    fmt.Println(sex)
    fmt.Println(hello + "world")
}
```

这里我们定义了两个全局变量 name 和 age, 还定义了两个局部变量 sex 和 hello, 在 go 语言中，全局变量可以声明之后不是有，但是局部变量一旦声明必须使用，否则编译器会报错;

> 注意: 这里我们使用 import 关键字引入了一个 fmt 的包，在go程序中我们一般都应该使用 fmt 包中的函数来打印数据，而不是前面的println

基本数据类型:

|类型	|含义|	默认值|
|---|---|---|
|bool|	布尔值	|false|
|byte|	字节,uint8	|0|
|rune|	Unicode码点,int32|	0|
|int,uint|	与系统相关的有/无符号整数|	0|
|int8,uint8	|8位有/无符号整数|	0|
|int16,uint16|	16位有/无符号整数|	0|
|int32,uint32|	32位有/无符号整数|	0|
|int64,uint64|	64位有/无符号整数|	0|
|float32|	32位浮点数	|0.0|
|float64|	64位浮点数	|0.0|
|complex64|	64位复数	|0+0i|
|complex128	|128位复数	|0+0i|
|string|	字符串|	“”|

这些是比较基本的类型，还有一些类型，后面用到了再说

## 常量

常量的定义方式与变量类型，不过使用的是 `const` 关键字:

```go
const PI float32 = 3.14159   
const USERNAME = "root"    // 自动类型推断
```

常量必须在定义时，就初始化，并且一经定义便不可更改。

## 流程控制语句

### if语句

```go
package main

import "fmt"

func main() {
    a := 10
    if a > 5 {
        fmt.Println("a 大于 5")
    } else {
        fmt.Println("a 小于 5")
    }
}
```

同样的这里的 左大括号“{”必须与 if 或者 else 在同一行, 且这里 else 必须与 if 的右大括号“}”在同一行。

go语言中没有三元运算符

### switch语句

```go
switch (n){

    case 1:
        fmt.Println("n == 1")
    case 2:
        fmt.Println("n == 2")
    default:
        fmt.Println("n is default")
}

```
go中的 switch 是不需要 break 语句的,默认自动终止一个case; 如果需要继续执行下一个，使用fallthrough，此时不会判断条件

这里switch语句还可以包含初始化语句，使用分号”;”分隔,且case的条件，不仅仅可以是常量值，还可以是比较表达式;

### for循环

go语言支持三种循环方式:

```go
// 1. 常见的for循环,类似于C语言的循环，不过条件可以不用括号
for i := 0; i < 10; i++ {
    fmt.Println(i);
}

// 2. 类while语法
i := 10
for i > 0 {
    fmt.Println(i)
    i--
}

// 同样的,无限循环是这样,省略条件
for {
    //...
}

// 3. for .. range,可以用来循环字符串，数组，map,channel等等
// range返回 (索引值, 值)或者(键, 值); 如果只有一个接收参数，则会忽略第二个返回值
s := "hello"

for i := range s {   // 这里循环的是string的索引
    fmt.Println(s[i])  
}

```

### 标签，goto, break, continue


go还支持标签(区分大小写)，可以使用goto跳转到标签，break 可⽤于 for、 switch、 select，⽽ continue 仅能⽤于 for 循环。
