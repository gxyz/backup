---
title: css过渡
date: 2017-03-24 15:38:15
tags: css
---

# CSS 过渡 - transition

过渡属性是用于表示多达四个与过渡相关的长手属性的缩写属性：

transition 是一个复合属性，是其他四个过渡相关属性的简写:

```css
transition: [transition-property] [transition-duration] [transition-timing-function] [transition-delay];
```

|属性|含义|
|---|---|
|transition-property|规定应用过渡的 CSS 属性的名称|
|transition-duration|定义过渡效果花费的时间，默认是 0|
|transition-timing-function|规定过渡效果的时间曲线。默认是 "ease"|
|transition-delay|规定过渡效果何时开始。默认是 0|


## transition-property 

transition-property 属性用于定义要应用过渡的 CSS 属性的名称, 例如，要使 color 过渡:

```css
.example {
    transition-property: color;
}
```

可用的值有下面这些:

1. 单个属性名称
2. 一个以逗号分隔的多个属性的列表, 用于单个元素上的多个属性的过渡
3. none，表示没有属性需要进行过渡
4. all，表示所有属性都需要过渡(默认值)


## transition-duration

通常用于定义完成过渡效果需要花费的时间。也就是说，目标元素在定义的两个状态之间的过渡所需的时间。

```css
.example {
    transition-duration: 3s;
}
```

它的值可以是:

- 有效的时间值（以秒(s)或毫秒(ms)为单位）
- 以逗号分隔的时间值的列表，用于单个元素上有多个属性过渡的情况
- 默认值为0

transition-duration的默认值为0，也就是说即使定义了其他属性，也不会执行，因此这个属性是必须定义的，并且不允许为负值。

## transition-timing-function


transition-timing-function 属性规定过渡效果的速度曲线。

```css
.example {
    transition-timing-function: ease-out;
}
```

这个属性可以使用预定义值，步进函数或立方贝塞尔曲线进行定义。

预定义的值有如下:

- ease  		慢速开始，然后变快，然后慢速结束的过渡效果
- linear        以相同速度开始至结束的过渡效果
- ease-in		以慢速开始的过渡效果
- ease-out		以慢速结束的过渡效果
- ease-in-out	以慢速开始和结束的过渡效果
- step-start    与 steps(1, start) 一样
- step-end      与 steps(1, end) 一样


步进函数(steps)将过渡时间划分为大小相等的时间来运行,语法如下:

```css
.example {
	transition-timing-function: steps(int,start|end);
}
```

第一个参数 int 表示间隔个数，是一个正整数, 第二个参数是可选的，可以是 start或者 end(默认), 当指定为 start 时，值的变化发生在每个间隔的开始处，而使用 end 会导致值在每个间隔结束时发生变化。


## transition-delay

通常用于定义延迟过渡开始的时间。

```css
.example {
    transition-delay: 5s;
}
```

它的值可以是:

- 有效的时间值（以秒或毫秒为单位）
- 以逗号分隔的时间值的列表，用于单个元素上有多个属性过渡的情况
- 默认值为 0, 即默认的延迟为0

## 一个简单的例子

<p data-height="231" data-theme-id="dark" data-slug-hash="xqzdNE" data-default-tab="css,result" data-user="blue_sky" data-embed-version="2" data-pen-title="xqzdNE" class="codepen">See the Pen <a href="http://codepen.io/blue_sky/pen/xqzdNE/">xqzdNE</a> by blue_sky (<a href="http://codepen.io/blue_sky">@blue_sky</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>