---
title: "Linux学习 用户和用户组管理"
date: 2017-9-23 16:16:57
tags:
    - Linux
---

在Linux系统中，提供了一些了的用户和组的操作命令(通常是给root用户和拥有root权限的用户使用的)，包括创建，删除和修改，实际上这些命令就是对 /etc/passwd、/etc/group 的增删改来实现的，另外还有两个用于管理用户和组的密码的文件 /etc/shadow和/etc/gshadow。

## /etc/passwd和/etc/group

- `/etc/passwd`用于保存系统中用户的基本信息
- `/etc/group` 用于保存系统中用户组的基本信息

/etc/passwd 文件内容，没一行主要包含七个字段分别表示为 `用户名:密码:UID:GID:用户全名:家目录:默认shell`, 其中需要注意的是密码这个字段，其实都是一个 x, 真正的密码在 /etc/shadow 中被管理。

```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
......
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-timesync:x:100:102:systemd Time Synchronization,,,:/run/systemd:/bin/false
......
```

/etc/group 中的文件内容，主要分为四个字段，分别表示: `组名:用户组密码:GID:用户组内的用户名`, 这里的用户组密码用于被管理在 /etc/gshadow 文件中，而且很少会使用到。

```
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
tty:x:5:
......
disk:x:6:
lp:x:7:
man:x:12:
proxy:x:13:
kmem:x:15:
......
```

## 添加用户

添加用户的命令主要有两个:

- adduser
- useradd

useradd 命令在各个Linux发行版中的功能相同，但是 adduser 有一些不同，因此最好了解 useradd 命令即可，最简单的使用方式如下:

```
useradd username
```

参数就是要创建的用户的用户名，那么这个命令会做什么呢? 其实系统在内部做了很多事情:

1. 分配一个独一无二的用户ID - UID
2. 添加一个与用户名相同的用户组，并为其分配一个独一无二的组ID - GID, 并将新用户添加到该用户组中
3. 为新用户创建家目录, 即/home/username.
4. 设置默认的 shell 为 /bin/bash

接下来就是设置密码了，使用这个命令创建用户时，并不会提示输入密码，因此需要另一个命令 passwd 来配合,为用户设置密码:

```
passwd username
```

此时系统会提示输入两次密码，如果两次一致，那么 username 用户的密码就被设置成功。

这个命令同样可以用来修改密码, 需要注意的是，默认只有 root 用户，或者拥有 root 权限的用户才可以修改其他用户的密码，因此普通用户只能修改自己的密码，此时 passwd 命令就可以不加参数。

## 修改用户配置

使用 usermod 命令可以用来修改用户名，用户默认的shell等等

## 删除用户

想要删除某个用户，可以使用 userdel 命令，后面参数为用户名。如果加了 -r 选项可以将用户的家目录一起删除.

## 用户组的添加、修改和删除

对用户组的操作与对用户的操作是很像的，因此命令的名字也很相像，分别为groupadd、gpasswd、groupmod和groupdel。

## 临时提升用户的权限

在使用 ubuntu 的时候，我们默认创建的用户并不是 root用户，因此在日常使用的时候，也并不会直接使用 root 用户，这就有一个问题，有时候我们需要访问和操作一些普通用户做不了的事情。比如说安装一些软件，查看一些文件，因此就出现了一个东西叫做 sudo, 我们在使用在使用 ubuntu 时，经常会在安装软件的命令之前加上一个 sudo，这个 sudo 可以说就是用来申请临时 root 权限的，或者称为 sudo 权限。

此时如果会提示你输入当前用户的密码，如果你拥有 sudo 权限，那么你就可以正常的使用一些 root 用户才可以使用的命令。

有一些发行版在安装系统时创建的用户默认是用于 sudo 权限的，但也有一些发行版，创建的用户是没有 sudo 权限的，此时就需要 root 用户来指定，否则该用户就无法拥有sudo权限。
给用户添加sudo权限的方法

要想给某个用户添加 sudo 权限，很简单，只需要 root 用户或者已经拥有 sudo 权限的用户修改一些 /etc/sudoers 这个文件就行, 文件基本内容如下:

```
Defaults    env_reset
Defaults    mail_badpass
Defaults    secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
# Host alias specification
# User alias specification
# Cmnd alias specification
# User privilege specification
root    ALL=(ALL:ALL) ALL
# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
# See sudoers(5) for more information on "#include" directives:
#includedir /etc/sudoers.d
```

可以看到其中有一行:

```
root    ALL=(ALL:ALL) ALL
```

这条命令就是说 root 用户可以使用 sudo 特权(其实是废话，root用户无所不能)。所以想要给用户添加 sudo 权限，只需添加一行

```
username  ALL=(ALL:ALL) ALL
```

此时 username 用户就拥有了 sudo 权限。此外还用一种方法可以给整个用户组中的用户添加 sudo 权限:

```
%group   ALL=(ALL:ALL) ALL
```

另外还可以精准的控制用户可以只需的命令,可以在 ALL= 后面跟用户可以执行的命令，多个命令之间使用逗号分割，并且必须使用绝对路径而非相对路径。还可以在命令前加上 ! 来排除这个命令.

## 临时切换用户

在每条命令前面都加 sudo, 势必会造成很多不方便的地方，此时我们可以使用 su 命令来临时切换用户为 root 用户(当然这个命令也可以切换到其它用户，不过root是默认的).

通常有两种用法:

- `su username`: 切换到 username 用户，但是不改变当前所在目录
- `su - username`: 切换的 username 用户，并且切换目录到　username 用户的家目录下

此外使用 exit 可以切换回之前用户
