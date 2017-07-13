---
title: requests库学习之基本方法
date: 2017-05-06 23:02:58
tags:
    - python
    - requests
---


很早就听说了 Python中 requests 库了，可以非常方便的用来获取网页数据，爬取网页等等。最近对爬虫有一些兴趣，就来简单的学习一下。

首先需要先安装, 直接使用 pip 即可:

```
pip install requests
```

> 注意：这里我使用的是 Python 3.5

## 使用 requests 库的基本框架

```python
import requests

try:
    r = requests.get(url, timeout=30)
    r.raise_for_status()    
    r.encoding = r.apparent_encoding    
    return r.text
except Exception as e:
    return "产生异常"
```

上面这些方法先简单介绍一下:

- requests.get() 使用get请求来获取指定 url地址的内容，超时时间设置为 30, 它返回的是一个 Response 对象
- response.raise_for_status()  如果返回状态码不是 200, 即抛出 HTTPError 异常
- response.encoding         这个属性表示html中标注的编码格式, 如果没有标注默认是 ISO-8859-1
- response.apparent_encoding    这个属性是根据网页内容推断出的编码格式, 因此一般使用这个编码，保证网页正常显示
- r.text 是网页的文本内容

之所以使用这种框架，就是为了使我们的程序更加的健壮，不至于老是出错，因此我们捕获了可能出现的异常，来使程序更加的友好。

下面详细了解一下这个库的方法

## requests 库常用的方法

下面的每一个方法都对应于一个 HTTP协议的方法,即我们常说的 GET,POST,HEAD等等，并且起到的作用于这些HTTP动词是相同的。如下表所示

|requests库方法|HTTP协议方法|作用|
|---|---|---|
|requests.get()|GET|请求获取URL位置的资源|
|requests.post()|POST|请求获取URL位置的资源后附加新的数据|
|requests.head()|HEAD|请求获取URL位置资源的响应报告，即该资源的头部信息|
|requests.put()|PUT|请求向URL位置存储一个资源，覆盖原URL位置的资源|
|requests.patch()|patch|请求局部更新URL位置的资源，即改变该处资源的部分内容|
|requests.delete()|delete|请求删除URL位置存储的资源|


由于HTTP协议通常使用 URL 作为定位网络资源的标识,因此我们上面这些方法都需要传入一个 url地址

URL地址的格式如下:

```
http[s]://host[:port][path][params]
```

- host 表示合法的 Internet 主机域名以及 IP地址
- port 端口号，默认为80
- path 请求资源在服务器上的路径
- params  请求参数 `?k1=v1&k2=v2`

几个小例子:

```
http://baidu.com
https://www.baidu.com/s?wd=python
```

另外还有一个常用的方法 `requests.request`, 它是其他方法的基础方法, 其他方法的内部其实都是由它来实现的.下面就来详细的学习一下这些方法

### requests.request

定义:

```python
requests.request(method, url, **kwargs)
```

参数的含义:

- method: 请求方式，对应 get/put/post/head/patch/options/delete 等等
- url:  获取页面的url连接
- **kwargs: 控制访问参数，有 13个，都是可选项

13个控制访问参数解析:

- params: 字典或者字节序列，作为url参数(?k=v&k=v)增加到 url 中
- data: 字典、字节序或文件对象，作为向服务器提供或者提交资源时使用,作为Reqeust内容(放在请求的主体中)
- json: JSON格式的数据，作为 Request内容(放置请求的主体中)
- headers: 字典,HTTP定制头部信息，用来自定义头信息(可以用来模拟浏览器访问服务器)
- cookies: 字典、或者 CookieJar对象，Request中的cookie
- auth: 元组，用于支持 HTTP 认证功能，
- files: 字典，向服务器传输文件时使用的字段，格式: `{'file': open('data.xls', 'rb')}`
- timeout: 数字，设置请求的超时时间，以秒为单位
- proxies: 字典类型，设定访问代理服务器，可以增加登录认证, 设置之后访问服务器时使用的就是代理服务器的ip地址，格式: {'http': 'http://10.22.11.111', 'https': 'https://211.2.343.23'}, 可以隐藏我们的信息
- allow_redirects: True/False, 默认为 True, 重定向开关, 即是非运行对url进行重定向
- stream: True/False, 默认为 True, 是否获取内容后立即下载
- verify: True/False, 默认为 True, 认证 SSL 证书的字段
- cert: 设置本地SSL证书路径

### requests.get

```
requests.get(url, params=None, **kwargs)
```

- url 获取页面的url连接
- params: 字典或者字节序列，作为url参数(?k=v&k=v)增加到 url 中
- **kwargs 就是其他12个参数

### requests.head

```
requests.head(url, **kwargs)
```

- url 获取页面的url连接
- **kwargs 就是其他13个访问控制参数

### requests.post

```
requests.post(url, data=None, json=None, **kwargs)
```

- url 获取页面的url连接
- data: 字典、字节序或文件对象，作为向服务器提供或者提交资源时使用,作为Reqeust内容(放在请求的主体中)
- json: JSON格式的数据，作为 Request内容(放置请求的主体中)
-  **kwargs 就是其他11个访问控制参数


### requests.put

```
requests.put(url, data=None, **kwargs)
```

- url 获取页面的url连接
- data: 字典、字节序或文件对象，作为向服务器提供或者提交资源时使用,作为Reqeust内容(放在请求的主体中)
- **kwargs 就是其他12个参数

### requests.patch

```
requests.patch(url, data=None, **kwargs)
```

- url 获取页面的url连接
- data: 字典、字节序或文件对象，作为向服务器提供或者提交资源时使用,作为Reqeust内容(放在请求的主体中)
- **kwargs 就是其他12个参数


### requests.head

```
requests.head(url, **kwargs)
```

- url 删除页面的url资源
- **kwargs 就是其他13个访问控制参数


上面这些方法是requests中的核心方法，使用方法基本一致，很简单，这里就先介绍学习这么多，之后我们会做一些练习，并且深入的了解一下requests库中的 Request 对象和 Response 对象