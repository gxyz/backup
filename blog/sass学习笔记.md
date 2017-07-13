---
title: sass学习笔记
date: 2016-12-27 19:35:45
tags: sass
---


SASS是一种CSS预处理器，可以方便CSS的开发

## 安装

SASS是ruby写的，因此要先安装 ruby, 然后安装 SASS

```
gem install sass

sass --help  查看帮助
```

## sass命令的使用

SASS文件就是普通的文件，可以直接使用CSS语法，文件后缀名有两种：

- 一种是用缩进来分出层级(.sass结尾)，
- 一种与CSS一样使用{}来分层级(.scss结尾)

目前通常使用的是`.scss`结尾的，sass命令用来将`.scss`文件编译为css

```
sass test.scss   // 将转换后的css打印出来

sass test.scss  test.css    // 将转换之后的css放到 test.css 中
```

SASS提供了四种编译风格：

- nested: 嵌套缩进的CSS代码，默认值
- expanded: 没有缩进、扩展的 CSS代码
- compact: 简洁格式的css代码
- compressed: 压缩后的css代码

在生产环境中通常使用最后一个选项:

```
sass --style compressed test.scss test.css
```

如果需要监听某个文件更改，然后自动编译，可以使用:

```
sass --watch input.scss:output.css   // 监听一个文件

sass app/sass:public/stylesheets   // 监听一个文件夹
```

`:`前面是scss文件或文件夹，后面是编译之后放置的文件或目录


## scss文件基础语法

#### 注释

两种注释方式，一种与CSS一样是使用`/* ... */`,另一种是`//`的单行注释，将不会在编译之后的文件中存在, 因为css是不支持 `//`注释的。


```scss
div {
    /* 
     *   this is comment
     */

    // this is comment
}
```

#### 变量

SASS 中可以使用变量，所有的变量使用 `$` 开头。

```scss
$fontSize: 12px;

div {
    font-size: $fontSize;
}
```

编译之后:
```css
div {
    font-size: 12px;
}
```

如果想将变量使嵌入字符串中使用，就需要使用`#{}`

```scss
$side: left;

div {
    border-#{}-radius: 5px;  /* 编译为  border-left-radius: 5px; */
}
```

#### 运算

在sass中还可以使用运算，进行简单的加减乘除等运算

```scss
div {
    width: 300px / 960px * 100%;    /* 编译为：  width: 31.25%; */
    height: 400px / 2;              /* 编译为：  height: 200px; */
}
```

#### 选择器嵌套

sass 还支持嵌套：包括选择器嵌套和属性嵌套。通常经常使用选择器嵌套

之前css中的:

```css
div p {
    font-size: 20xp;
    border-color: red;
    border-radius: 5px;
}

div ul {
    list-style: none;
}
```

可以写作:

```scss
div {
    p {
        font-size: 20px;

        // 属性嵌套，注意这里有一个冒号:
        border: {
            color: red;
            radius: 5px;
        }
    }

    ul {
        list-style: none;
    }
}
```

选择器嵌套写法层级关系很清晰，便于阅读，不过嵌套层次不宜过多。属性嵌套需要注意的是后面有冒号`:`

同时，在嵌套的代码块中，有一个`&`可以用来引用父元素

```scss
a {
    background-color: #ddd;
    
    &:hover {
        background-color: #000;
    }
}
```


## 高级用法

#### 继承

sass中，可以让选择器继承另一个选择器的所有样式,需要使用`@extend`关键词:

```scss
h1 {
    border: 4px solid #ff9aa9;
}

div {
    @extend h1;
    border-width: 2px;
}
```
就相当于:

```css
h1,
div {
    border: 4px solid #ff9aa9;
}

div {
    border-width: 2px;
}
```

这里有一个方便的字符`%`,用来定义基础的样式，用来继承，并且如果他没有被使用将不会在编译之后的文件中出现，这样就没有多余的css了,其他就没有什么不同了。

```scss
%base {
    color: red;
}

div {
    @extend %base;
    border-width: 2px;   
}
```

#### mixin (混合)

mixin是一个可以重用的代码块，可以传递参数，还可以设置默认值，使用`@mixin`来声明，`@include`来调用

```scss
// 无参 mixin, 一个蓝色的背景
@mixin blue-box {
    display: block;
    background-color: blue;
}

// 有参 mixin, 背景通过传入的参数`$color`决定,这里有一个默认值为 blue
@mixin color-box($color: blue) {
    display: blue;
    background-color: $color;
}

// 使用 mixin
div {
    @include color-box(red);
}
```

#### 函数

sass定义了很多函数可供使用，我们自己也可以自定义函数，使用`@function`开始，而内置的函数我们使用最多的应该是颜色函数，以方便生成颜色



```scss

// px 转 em的函数
@function pxToem ($target-size, $context: $base-font-size){
    @return $target-size / $context;
}

// 使用内置的颜色函数，第一个参数是颜色值，第二个参数是百分比
lighten(#cc3, 10%) // #d6d65c
darken(#cc3, 10%) // #a3a329
```

#### 控制语句

**@if判断**

`@if`可以单独使用，也可以与`@else`一起使用,同样还有 `@else if`:

```scss
div {
    @if 1 + 1 = 2 {
        display: none;
    } @else {
        display: block;
    }
}
```


**@for循环**

有两种形式：`@for $var from <start> through <end>` 和 `@for $var from <start> to <end>`.

start 表示起始值，end 表示结束值，这两个区别是关键字区别是前面一种包含end,后面一种不包含end

```scss
@for $i from 1 through 3 {
  .item-#{$i} { width: 2em * $i; }
}

@for $i from 4 to 6 {
  .item-#{$i} { width: 2em * $i; }
}
```

编译为:

```css
.item-1 {
  width: 2em; 
}
.item-2 {
  width: 4em; 
}
.item-3 {
  width: 6em; 
}

// -------
.item-4 {
  width: 8em; 
}
.item-5 {
  width: 10em; 
}
```

**@each循环**

语法: `@each $var in <list or map>`

```scss
$color: blue, red, black; 
@each $c in $color {
    .#{$c}-icon {
        color: $c;
    }
} 
```


未完待续....



