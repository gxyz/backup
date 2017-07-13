---
title: ubuntu安装node
date: 2016-12-03 18:33:58
tags: node
---

要想学习node.js，首先当然是要安装好开发环境，我使用的是ubuntu系统。

<!--more-->

## 安装版本管理器

由于node.js版本变化很快,所有一个版本管理工具是很必要的, 所有我们首先安装node.js版本管理工具，这里我选择的是[**n**][1];类似的工具还有nvm

```shell
    git clone https://github.com/tj/n.git
    cd n
    make install

```
  [1]: https://github.com/tj/n

## 安装node.js

```shell
    n + (node.js的版本号)
    // eg: n 4.2.1
```

## 安装nrm
nrm是一个用来管理npm源的工具,可以很方便的测试并切换源，很适合在国内这种情况下使用。

```shell
    npm install -g nrm
    
    // 显示可选的源
    nrm ls
    
    // 测式各个npm的速度
    nrm test
    
    // 切换源
    nrm use taobao
```



## 更多nrm的使用

**列出可用的npm源**
```shell
    > nrm ls

   *npm ---- https://registry.npmjs.org/
    cnpm --- http://r.cnpmjs.org/
    taobao - http://registry.npm.taobao.org/
    eu ----- http://registry.npmjs.eu/
    au ----- http://registry.npmjs.org.au/
    sl ----- http://npm.strongloop.com/
    nj ----- https://registry.nodejitsu.com/
```
\* **代表当前的源**

**测试源的速度**
```shell
    > nrm test
    
    npm ---- 891ms
    cnpm --- 1213ms
   *taobao - 460ms
    eu ----- 3859ms
    au ----- 1073ms
    sl ----- 4150ms
    nj ----- 8008ms
```
**切换源**
```shell
    > nrm use cnpm
    #切换到cnpm源
```

**添加源**
```shell
    > nrm add  <registry> <url> [home]
```
**删除源**
```shell
    > nrm del <registry>
```
