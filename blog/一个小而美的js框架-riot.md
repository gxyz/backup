---
title: 一个小而美的js框架-riot
date: 2017-03-29 20:02:16
tags: 
    - JavaScript
    - riot
---


在逛github时偶然间发现了这个 riot.js 框架， riot.js 官网说它是一个简单而优雅的基于组件的UI库, 有四个特性:

- CUSTOM TAGS(自定义标签) 
- ENJOYABLE SYNTAX(有趣的语法)
- ELEGANT API(优雅的接口)
- TINY SIZE (超小的体积)

因此我就对它产生了兴趣，来研究一番，riot.js官网:  [http://riotjs.com/](http://riotjs.com/)

相比于其他的前端框架它最大的优势就是体积很小，目前最新版本的代码用gzip压缩后只有 9.81KB, 不足10K的大小。因此应该比较适合应用在移动端

下面就来试试看

## 第一次使用

### 首先需要下载库

这里下载的方式很多，可以直接下载js文件，或者使用CDN引入，使用bower安装，或者使用npm安装都可以，这里为了简单我们直接下载js文件，然后引入； 下载地址: [http://riotjs.com/download/](http://riotjs.com/download/)， 需要注意的是，这里我们下载 `riot+compiler.js` 或者 `riot+compiler.min.js` 因为在使用 riot 中，涉及到自定义tag的编译，我们后面再细说

### 创建demo目录结构

创建一个如下所示的文件结构:

```
riot_demo
    |-- index.html
    |-- js
        |-- riot+compiler.js    // 网上下载的库文件
    |-- tags
        |-- helloworld.tag
```

### 创建一个自定义helloworld tag

在`helloworld.tag` 文件中输入下面的代码

```html
<helloworld>
    <h1>Hello World!!</h1>
</helloworld>
```

在 index.html 文件中引入:

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>riot demo1</title>
    </head>
    <body>
        <helloworld></helloworld>

        <script type="riot/tag" src="tags/helloworld.tag"></script>
        <script src="js/riot+compiler.js"></script>
        <script>riot.mount('helloworld')</script>
    </body>
</html>
```

然后在 riot_demo 的目录下启动一个服务器，然后访问对应的地址就可以看到页面上的`Hello World!`了; 这里启动服务器，可以直接使用 python

```
python -m SimpleHTTPServer    // python2 可用
python -m http.server         // python3 可用
```

不能直接打开文件进行访问, 因为在载入 helloworld.tag 文件时，使用了 Ajax，如果直接打开文件来访问, 会报出下面的错误:

```
XMLHttpRequest cannot load file:///D:/code/javascript_work/framework/riot_work/tags/todo.tag. Cross origin requests are only supported for protocol schemes: http, data, chrome, chrome-extension, https, chrome-extension-resource.
```

## 解析

首先说一说 helloworld.tag 文件，这就是 riot 所说的自定义标签，它可以将相关的HTML, CSS和JavaScript放在一起，形成可重用的组件(有点类似于Vue的单文件组件)。上面的例子中我们只写了HTML结构，没有设置样式和JavaScript

之后我们在index.html 文件中引入了我们的 helloworld.tag 文件，注意这里的 `type="riot/tag"`, 接下来引入了 库文件`riot+compiler.js`

最后我们调用了 riot.mount('helloworld'), 这个方法第一个参数为customTagSelector， 用来从页面中选择指定名字的元素，然后将自定义标签挂载到上面，被选中的元素的名字必须与自定义标签的名字匹配； 还有第二个参数，是可选的 opts 对象,可以用于将数据传递到自定义标签中，在自定义标签中可以使用 this.opts 来访问对应的对象的属性

我们来改造一下上面的例子:

将`helloworld.tag` 文件修改为下面这样

```html
<helloworld>
    <h1>Hello {name}!!</h1>

    <style>
        h1 {
            color: red;
        }
    </style>

    <script>
        this.name = this.opts.name
    </script>
</helloworld>
```

index.html改为:

```html
<body>
    <helloworld></helloworld>

    <script type="riot/tag" src="tags/helloworld.tag"></script>
    <script src="js/riot+compiler.js"></script>
    <script>
        riot.mount('helloworld', {
            name: "riot.js"
        })
    </script>
</body>
```

此时页面上就会显示一个红色的 `Hello riot.js`


其实对于 riot.js 的自定义标签还有很多规定，下一篇在详细说