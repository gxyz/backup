---
title: 图像处理学习-OpenCV基本使用
date: 2017-08-13 18:11:17
tags:
    - 图像处理
    - opencv
---

## 加载显示存储图像

要学习图像处理，第一步便是学会加载图像数据，然后才是对图像数据进行处理，之后显示处理之后的效果，或者将处理之后的数据存储下来，因此，我们首先要学习的就是:

1. 如果加载图像数据
2. 显示图像
3. 存储图像数据到文件中

### 加载图像

OpenCV 常用的加载图像的方法签名如下:

```cpp
Mat imread( const String& filename, int flags = IMREAD_COLOR );
```

- 第一个参数: 一个文件名的字符串
- 第二个参数: 一个标志位，表示读取图像的模式
- 返回值: 返回值是一个 Mat 类型，是一种矩阵形式的数据结构

### 显示图像

OpenCV中显示的图像的方法如下:

```cpp
void imshow(const String& winname, InputArray mat);
```

- 第一个参数: 窗口名的字符串
- 第二个参数: InputArray类型的对象,可以使用我们前面说的Mat类型的对象

### 保存图像

保存图像的方式:

```cpp
bool imwrite( const String& filename, InputArray img, 
    const std::vector<int>& params = std::vector<int>());
```

- 第一个参数: 存储图片的文件名
- 第二个参数: 需要存储的图片对象,Mat类型
- 第三个参数: 特定格式的参数

### 实例:

```cpp
#include<opencv2/opencv.hpp>

using namespace cv;

int main() {
    Mat img = imread("image.jpg");   // 读取图片数据
    imshow("ImageWindow", img);      // 显示图片内容
    waitKey(0);                      // 程序会在这里阻塞住，直到按下任一按键
    imwrite("other-image.jpg", img); // 将图片数据写入另一个文件
}
```

这里我们仅仅对一个图片进行了读取，显示，存储的操作，在实际的图像处理中，最重要的其实是对图像操作的各种方法，也就是各种图像处理算法，这也是我们关注的重点。

基本的操作就介绍到这里，之后我们就开始图像处理的基本概念和常用算法的学习。