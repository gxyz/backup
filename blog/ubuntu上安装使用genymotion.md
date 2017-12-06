author: me
title: ubuntu上安装使用genymotion
date: 2017-11-27 18:20:30
tags:
    - ubuntu
    - genymotion
    - 问题
---

## 安装virtuelbox
 
```
sudo apt-get install virtualbox-qt
```

使用时遇到以下问题

```
No suitable module for running kernel found
```
 
解决办法：

```
sudo apt-get install virtualbox-source module-assistant
sudo m-a prepare
sudo m-a a-i virtualbox-source
sudo /etc/init.d/virtualbox restart
```
 
## 安装genymotion

1. 先到genymotion官网注册一个账号

2. 下载genymotion,到[https://www.genymotion.com/download](https://www.genymotion.com/download)下载对应系统的版本
3. 执行以下命令

    ```
        chmod +x <Genymotion download path>/genymotion-<version>_<arch>.bin
        cd <Genymotion download path>
        ./genymotion-<version>_<arch>.bin -d <Genymotion installer path>
    ```
    - **Genymotion download path**: genymotion的下载目录
    - **Genymotion installer path**: genymotion的安装目录
    - **genymotion -<version>_<arch>.bin**: 下载的genymotion安装包
4. 进入安装目录执行`./genymotion`
