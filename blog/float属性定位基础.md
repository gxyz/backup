---
title: float属性定位基础
date: 2016-12-04 19:10:10
tags:
    - css
---

CSS的float属性，即浮动属性，也是常用的用来定位的属性，可以使一个元素脱离正常的文档流，然后被安放到它所在容器的的左端或者右端，并且可以使其他的文本和行内元素围绕它安放。

<!--more-->

在CSS中，任何元素都可以浮动，并且不论他本身是什么元素，都会变成一个块级框。即使设置了其他的display属性值，大部分也会被计算为block，这里具体可以查看[MDN](https://developer.mozilla.org/zh-CN/docs/CSS/float);

## 语法

```
float: none|right|left|inherit;
```

## 属性值

|属性|描述|
|---|---|
|none|默认值，即元素不浮动，就是正常的情况|
|left|元素向左浮动|
|right|元素向右浮动|
|inherit|继承父元素的float属性|

## 正常情况

```html
<div class="container">
  <div class="box">box1</div>
  <div class="box" id="two">box2</div>
  <div class="box">box3</div>
</div>
```

```css
.container {
  width: 200px;
  height: 200px;
  background-color: #e8eae9;
}
.box {
    float: none;
    width: 50px;
    height: 50px;
    border: 2px solid #0dd;
    margin: 2px;
    background-color: #0ff;
}
```

此时示意图如下:

![float_none](http://7xo1su.com1.z0.glb.clouddn.com/float_none.png)

## 左浮动或右浮动

当一个元素浮动之后，它会被移出正常的文档流，向左或者向右浮动，直到所在容器的边缘，或者碰到了其他的浮动元素。

```css
#two {
  float: left;
}
```

此时，id为two的div,就会脱离文档流，浮动到父元素的最左边，然后后面的div就会上来填充他本来的位置。

![float_left](http://7xo1su.com1.z0.glb.clouddn.com/float_left.png)

```css
#two {
  float:right;
}
```
与float为left时的表现相似，只不过是向右浮动

![float_right](http://7xo1su.com1.z0.glb.clouddn.com/float_right.png)

## 常见应用

```css
.box {
    float: left
}
```

此时的效果:

![float_all](http://7xo1su.com1.z0.glb.clouddn.com/all_float.png)


可是使用这种方式来制作导航栏

## float元素与行内元素

上面主要是展示了　float之后的元素在多个块元素中的位置变化，下面说一说在文本元素中或者行内元素中的表现

float之后的元素，可以使其他的文本和行内元素围绕它安放。

```html
<div class="container">
  <div class="box" id="one">box1</div>
  <div class="box inline">inline</div>
</div>
```

```css
.container {
  width: 200px;
  height: 200px;
  background-color: #e8eae9;
}
.box {
    width: 50px;
    height: 50px;
    border: 2px solid #0dd;
    margin: 2px;
    background-color: #0ff;
}
.inline {
  display: inline-block;
}
#one {
  float: left;
}
```

可以看到此时行内元素并不会填充到float元素之前的位置，而是围绕着它。

![inline](http://7xo1su.com1.z0.glb.clouddn.com/inline.png)

## float元素与文本元素

float之后的元素与文本元素直接的表现，和行内元素直接的表现一样，也是围绕这它;

```html
<div class="container">
  <div class="box" id="one">box1</div>
  <p>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
  </p>
</div>
```

```css
.container {
  width: 200px;
  height: 200px;
  background-color: #e8eae9;
}
.box {
    width: 50px;
    height: 50px;
    border: 2px solid #0dd;
    margin: 2px;
    background-color: #0ff;
}
#one {
  float: left;
}
```

![float_text](http://7xo1su.com1.z0.glb.clouddn.com/text.png)
