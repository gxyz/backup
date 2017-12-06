author: me
title: sae上使用mysql遇到的问题
date: 2017-12-01 10:07:28
tags:
    - sae
    - mysql
    - 问题
---

## mysql数据库问题
 
我在sae上部署自己写的flask应用时，有时会出现下面的问题:

```
OperationalError: (OperationalError) (2006, 'MySQL server has gone away') 'SELECT entry.id AS entry_id, entry.name AS entry_name, entry.description AS entry_description, entry.content AS entry_content, entry.created AS entry_created 
FROM entry 
WHERE entry.id = %s 
LIMIT %s' (3, 1)
```
 
## 解决方法
 
经过查询和尝试，找到了一种解决方案，代码如下：
 
```
class nullpool_SQLAlchemy(SQLAlchemy):
    def apply_driver_hacks(self, app, info, options):
        super(nullpool_SQLAlchemy, self).apply_driver_hacks(app, info, options)
        from sqlalchemy.pool import NullPool
        options['poolclass'] = NullPool
        del options['pool_size']
 
db = nullpool_SQLAlchemy()
```
 
**注意：**需要将`db=SQLAlchemy()`改为`db = nullpool_SQLAlchemy()`
