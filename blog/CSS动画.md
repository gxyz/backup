---
title: CSS动画
date: 2017-03-24 20:51:23
tags: css
---

CSS中的 animation 属性可用于使其他CSS属性有动态的效果，如颜色，背景颜色等等。每个动画需要使用 `@keyframes` 定义，然后使用 animation 属性调用它。

使用方式:

```css
.example {
	animation: animname 5s infinite; 
}

@keyframes animname {
	0% {
		background-color: #fff; 
	}

	100% {
		background-color: #000;
	}
}
```

每个 @keyframes 定义了动画过程中的特定时刻应该发生什么。例如，0% 是动画的开始，100% 是动画的结束。 然后可以通过这个 animation属性 或它的八个子属性来控制，以便更好地控制并操纵这些关键帧。

还可以在一个 animation 使用多个 @keyframes,只需要使用逗号分隔即可:

```css
.example {
	animation: animname1 5s infinite,
				animname2 3s infinite; 
}

@keyframes animname1 {
	0% {
		background-color: #fff; 
	}

	100% {
		background-color: #000;
	}
}

@keyframes animname2 {
	0% {
		color: #000; 
	}

	100% {
		color: #fff;
	}
}
```

animation 相关的属性:

- animation-name: 声明要应用的 @keyframes 的名字
- animation-duration: 动画完成一个周期所需的时间
- animation-timing-function: 建立预设加速度曲线
- animation-delay: 在动画开始之前的延迟
- animation-direction: 是否应该轮流反向播放动画
- animation-iteration-count: 执行动画的次数
- animation-fill-mode:  设置动画在播放之前或之后，其动画效果是否可见。
- animation-play-state:  暂停/播放动画

animation 就是这八个属性的简写方式


## animation-name

此属性就是在 `@keyframes` 后面的名字, 代表着 `@keyframes` 定义的这一段动画

## animation-duration

就是这个动画从开始到结束经历的总时间，即 0% ~ 100% 所耗费的时间, 可以是秒或者毫秒, 默认是 0s

## animation-timing-function

表示动画播放的加速度曲线，动画播放的速度随着这个属性的不同而不同，合法的值有:

- ease:  	默认值, 动画以低速开始，然后加快，在结束又变慢
- ease-out:   动画以低速开始
- ease-in:    动画以低速结束
- ease-in-out:  动画以低速开始和低速结束
- linear:   线性,动画从头到尾的速度是相同的。
- cubic-bezier(x1, y1, x2, y2): 贝塞尔曲线, 这四个值的取值范围都是 0 ~ 1

## animation-delay

动画开始之前延迟的时间, 单位是秒或者毫秒，默认是 0s

## animation-direction

定义是否应该轮流反向播放动画:

- normal:      正常情况, 即播放完成有调到开头
- alternate:   动画播放完之后，又会反向播放   
- alternate-reverse:  与 alternate 类似，不过从一开始是反向播放

## animation-iteration-count

此定义动画的播放次数, 是一个整数值 或 infinite，默认是 1;

- 整数值表示动画播放的具体次数
- infinire 表示动画无限循环的播放

## animation-fill-mode

规定动画在播放之前或之后，其动画效果是否可见

- forwards:  当动画完成后，保持最后一个画面
- backwards: 在动画播放之前，显示动画的第一个画面
- both:      向前和向后填充模式都被应用
- none:      默认状态

## animation-play-state

设置暂停或者播放动画

- paused:  暂停
- running:  播放

## 一个小例子


<p data-height="265" data-theme-id="dark" data-slug-hash="QpxQVJ" data-default-tab="css,result" data-user="blue_sky" data-embed-version="2" data-pen-title="QpxQVJ" class="codepen">See the Pen <a href="http://codepen.io/blue_sky/pen/QpxQVJ/">QpxQVJ</a> by blue_sky (<a href="http://codepen.io/blue_sky">@blue_sky</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

上面例子中使用的是分开的各个属性，对应的简写如下:


```css
animation: moveBox 3s ease 2s alternate 3 backwards
```


