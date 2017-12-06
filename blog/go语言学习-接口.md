author: me
title: go语言学习-接口
date: 2017-07-22 09:35:47
tags:
    - go
    - golang
---


Go语言中虽然没有传统面向对象语言中类、集成的概念，不过提供了接口的支持，可以使用接口来使用一些面向对象的特性。

在 go 语言中，的接口有下面几个特点:

- 可以包含0个或多个方法的签名
- 只定义方法的签名，不包含实现
- 实现接口不需要显式的声明，只需实现相应方法即可

## 接口的定义

定义方式如下:

```go
type Namer interface {
    method1(param_list) return_list
    method2(param_list) return_list
    ...
}
```

这里的 Namer 就是接口的名字，只要符合标识符的规则即可。不过，通常约定的接口的名字最好以 er,　r, able 结尾(视情况而定)，这样一眼就知道它是接口。

## 实现接口

在 go 中实现接口很简单，不需要显式的声明实现了某个接口，想要实现某个接口，只需要实现接口中的所有方法即可。

```go
package main

import "fmt"
import "math"

type Shaper interface {
    Area() float32
    Circumference() float32
}

type Rect struct {
    Width float32
    Height float32
}

type Circle struct {
    Radius float32
}

func (r Rect) Area() int {
    return r.Width * r.Height
}

func (r Rect) Circumference() int {
    return 2 * (r.Width + r.Height)
}

func (c Circle) Area() int {
    return math.Pi * c.Radius * c.Radius
}

func (c Circle) Circumference() int {
    return math.Pi * 2 * c.Radius
}

func main() {
    r := Rect{10, 20}
    fmt.Printf("Rect w: %f, d: %f, Area: %f, Circumference: %f", r.Width, r.Height, r.Area(), r.Circumference())

    c := Circle{5}
    fmt.Printf("Circle r: %f, Area: %f, Circumference: %f", c.Radius, c.Area(), c.Circumference())    
}
```

上面我们定义了一个 Shaper 的接口，其中包含两个方法 Area 和　Circumference，分别用来计算面积和周长。然后我们定义了两个结构体 Rect, Circle 并分别实现了这两个方法。但是上面的程序似乎并没有体现出接口和两个实现类型的关系，下面我们将他们关联起来使用:

```
func showInfo(s Shaper) {
    fmt.Printf("Area: %f, Circumference: %f", s.Area(), s.Circumference())
}
```

注意，这里方法的参数是一个接口类型的，因此我们可以将实现接口的类型的实例传递进去，像下面这样:

```
r := Rect{10, 20}
showInfo(r)

c := Circle{5}
showInfo(c)
```

## 获取实现接口的实际类型

在上面的 showInfo 中我们传入了接口类型的对象，如果将实现了接口的类型传递进去，那么会将实际类型的其他特性掩盖住，因此通常我们会想要获取其真正的类型, 可以使用下面的方法:

```go
func showInfo(s Shaper) {
    switch s.(type) {
    case Rect:
        fmt.Println("This is Rect")
    case Circle:
        fmt.Println("This is Circle")        
    }
    fmt.Printf("Area: %f, Circumference: %f\n", s.Area(), s.Circumference())
}
```


另外可以使用类型断言，来判断某一时刻接口是否是某个具体类型

```
v, ok := s.(Rect)   // s 是一个接口类型
```

如果 s 此时实际上是 Rect 类型，那么会将 s 转换为 Rect 类型，并且 ok 为 true。否则 ok 为 false。

## 标准库中的常用接口

### io.Reader 和 io.Writer

这两个接口定义了实现io功能的基本操作，因此某种类型只要实现了这两个接口就可以进行io操作。

Reader 接口的定义为:

```go
type Reader interface {
    Read(p []byte) (n int, err error)
}
```

仅仅只有这一个方法，Read方法将从数据流中读取 len(p) 个字节的数据到字节数组 p　中，并且返回读取的字节数(即使发生了错误，n也会返回已经读取的字节数)。

我们可能会经常用到的实现了 Reader 接口的对象有: os.Stdin(标准输入), os.File的实例(文件对象)等等，　我们可以对其调用 Read 方法来读取数据。

Writer 接口的定义:

```go
type Writer interface {
    Write(p []byte) (n int, err error) 
}
```

Write 将 len(p) 个字节的数据从 p 中写入到基本数据流中。写入的字节数 n（0 <= n <= len(p)）以及任何遇到的引起写入提前停止的错误。

类似的实现了 Writer 接口的对象有: os.Stdout, os.Stderr, os.File 等等。可以使用 Write 方法向其中写入数据。

标准库中定义了很多的接口，这里只是简单的提一下，更多内容还是要去查看标准库的文档。