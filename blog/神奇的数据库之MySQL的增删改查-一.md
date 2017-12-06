author: me
title: 神奇的数据库之MySQL的增删改查(一)
date: 2017-04-19 13:24:12
tags: 
    - mysql
---


数据库是我们用来存储数据的地方，要存储数据，当然要学会怎样添加数据。不过在此之前，回顾一下前面创建数据库命令，这个很简单, 使用 `CREATE DATABASE dbname;` 即可创建一个名为 dbname 的数据库。

有了数据库，要真正存储我们的数据，就需要表了，这是SQL类数据库，用来组织数据的方式。我们就先来简单说说怎么创建表。

## 创建数据库表

先把语法贴出来:

```sql
create table tablename(
	列名1 类型 [修饰]
	列名2 类型 [修饰]
	...
)
```

我们看看下面这个表，我们就以这个表为例

```
+------+------+-----------------------------------+
| name | age  | description                       |
+------+------+-----------------------------------+
| John |   10 | My name is John, I'm 10 years old |
| Bob  |    2 | My name is BoB, I'm 2 years old   |
| Tom  |    5 | My name is Tom, I'm 5 years old   |
+------+------+-----------------------------------+
```

可以看到这里说的表分为上下两部分：

1. 上面的一部分是表头，其中的每个项代表的就是**列名**（用来代表着一列的数据）。
2. 下面的部分就是我们存储进去的数据，每一行就是一组数据

下面我们就以上面的表为例, 来创建：


```sql
create table users(
	name varchar(30) NOT NULL,
	age int,
	description varchar(100)
);
```

这里我们创建了三个字段 `name`,`age` 和 `description`; 其中 `name` 和 `description` 是 `varchar`类型，参数是限制的字符类型；age 是 int 数字类型。另外 name 字段我们还设置了用来修饰字段的 `NOT NULL`, 表示不能为空 

具体的字段类型，修饰什么的我们后面再说

## 插入数据

有了表，我们就可以开始存储数据了，我们先看看语法, 

```sql
insert into tablename(字段1, 字段2, ....) [values|value](字段值1, 字段值2, ....);
```

这里插入一条数据时，使用 values 和 value 是一样的，而插入多条数据时应该使用 values

如果想插入多条数据，语法很像:

```sql
insert into tablename(字段1, 字段2, ....) values(字段值1, 字段值2, ....), (字段值1, 字段值2, ....);
```

所以以上面的例子为例，我们来插入三条数据:

```sql
insert into users(name, age, description) value("John", 10, "My name is John, I'm 10 years old");
insert into users(name, age, description) value("Bob", 2, "My name is BoB, I'm 2 years old");
insert into users(name, age, description) value("Tom", 5, "My name is Tom, I'm 5 years old");


# 或者使用

insert into users(name, age, description) values("John", 10, "My name is John, I'm 10 years old"), 
				  									("Bob", 2, "My name is BoB, I'm 2 years old"),
				  									("Tom", 5, "My name is Tom, I'm 5 years old");
```

然后我们就可以使用 `select * from users` 来查看表中插入的数据了，就是最上面我们展示的表结构。


其实在Mysql 中，插入数据时 into 可以省略，并且字段名列表也可以省略，就像下面这样：

```sql
insert users value("Tom", 5, "My name is Tom, I'm 5 years old");
```

不过需要注意，如果使用这种方式，插入时必须包含所有字段，并且按照表中的字段排列顺序来排列我们插入的值。因此这种用法不常用。记住上面哪个就可以了
