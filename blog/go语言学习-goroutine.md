author: me
title: go语言学习-goroutine
date: 2017-08-19 10:23:47
tags:
    - go
    - golang
---

go 语言有一个很重要的特性就是 goroutine, 我们可以使用 goroutine 结合 channel 来开发并发程序。

> 并发程序指的是可以同时运行多个任务的程序，这里的同时运行并不一定指的是同一时刻执行，在单核CPU的机器下，在同一时刻只可能有一个任务在执行，但是由于CPU的速度很快，在不断的切换着多个任务,让它们交替的执行，因此宏观上看起来就像是同时在运行； 而在多核的机器上，并发程序中的多个任务是可以实现在同一时刻执行多个的，此时并发的多个任务是在并行执行的。

## goroutine

goroutine 是 go 语言中的并发执行单元，我们可以将多个任务分别放在多个 goroutine 中，来实现并发程序。下面先看一个例子:

```go
package main
import "fmt"

func hello() {
	fmt.Println("Hello World!!!")
}
func main() {
	go hello()
	fmt.Println("Bye!!!")

    var input string
    fmt.Scanln(&input)
}
```

上述程序的执行结果如下:

```go
Bye!!!
Hello World!!!
```

上面这个例子展示了使用 goroutine 的几个要点:

1. 程序启动时，我们的主函数 main 也是在一个单独的 goroutine 中运行的。
2. `go hello()` 就是用于创建一个 goroutine, 即 go 关键字加上 要在 goroutine 中执行的函数(也可以是匿名函数，不过必须是调用的形式)
3. 最后两句是用于将 main 函数阻塞在这里,直到我们按下回车键，之所以这么做是因为，我们不知道新创建的 goroutine 和　main goroutine 的执行顺序，有可能主程序先执行完成，此时主程序结束，我们就看不到新 goroutine 的执行效果了。(通常不会使用这种方法)

以上就是 goroutine 的基本用法

## channels

前面我们学习了怎样创建并行的执行单元，但是每个执行单元之间是完全独立的，如果我们想在运行期间交换数据，即进行通信，此时就得依靠另一个概念 - channels, 即通道，这个名字十分贴切，就像在不同的并发执行单元之间连接了一根管道，然后通过这跟管道来发送和接收数据。

goroutine 和 channel 经常结合在一起使用，下面学习一些 channel 的用法：

1. 创建 channel
    
    ```go
    ch1 := make(chan int)
    ```
    channel 也需要使用 make 函数来创建，也就是说 channel 也是一种引用类型(make函数会返回低层数据结构的引用给channel)

2. 向 channel 中读写数据

    前面说了 channel 是用于 goroutine 之间通信的, 自然能够从 channel 中写入和读取数据，使用的都是 `<-` 操作符

    ```
    ch := make(chan int)
    ch<- 1              // 向 channel 中写入数据
    var a int = <-ch    // 从 channel 中读取数据
    ```
3. 关闭 channel
    在我们使用完一个 channel 之后，可以调用 close() 方法来关闭一个 channel,　关闭之后的通道，不能够再进行数据的写操作, 但是仍然可以读取之前写入成功的数据(如果没有数据了，将返回零值)。

channel 的基本操作就是上面这么多，不过实际上，channel 是有两种的: 无缓冲的 和 有缓冲的。上面我们创建的是无缓存的，有缓存的创建方式是 `ch := make(chan int, 2)`, 二者的区别是:

1. 无缓冲的 channel 的发送操作将导致发送者的 goroutine 阻塞，直到在另一个 goroutine 上对其进行接收操作。如果先发生的是接收操作，那么接收者将被阻塞，直到在另一个 goroutine 上对其进行发送操作。
2. 带缓存的 channel 可以缓存多个数据，因此不会立即阻塞，只有当缓存满了之后，发送者才可能会被阻塞，并且只有到缓存为空时，接收者才可能被阻塞

例1: 通道用于传递消息

```go
package main

import "fmt"

func main() {
	message := make(chan string)  		// 创建一个用于传递字符串的通道

	go func() {
		message <- "This is a message."   // 向 channel 写入数据
	}()

	msg := <- message		// 从 channel 读取数据
	fmt.Println(msg)
}
```

例2: 利用通道进行同步

```go
package main
import "fmt"

func hello() {
	fmt.Println("Hello World!!!")
    done <- true          
}
func main() {
    done := make(chan bool)

	go hello()
	fmt.Println("Bye!!!")

    <-done           // 这里会阻塞住，直到在另一个 goroutine 中对 done 进行写入操作之后
}
```

## 单向 channel

当使用 channel 作为参数，我们可以指定 channel 为单向的，即让通道在函数中只能发送，或者只能接收数据，以此来提高程序的安全性.

语法:

- `<-chan type` 表示一个只能接收数据的通道
- `chan<- type` 表示一个只能发送数据的通道

例子:

```go
package main

import "fmt"

// 这里的 message 在函数 send 中就是一个只能发送数据的通道
func send(msg string, message chan<- string) {
    message<- msg
}

// 这里的 message 在函数 receive 中就是一个只能发送数据的通道
func receive(message <-chan string) string {
    msg := <- message
    return msg
}

func main() {
    message := make(chan string)
    go send("hello", message)
    fmt.Println(receive(message))
}
```

输出结果是 `hello`, 此时在函数 send 中，message 通道就只能用于发送数据，而在函数 receive 中通道只能接收数据，通过参数的限制使其在函数内部成为了单向的通道。

## select

go语言提供了一个 select 关键字，可以使用它来等待多个通道的操作，以实现多路复用。语法:

```go
select {
    case <-ch1:
        ...
    case ch2 <- value:
        ...
    default:
        ...
}
```

其中的每个 case 表示一个 channel 的操作，当case语句后面指定通道的操作可以执行时，select 才会执行 case 之后的语句。此时其他的语句都不会被执行。

例子: 超时处理

```go
package main

import "time"
import "fmt"

func main() {
    ch1 := make(chan string, 1)
    go func() {
        time.Sleep(time.Second * 2)
        ch1 <- "result 1"
    }()

    select {
        case res := <- ch1:
            fmt.Println(res)
        case <-time.After(time.Second * 1):
            fmt.Println("timeout 1")
    }

    ch2 := make(chan string, 1)
    go func() {
        time.Sleep(time.Second * 2)
        ch2 <- "result 2"
    }()
    select {
    case res := <-ch2:
        fmt.Println(res)
    case <-time.After(time.Second * 3):
        fmt.Println("timeout 2")
    }
}
```

上面的例子中我们定义了两个通道和两个select结构，是为了进行对比，第一个channel会在等待两秒之后被写入数据，而在 select 中，第二个case语句只会等待一秒，然后就会执行，因此就会执行超时操作。而在第二个 select 中，第二个 case 语句会等待三秒。所以上述程序的结果如下:

```
timeout 1
result 2
```