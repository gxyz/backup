---
title: 使用HTML5视频和音频
date: 2017-04-24 11:24:01
tags: HTML5
---


在HTML5出现之前，页面中的视频和音频经常通过flash，以及一些很复杂的方式来实现，不易于使用，因此HTML5 中引入了标签 `audio` 和 `video` 来支持嵌入页面的音频和视频，方便开发者的使用。

## 嵌入视频

嵌入视频，使用 video 标签:

```html
<video src="/path/to/video.ogg" controls>
    <p>此浏览器不支持 video 标签，请切换浏览器</p>
</video>
```

有几点需要解释:

- src 属性：用于指定视频资源存放的路径，video标签对视频格式有所限制，这个后面说
- video 内部的文字：由于不是所有浏览器都支持 video, 因此需要在不支持这个标签的浏览器中，提供显示的备用内容就是这些内容。
- controls属性：这是一个布尔属性，只写属性值是表示真，用来添加播放、暂停和音量控件

此时就可以正常的播放，指定格式的视频了，并且可以调节音量和播放/暂停

### 视频格式

video 标签，目前只支持三种视频格式, 但其实也不是所有浏览器都支持这三种:

- Ogg格式：以 .ogg 为后缀的视频文件
- MPEG4格式: 以 .mp4 为后缀的视频文件
- WebM:  以 .webm 为后缀的视频文件

由于不是浏览器所有浏览器都支持这个格式的视频，因此，可以使用下面的方式来使用:

```html
<video controls>
    <source src="video.ogg" type="video/ogg">
    <source src="video.mp4" type="video/mp4">
    <source src="video.webm" type="video/webm">
    你的浏览器不支持 video标签
</video>
```

source 标签就是用来链接不同的视频文件的，浏览器将使用第一个可以识别的视频格式。

### video 标签的其他属性

- autoplay -  布尔值属性，设置之后，视频在就绪后将会立即播放
- controls -  布尔值属性，设置之后，会显示播放、暂停和音量控件
- loop  -  布尔值属性，设置之后，视频将循环播放
- preload -  布尔属性, 设置之后,视频在页面加载时进行加载，并预备播放
- height/width -  设置视频播放器的高度/宽度，单位为像素。只需写数字即可

例子:

```html
<video autoplay controls loop width="300" height="300" src="/path/to/video.mp4">
    你的浏览器不支持 video标签
</video>
```

此时这个视频将自动，循环的播放，并且视频播放器的宽高都是300px, 且还有一些播放相关的控件。

### 相关DOM操作

video 标签对应的 DOM对象也有一些自己的方法，可以用来操作它。

下面简单介绍几个，更多方法、属性和事件可以查看[w3school](http://www.w3school.com.cn/html5/html_5_video_dom.asp)

```javascript
// 1. 首先获取一个 video 元素的dom对象
var vid = document.getElementsByTagName("video")[0];   

// 2. 播放视频
vid.play();

// 3. 暂停播放
vid.pause();
```

## 嵌入音频

音频使用 audio 标签来引入, 一个简单的例子:

```html
<audio src="/path/to/audio.ogg" controls>
    你的浏览器不支持 audio 属性
</audio>
```

可以看到这里 audio 的使用方式与 video 基本上是相同的。

### 音频格式

audio 标签，目前也支持三种音频格式, 但其实也不是所有浏览器都支持这三种:

- Ogg格式：以 .ogg 为后缀的音频文件
- MP3格式: 以 .mp3 为后缀的音频文件
- Wav:  以 .wav 为后缀的音频文件

由于不是浏览器所有浏览器都支持这个格式的视频，因此，可以使用下面的方式来使用:

```html
<audio controls>
    <source src="audio.ogg" type="audio/ogg">
    <source src="audio.mp3" type="audio/mpeg">
    <source src="audio.wav" type="audio/wav">
    你的浏览器不支持 video标签
</audio>
```

### audio 标签的其他属性

audio 标签的属性与 video 的属性基本一致，只是没有 width 和 height 属性，其他基本一致。

以上就是 HTML5 提供的 video 和 audio 标签的基本用法，可见HTML5的确是易用的。