author: me
title: MySQL基本了解
date: 2016-12-09 21:03:31
tags: 
    - mysql
---

MySQL是一个开源的关系型数据库管理系统(RDBMS)，目前应用非常广泛，经常用于WEB后端开发中存储应用数据。它是关系型数据库管理系统，将数据用表来管理，不同类别的数据保存在不同的表中，一个关系型数据库可以有多个表组成，并且表与表之间也可以有关系。


它基于客户机—服务器的数据库。客户机—服务器应用分为两个不同的部分。客户端程序，用于连接并操作Mysql服务器。服务器部分是负责所有数据访问和处理的一个软件。我们通常在 MySQL Client(Mysql客户端) 使用 mysql 命令连接到Mysql服务器上。

使用数据库管理系统的另一个好处是：管理数据很方便，可以使用结构化查询语言SQL(结构化查询语言)来操作数据库。

## 一些基本概念

**数据库与数据库管理系统**

数据库: 数据库就是用来存储，组织数据的仓库
数据库管理系统: 就是用来管理数据的软件

**结构化查询语言SQL**

SQL是结构化查询语言,是数据库专用的语言,所有的SQL类型的数据库基本都可以使用SQL语言来通信,且多数语法都相同

## ubuntu安装MySQL

很简单，一条命令就就够了

```
sudo apt-get install mysql-server
```

安装过程中会提示输入MySQL数据库的root用户的密码，这个命令会同时安装MySQL客户端和MySQL服务器

安装完成MySQL服务默认就是启动的，如果没有启动:

```
sudo service mysql start
```

## 连接到mysql数据库

我们可以在 MySQL Client(Mysql客户端) 使用 mysql 命令连接到Mysql服务器上

要连接mysql需要知道如下几个信息

1. 主机名: 本地系统中为`localhost`
2. 端口: 默认为3306,如更改过就必须加上此项
3. 用户名: 使用root
4. 密码: 就是安装的时候输入的(假设是`123456`)

然后执行:

```
mysql -u root -p123456     
```

要注意`-p`后面是没有空格的直接接密码,回车之后就说明连接成功

或者:

```
mysql -u -root -p
```
此命令回车之后，需要输入上面的密码，然后就连接成功

连接成功就会显示如下的界面:

![connected](http://7xo1su.com1.z0.glb.clouddn.com/connect.png)

## 一些简单的命令

在连接到MySQL服务器之后,会显示`mysq>` 这样的提示符，可以在这里执行SQL命令,可以输入`help`来查看帮助，下面说几个常用的命令,需要注意的是，在mysql中这些命令是不区分大小写的，但是我们通常为了能够跟我们自己输入的数据区分开，就将这些命令大写，自己输入的数据小写,并且命令后面需要加上分号。

**显示当前所有的数据库(Database)**

```
mysql> SHOW DATABASES;
```
回车之后，会显示当前有那些数据库,类似于下面这样,数据库可能没这么多

```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| dbcp_demo          |
| go_study           |
| mysql              |
| performance_schema |
| person_blog        |
| sys                |
| testjdbc           |
| wordpress          |
+--------------------+
9 rows in set (0.67 sec)
```

**创建一个新数据库**

```
mysql> CREATE DATABASE database_name;
```

这里的`database_name`是具体的数据库名称，应该使用小写，不同单词直接以下划线分隔

**选择要操作的数据库**

```
mysql> USE database_name;
```

`SHOW DATABASES`命令显示所有数据库都可以使用。选择了具体的要操作的数据库，就可以操作数据库中的表了

**显示当前数据库中的所有表**

```
mysql> SHOW TABLES;
```

关于数据库表的有关操作，下次在写

## 退出连接

```
mysql> quit;
```

回车后，即可回到终端中

## 关闭MySQL

在shell终端中输入:

```
sudo service mysql stop
```

未完待续...







