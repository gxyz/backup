author: me
title: position定位基础
date: 2016-12-04 00:04:11
tags:
---


CSS 中的 position 属性用来给元素定位。

## 语法

```
position: value;
```

这里的value主要有 static、relative、absolute、fixed等；

- static 跟不使用position属性的效果是一样的，此时 top, right, bottom, left 和 z-index 属性无效。
- relative 绝对定位，与static类似，不过可以使用top, right, bottom, left 和 z-index 属性
- absolute 相对定位，不为元素预留空间，元素脱离文档流，通过指定元素相对于最近的非 static 定位祖先元素的偏移，来确定元素位置。绝对定位的元素可以设置外边距（margins），且不会与其他边距合并。
- fixed 固定定位，不为元素预留空间,元素脱离文档流，与static相似，不过是相对于浏览器视口位置来定位元素。此时元素不会随滚动条的滚动而滚动

## 正常情况

正常情况下，跟 `position: static`是一样的

```html
<div class="box"></div>
<div class="box" id="two"></div>
<div class="box"></div>
<div class="box"></div>
```

```css
.box {
    width: 50px;
    height: 50px;
    border: 2px solid #0dd;
    margin: 2px;
    background-color: #0ff;
}
```

![默认](http://7xo1su.com1.z0.glb.clouddn.com/position_default.png)

## 相对定位

html和css基本结构跟上面相同；相对定位使用的是 `position: relative`属性，使用相对定位的元素不会脱离文档流，因此文档中元素的默认位置始终存在，不会被占用。

```css
#two {
    position: relative; 
}
```
如果只加这一句，那么此时网页的效果与正常情况下的效果是一样的

```css
#two {
    position: relative;
    left: 25px;
    top: 25px;
}
```

![relative](http://7xo1su.com1.z0.glb.clouddn.com/position_relative.png)

注意，这里的相对定位，是指 相对于正常情况下元素位置 来定位，这里就是是元素的左边(left)距离正常情况`25px`,元素的左边(left)距离正常情况`25px`；还要注意这里的移动的方向；

## 绝对定位

html和css基本结构跟上面相同；相对定位使用的是 `position: absolute`属性。使用绝对定位的元素会脱离文档流，因此文档中不会给该元素预留位置，会有后面的元素补上。


```css
#two {
    position: absolute;
}
```
示意图:

![absolute](http://7xo1su.com1.z0.glb.clouddn.com/position_absolute.png)

这里，由于绝对定位元素相对于最近的非 static 祖先元素定位，而当这样的祖先元素不存在时，则相对于根级容器定位。所有这里该div相对与body元素定位。

还可以通过top, right, bottom, left 和 z-index属性来设置该div的定位，还可以使用外边距（margins）属性

## 固定定位

```css
#two {
    position: fixed;
}
```

这个属性与 absolute 属性类似，不过始终相对于浏览器视口位置来定位元素，因此它在页面中的位置是固定的，不会因为页面的滚动而改变

当然也可以使用top, right, bottom, left 和 z-index等属性来条件元素的位置。

## 相关的属性

上面说到的　top, left, right, bottom属性，可以配合 relative、absolute、fixed属性使用。来设置元素的具体位置。

- top和bottom用来设置垂直方向上的位置；例如:`top:20px`,即元素的顶部 距离 使用属性后的默认位置 向下移动 20px;
- left和right用来设置水平方向上的位置；例如: `left: 20px`,即元素的顶部 距离 使用属性后的默认位置 向右移动 20px;

另外还有一个 `z-index`属性，用来设置元素的层叠顺序，即如果多个元素有部分重叠，谁在上面，谁在下面。`z-index`的值越大，就越在上面；注意`z-index`属性的使用前提也是元素设置了relative、absolute、fixed属性之一。

```html
<div class="box" id="green"></div>
<div class="box" id="red"></div>
<div class="box" id="blue"></div>
```

```css
.box {
    width: 50px;
    height: 50px;
    border: 2px solid #0dd;
    margin: 2px;
    position: relative;
}

#green {
    left: 25px;
    background-color: green;
}

#red {
    top: -25px;
    background-color: red;
}

#blue {
    top: -50px;
    left: 25px;
    background-color: blue;
}
```

此时没有设置 `z-index`,默认是下面这样

示意图:

![no_z_index](http://7xo1su.com1.z0.glb.clouddn.com/default_z_index.png)


```css
#green {
    z-index: 3;
}

#red {
    z-index: 2;
}

#blue {
    z-index: 1;
}
```
设置`z-index`之后

![z_index](http://7xo1su.com1.z0.glb.clouddn.com/z_index.png)
