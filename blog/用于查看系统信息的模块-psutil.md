author: me
title: 用于查看系统信息的模块-psutil
date: 2017-11-24 23:04:28
tags:
    - python
    - psutil
---

psutil是python的一个很有用的模块，可以用来查看系统的各种状态信息，包括内存，磁盘，网络，进程，cpu等的使用情况。能实现linux上ps、top、lso、nice、netstat、ifconfig、who、df、kill、freeionice、iostat、iotop、uptime等命令的功能。
 
## 下载安装
 
psutil下载地址为[https://pypi.python.org/simple/psutil/][1]选择对应版本下载即可，安装过程很简单，就是下一步一直到完成。
 
或者
 
直接使用`pip install psutil`安装
 
 
## 基本使用
 
### 获取cpu的信息
```
    #显示cpu的整个信息
    import psutil
    psutil.cpu_times()
     
    #获取其中单项值，例如：
    psutil.cpu_times() .user
     
    #获取cpu的逻辑个数
    psutil.cpu_count()
     
    #获取cpu的物理个数
    psutil.cpu_count(logical=False)
```
 
### 读取内存信息
 
主要可以获取系统内存利用率信息涉及`total`(内存总数)，`used`(以使用内存)，free(空闲内存)，`buffers`(缓冲使用数)， `cache`(缓存使用数)，`swap`(交换分区使用数)
```
    #获取内存的完整信息
    mem = psuti.virtual_memory()
     
    #获取内存总数
    mem.total   
     
    #获取空闲的内存信息
    mem.free        
     
    #获取swap分区信息
    psutil.swap_memory()
```
 
 
### 获取磁盘信息
```
 
    #获取磁盘的完整信息
    psutil.disk_partitions()
     
    #获取分区表的参数
    psutil.disk_usage('/')
        
    #获取硬盘IO总个数
    psutil.disk_io_counters()
     
    #获取单个分区IO个数，perdisk=True参数获取单个分区IO个数
    psutil.disk_io_counters(perdisk=True)  
     
    #磁盘利用率使用
    psutil.disk_usage 
```
### 读取网络信息
 
其中有几个参数
`bytes_sent`，发送字节数
`bytes_recv`，接收字节数
`packets_sent`，发送数据包数
`Packets_recv`，接收数据包数
```
    #获取网络总IO信息
    psutil.net_io_counters()   
     
    #pernic=True输出网络每个接口信息
    psutil.net_io_counters(pernic=True)     
```
 
### 获取当前系统用户登录信息
```
    #获取开机时间
    psutil.users()
 
    import psutil, datetime
    psutil.boot_time()    
    datetime.datetime.fromtimestamp(psutil.boot_time()).strftime("%Y-%m-%d %H: %M: %S") #转换成自然时间格式
```
 
### 系统进程管理
 
```
    #查看系统全部进程
    psutil.pids()
     
    #查看单个进程,例如，2423是进程号
    p = psutil.Process(2423) 
    p.name()   #进程名
    p.exe()    #进程的bin路径
    p.cwd()    #进程的工作目录绝对路径
    p.status()   #进程状态
    p.create_time()  #进程创建时间
    p.uids()    #进程uid信息
    p.gids()    #进程的gid信息
    p.cpu_times()   #进程的cpu时间信息,包括user,system两个cpu信息
    p.cpu_affinity()  #get进程cpu亲和度,如果要设置cpu亲和度,将cpu号作为参考就好
    p.memory_percent()  #进程内存利用率
    p.memory_info()    #进程内存rss,vms信息
    p.io_counters()    #进程的IO信息,包括读写IO数字及参数
    p.connectios()   #返回进程列表
    p.num_threads()  #进程开启的线程数
```
 
更多内容请看[官方文档][2]
 
 
  [1]: https://pypi.python.org/simple/psutil/
  [2]: http://pythonhosted.org/psutil/
