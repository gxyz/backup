---
title: 使用css让元素居中
date: 2017-03-23 18:03:32
tags: css
---

在做一些项目时，经常会使用css来使元素或者内容居中，这是必备技能，下面介绍几种居中的方法

## 水平居中

### 行内元素

使一个块元素中的行内元素水平居中很简单, 之间对块元素使用 `text-align: center`, 即可是内部的行内元素水平居中

这种方法适用于行内元素，行内块元素, 以及其他 inline-*元素 等等

### 块级元素

对于块级元素，可以使它的 `margin-left` 和 `margin-right` 为 `auto`,对于没设置宽度的块级元素，它的宽度是父级元素的100%, 因此不必手动居中。

```css
.block {
	margin-left: auto;
	margin-right: auto;
}
```


如果知道块元素的确定宽度，可以使用如下方法来使块元素居中:

```css
.block {
	position: absolute;
	width: 500px;
	left: 50%;
	margin-left: -250px;
}
```

如果不知道确切的宽度，使用下面的方法:

```css
.block {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}
```

如果需要多个块元素在同一行水平居中，可以直接使用 `display: inline-block` , 然后使用行内元素的方法，就可以了;

## 竖直居中

### 行内元素

对于单行/文本元素，可以让它上下有相同的填充，即设置上下 padding 值一致

```css
.inline {
	padding-top: 30px;
	padding-bottom: 30px;
}
```

或者使元素的行高等于它的高度:

```css
.inline {
	height: 50px;
	line-height: 50px;
}
```

### 块元素

在已知块元素的高度的情况下，可以使用下面的方法:

```css
.block {
	position: absolute;
	height: 500px;	
	top: 50%;
	margin-top: -250px;
}
```
如果不知道确切的高度，使用下面的方法:

```css
.block {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
}
```

## 水平垂直都居中

### 元素有固定的宽高

对元素使用绝对定位，使它的 top 和 left 属性都为 50%， 然后使用 负margin值来将元素移动到居中的位置，即 `margin-top = -Height/2; margin-left = -Width/2`

需要注意的是，这里的 Width 和 Height 是元素本身设置的宽高和padding, border的和，即:

```
Width = border-left + padding-left + width + padding-right + border-right
Height = border-top + padding-top + height + padding-bottom + border-bottom
```

例子:

```css
.elememt {
	width: 500px;
	height: 500px;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-left: -250px;
	margin-top: -250px;
}
```

### 元素没有固定的宽高

如果不知道元素的宽度和高度，可以使用 transform 属性，与上面的方法很类似，但是不需要知道元素的宽高

```css
.elememt {
	width: 500px;
	height: 500px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
```

适用于块元素，行内元素等


### 直接使用 flex 布局

这种方式很简单，但目前来说并不是所有的浏览器都支持, 对需要居中的元素的父元素使用下面的样式:

```css
.parent_element {
	display: flex;
	justify-content: center;
	align-items: center;
}
```

此时元素会在父元素内部水平垂直居中, 适用于块元素，行内元素等
