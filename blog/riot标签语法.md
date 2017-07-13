---
title: riot标签语法
date: 2017-03-30 11:16:34
tags:
    - JavaScript
    - riot
---

昨天简单的研究了一下 riot.js, 做了一个小例子，今天来继续学习 riot的标签语法

Riot标签是布局（HTML）与逻辑（JavaScript）的组合

## riot 标签的组成结构

首先最外层一定是 自定义标签对，riot 规定自定义标签必须成对闭合，不能自闭和，并且它的布局和逻辑都必须定义在最外层的自定义标签的内部, 即基本结构如下:

```html
<custom-tag>
    <!-- layout: 布局 -->

    // logic: 逻辑
</custom-tag>
```

这里的 HTML 和　JavaScript 是写在一起的，有以下方式:

1. 将逻辑写在 <script></script> 标签中
2. 不使用 script 标签，将 JavaScript 写在最后一个 HTML 标签之后才能被识别

例如:

```html
<custom-tag>
    <!-- layout: 布局 -->
    <h1>Hello {name} !!</h1>

    <script>
    // logic: 逻辑
        this.name = this.opts.name
    </script>
</custom-tag>
```

> 自定义标签可以为空，也可以只有 HTML, 甚至可以只有 JavaScript

## 表达式

在标签的 HTML 中可以插入JavaScript表达式，不过需要使用 `{ }` 来括起来, 就像上面的例子一样, 这样的表达式既可以作为属性值，也可以作为文本节点:

```
<h1 id={作为属性值}>
    {作为文本节点}
</h1>
```

但是这里的表达式最好保持简单，不要使用复杂的，否则会使 HTML 变得臃肿，难以阅读，可以将它们放到 script 中去

有时候我们需要在 html 中表示真正的 `{ }` 此时我们可以使用 `\\` (其实是使用 '\' 进行转义，不过 '\'也需要进行) 来进行转义  `\\{ .... \\}`


## 添加样式

在自定义标签的内部，可以放置一个 style 标签，来定义样式， riot.js 会自动将它放到 head 部分

```html
<custom-tag>
    <h1>Hello {name} !!</h1>

    <style>
        custom-tag {
            display: block;
        }
        custom-tag h1 {
            color: blue;
        }
    </style>

    <script>
        this.name = this.opts.name
    </script>
</custom-tag>
```

除了这种使用 自定义标签做选择器 来限定 css 作用域的方式，还可以使用局部作用域来限定，下面的 局部CSS, 与上面等同:

```html
<style scoped>
    :scope {
        display: block;
    }
    h1 {
        color: blue;
    }
</style>
```

虽然自定义标签在页面中可以被使用或者说初始化多次，但是CSS只会移动一次

## 预处理器

在 标签的 JavaScript 中，还可以使用预处理器, 只需给 script 标签指定一个 type 属性即可, 例如:

```
<script type="es6">
</script>
```

可用的值有, es6, typescript, coffeescript等等，也可以加上 text 前缀，即 `text/es6`

然后在编译时，通过命令行参数 --type or -t 来指定对应的编译器，当然也需要安装对应的编译器, 例如 es6 可以使用 babel, typescript使用  typescript-simple, 这在[官方文档](http://riotjs.com/guide/compiler/#pre-processors)中都有的

## 挂载标签

标签定义完成之后，我们需要将其加载到页面中才能使用:

```html
<body>
    <!--实例化自定义标签-->
    <custom-tag></custom-tag>

    <!--引入自定义标签文件-->
    <script type="riot/tag" src="custom-tag.tag"></script>

    <!-- 引入 riot+compiler.js -->
    <script src="riot+compiler.js"></script>

    <!--挂载标签实例-->
    <script>
        riot.mount('custom.tag.tag', {
            name: "Riot.js"
        })
    </script>
</body>
```

 然后在页面就会显示红色的 `Hello riot.js`

 这里的 mount 方法的具体用法:

- riot.mount("*")    挂载页面中所有自定义标签
- riot.mount("#id")  挂载标签到页面中指定 id 的 html 元素
- riot.mount("custom-tag, helloworld")    挂载自定义标签到选中的 HTML 元素(即将对应的自定义标签，挂载到custom-tag 和 helloworld 标签处)

另外 mount 方法还有第二个参数，用来传递标签的参数, 就向上面的例子中我们使用的那样，这个参数是以一个对象，在自定义标签中，我们可以使用 this.opts 来访问这个对象， 另外在 对象 this 上的直接属性，可以在自定义标签的 HTML 中直接访问，例如:

```html
<custom-tag>
    <!--这里就直接访问了 this.name 属性-->
    <h1>Hello {name} !!</h1>

    <style>
        custom-tag {
            display: block;
        }
        custom-tag h1 {
            color: blue;
        }
    </style>

    <script>
        this.name = this.opts.name
    </script>
</custom-tag>
```


