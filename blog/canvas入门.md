author: me
title: canvas入门
date: 2016-12-29 20:27:42
tags: 
    - canvas
---

# canvas学习

canvas元素是HTML5中加入的新功能，这个元素通常结合 JavaScript脚本来用于图形的绘制，它的中文意思就是“画布”。

## 开始

想要开始学习canvas,只需要一个编辑器和一个浏览器就够了，首先创建一个html文件:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Canvas 入门</title>
</head>
<body>
    <canvas id="canvas" width="1024" height="468">
    </canvas>
    <script src="main.js"></script>
</body>
</html>
```

首先创建了`<canvas>`元素,并设置了它的宽度和长度，并且设置了一个 id,方便在JavaScript中获取这个canvas元素，进行操作；然后引入了`main.js`这个文件,我们将在这个文件中操作canvas

> 注意：这里设置canvas的宽高(它们就是canvas自己的属性，是在浏览器中的实际占的高度,单位默认就是px)时并没有单位，w3c规定它的值就是一个非负整数，并且它们与css中的width和height是不一样的

然后就可以在脚本中操作 canvas了:

```javascript
window.onload = function() {
    var canvas = document.getElementById("canvas");   // 获取canvas对象
    var context = canvas.getContext('2d');            // 获取上下文对象
    // 通过上下文对象来进行图形的绘制
}
```


以上的步骤可以总结为下面:

1. 在html中定义 `<canvas id="canvas" width="1024" height="468"></canvas>`
2. 使用`document.getElementById("canvas")`获取canvas对象;
3. 使用`canvas.getContext('2d')`获取上下问对象，绘图就是使用它的API;
4. 通过上下文对象进行图形的绘制

其实canvas对象的API很少,主要就是:

- `canvas.width`    
- `canvas.height`
- `canvas.getContext()`

其中 width 和 height 是用来设置canvas在浏览器中的实际占的宽高，与在定义canvas标签使用的属性作用是一样的，getContext()的作用就是获取上下文对象；

主要的绘图API还是在上下问对象中.


## 基本图形的绘制

canvas是基于状态来绘制的，先设置好状态，然后进行绘制,首先学习一些基本的方法:

这里需要说的是，canvas中坐标的原点(0, 0)在左上角

- `context.moveTo(x, y)`         将画笔移动到某个点,参数是点的坐标
- `context.lineTo(x, y)`　　      画一条直线到某个点,参数是点的坐标
- `context.strokeStyle`          设置线条样式(通常是颜色) "#000", "red", "rgb(255,255,255)","rgba()","hsl()","hsla()"
- `context.fillStyle`　　         设置填充样式(通常是颜色)　可用的格式: "#000", "red", "rgb(255,255,255)","rgba()","hsl()","hsla()"
- `context.lineWidth`　　         设置线条宽度

上面的几个方法是用来设置状态的，下面的两个方法才真正进行绘制:

- `context.stroke()`              绘制图形
- `context.fill()`                填充图形


**绘制路径(直线)**


```javascript
var canvas = document.getElementById("canvas");   // 获取canvas对象
var context = canvas.getContext('2d');            // 获取上下文对象

context.moveTo(100, 100);                       // 将画笔移动到 100,100的位置
context.lineTo(300, 300);                       // 画一条直线到 300,300的位置
context.lineWidth = 5;                          // 设置线条的宽度为 5个像素
context.strokeStyle = "#000";                   // 设置线条的颜色为纯黑

context.stroke();                               // 绘制               
```

这样就画出来了一条直线，有自己的颜色和线宽。

**绘制矩形**

学会了绘制直线，绘制矩形就是水到渠成了,可以使用上面的方法，不过canvas还提供了更加方便的方法来绘制矩形：

- `context.rect(x,y,width,height)`         绘制矩形,参数为矩形左上角的坐标，矩形的长和宽，这个需要配合stroke和fill使用
- `context.fillRect(x,y,width,height)`    绘制出填充的矩形，参数同上
- `context.strokeRect(x,y,width,height)`   绘制出一个矩形的边框, 参数同上

`rect()`函数可以配置前面的 stroke和fill使用; 而 fillRect() 和 strokeRect() 可以直接使用绘制矩形


```javascript
context.rect(0, 0, 300, 300);
context.stroke();
```

上面就绘制了一个长宽都是300的矩形

**绘制弧形**

要绘制弧形就不能使用上面绘制直线的方法了，需要使用:

- `context.arc()`  用来绘制弧形

这个方法一共有6个参数,前两个是圆心的坐标，第三个是半径,然后是这个弧线开始的角度和结束的角度，最后一个参数是绘制的方向；这里的角度指的是弧度值, 绘制的方向指的是顺时针或者逆时针(默认是false,表示顺时针的弧度，如果设置为true,则是逆时针)

```javascript
context.arc(300, 300, 100, 0, 2 * Math.PI);
context.fill();
```

这里就画了一个 圆心为`(300, 300)`,半径为100的空心圆
