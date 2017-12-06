author: me
title: python2.7安装mysql-python出错
date: 2017-11-29 20:27:42
tags: 
    - python
    - mysql
---

# python2.7安装mysql-python出错

在ubuntu16.04上安装mysql-python时出现一下问题:

```
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-build-z1YL7h/MySQL-python/setup.py", line 17, in <module>
        metadata, options = get_config()
      File "setup_posix.py", line 43, in get_config
        libs = mysql_config("libs_r")
      File "setup_posix.py", line 25, in mysql_config
        raise EnvironmentError("%s not found" % (mysql_config.path,))
    EnvironmentError: mysql_config not found
```

解决办法:

```
sudo apt-get install libmysqlclient-dev
```

