---
title: go语言学习-结构体
date: 2017-07-21 20:49:20
tags:
    - go
    - golang
---

## 结构体

go语言中的结构体，是一种复合类型，有一组属性构成，这些属性被称为字段。结构体也是值类型，可以使用new来创建。

定义:

```
type name struct {
    field1 type1
    field2 type2
    ...
}
```

我们可以看到每一个字段都由一个名字和一个类型构成，不过实际上，如果我们如果不需要使用某个字段时，可以使用”_”来代替它的名字

并且结构体字段可以是任意类型，函数，接口，甚至是结构体本身都可以

## 使用结构体

定义一个Person结构体

```
type Person struct {
    name string
    age  int
}
```

使用

```
// 字面量形式初始化
var p1 = Person{
    name: "Tom",
    age: 18,
}

var p2 = Person{"Cat", 20}

fmt.Println(p1)          //{Tom 18}                                                                                     
fmt.Println(p1.name)     // Tom
fmt.Println(p2)          // {Cat 20}

p1.age = 20      // 设置p的age字段的值
fmt.Println(p1)     // {Tom 20}
还可以使用new函数来给一个结构体分配内存，并返回指向已分配内存的指针

var p3 *Person   // 声明一个Person类型的指针
p3 = new(Person)   // 分配内存

// 上面两句相当于
p3 := new(Person)

p3.name = "Cat"
p3.age = 10

fmt.Println(p3)       // &{Cat 10}
fmt.Println(p3.name)  // 
```

我们可以直接使用结构体指针通过”.”来访问结构体的字段，就像直接使用结构体实例一样,　go会自动进行转换

还有一种叫做混合字面量的语法来声明，如下，这其实只是一种简写方式，底层还是调用new方法

```
var p4 = &Person{"Dog", 10}  // 同样返回的是Person类型的指针

fmt.Println(p4)             // &{Dog 10}
fmt.Println(p4.name)        // Dog
```

## 匿名字段

go语言的结构体还支持匿名字段，也就是说一个只有类型而没有字段名(连”_”都没有)的字段,被匿名嵌入的也可以是任何类型,此时类型名就是字段的名字，也就是我们可以直接使用类型名为字段名来访问匿名字段。

另外如果匿名字段是另一个结构体，这就叫做内嵌结构体，这个特性可以模拟类似继承的行为。

```
type Person struct {
    name string
    age  int
}

type Student struct {
    Person
    int
}

// 定义一个Student类型的变量
var s = Student{Person{"gdb", 10}, 10}

// 可以使用如下的方法访问内部结构体中的字段
fmt.Println(s.Person.name)

// 也可以这样访问，go将自动使用Person的name属性，不过如果在Student中也定义了name字段，这里就不能使用了
fmt.Println(s.name)

// 访问int类型的匿名字段,此时类型就是字段的名字
fmt.Println(s.int)
```

注意：这样如果两个字段有相同的名字时，外部的名字会覆盖内部的；如果同一级别出现相同名字的字段，会出错，需要注意;并且不能同时嵌⼊某⼀类型和其指针类型，因为它们名字相同。

## 标签

结构体中的字段除了可以有名称和类型以外，还可以有标签。它是一个附属于字段的字符串，可以是文档或其他的重要标记。后面说反射时再说。


## 方法

之前学习的面向对象语言，比如说Java, Python中，有类的概念，每个类都可以有自己的成员变量，成员方法，它们都是定义在类中的

go语言中的结构体就类似与面向对象语言的类，而结构体的字段就相当于类中的成员变量，结构体也可以有方法，但是不是直接定义在结构体中的，go语言中有一个接收者的概念，我们可以将函数作用在一个接收者，此时这个函数就被称为方法

接收者是某种类型的变量，不仅仅可以是结构体，几乎任何类型都可以是结构体，比如: int,bool, string或数组的别名类型，甚至可以是函数类型，不过不能是接口类型

定义方法的示例:

```
type Person struct {
    name string
    age int
}

// 使用Person类型的实例做接收者,这就是一个Person类型方法，方法名前面括号中的就是接收者
func (this Person) getName() string {
    return this.name
}

// Peron类型的指针对象也可以作为接收者
func (this *Person) setName(name string) {
    this.name = name
}

tom := Person{"Tom", 20}
fmt.Println(tom)  // {Tom 20}
fmt.Println(tom.getName())  // Tom

tom.changeName("Bob")
fmt.Println(tom)  // {Bob 20}
```

这里有一点需要注意：类型和绑定它的方法必须在同一个包中（不一定要在同一个文件中）

这里使用类型直接作为接收着 和 类型的指针作为接收者的区别，就相当于普通函数中，值类型的参数和引用类型参数的区别；即在方法中对类型的实例的操作，不会影响外部的实例的值，而使用类型指针的实例作为引用参数，在方法内部修改会影响外部的实例

## 匿名字段

我们也可以使用结构体内部的匿名字段，作为方法的接收者，此时这个结构体，仍然可以调用这个方法，此时编译器会负责查找

```
type Person struct {
    name string
    age int
}

type Student struct {
    Person
    score int
}

func (p *Person) show() {
    fmt.Println("My name is " + p.name + ", I'm " + strconv.Itoa(p.age) + " years old")
}


tom := Person{"Tom", 20}
// 调用匿名字段作为接收器的方法
tom.show()   // My name is Tom, I'm 20 years old
```

在此基础上，我们还可以在结构体上，实现与匿名字段同名的方法，就像面向对象中的重写类似，编译器会先查找结构体实例作为接收器的方法。

## 方法集

根据定义结构体以及方法的不同，方法集也有所不同，了解他们，对理解接口有帮助

```
type T struct {
    name string
    age int
}

type G struct {
    T
    action string
}

type S struct {
    *T
    sel string
}
```

- 类型 T 的方法集包含所有接收者为 T　的方法
- 类型*T的方法集包含所有接收者为 T的方法(因为go会自动解引用)和所有接收者为 *T 的方法
- 类型G包含匿名字段 T, 则G的方法集，仅仅包含T类型的方法集
- 类型S包含匿名字段 \*T,则S的方法集，包含T和\*T类型的方法集


