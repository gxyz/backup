author: me
title: 使用Python解析结构化的文本
date: 2017-09-03 15:26:36
tags:
    - python
---

什么是结构化的文本，结构化的文本就是指有特定格式和组织结构的文本数据，我们在编写程序时，经常会接触到这类文本数据，比如: XML, JSON, YAML, 配置文件等等. 本文就记录一些解析各种结构化文本的方式。

## CSV

带分隔符的文件一般用作数据交换格式或者数据库。你可以人工读入 CSV 文件,每一次读取一行,在逗号分隔符处将每行分开,并添加结果到某些数据结构中,例如列表或者字典。但是,最好使用标准的 csv 模块,因为这样切分会得到更加复杂的信息。

```python
v = [['Doctor', 'No'],
 ['Rosa', 'Klebb'],
 ['Mister', 'Big'],
 ['Auric', 'Goldfinger'],
 ['Ernst', 'Blofeld']]

with open('v1', 'wt') as f:
    csvout = csv.writer(f)
    csvout.writerows(v)

with open('v1', 'r') as f:
    cin = csv.reader(f)
    vv = [row for row in cin]

>>> vv
[['Doctor', 'No'],
 ['Rosa', 'Klebb'],
 ['Mister', 'Big'],
 ['Auric', 'Goldfinger'],
 ['Ernst', 'Blofeld']]
```

- 除了逗号,还有其他可代替的分隔符: '|' 和 '\t' 很常见。
- 有些数据会有转义字符序列,如果分隔符出现在一块区域内,则整块都要加上引号或者在它之前加上转义字符。
- 文件可能有不同的换行符,Unix 系统的文件使用 '\n' ,Microsoft 使用 '\r\n' ,Apple之前使用 '\r' 而现在使用 '\n' 。
- 在第一行可以加上列名。

使用 reader() 和 writer() 的默认操作。每一列用逗号分开;每一行用换行符分开。

数据可以是字典的集合(a list of dictionary), 不仅仅是列表的集合(a list of list)。这次使用新函数 DictReader() 读取文件 villains,并且指定每一列的名字。

```python
>>> with open('v1', 'r') as f:
...:     cin = csv.DictReader(f, fieldnames=["first", "last"])
...:     print(cin)
...:     vvv = [row for row in cin]

[{'first': 'Doctor', 'last': 'No'},
 {'first': 'Rosa', 'last': 'Klebb'},
 {'first': 'Mister', 'last': 'Big'},
 {'first': 'Auric', 'last': 'Goldfinger'},
 {'first': 'Ernst', 'last': 'Blofeld'}]  
```

下面使用新函数 DictWriter() 重写 CSV 文件,同时调用 writeheader() 向 CSV 文件中第一行写入每一列的名字:

```python
>>> with open('v2', 'w') as f:
...:     cout = csv.DictWriter(f, ['first', 'last'])
...:     cout.writeheader()
...:     cout.writerows(vvv)
```

v2 文件的内容为:

```
first,last
Doctor,No
Rosa,Klebb
Mister,Big
Auric,Goldfinger
Ernst,Blofeld
```

回过来再读取写入的文件,忽略函数 DictReader() 调用的参数 fieldnames ,把第一行的值( first,last )作为列标签,和字典的键做匹配。

```python
>>> import csv
>>> with open('villains', 'rt') as fin:
...
cin = csv.DictReader(fin)
...
villains = [row for row in cin]
...
>>> print(villains)
[{'last': 'No', 'first': 'Doctor'},
{'last': 'Klebb', 'first': 'Rosa'},
{'last': 'Big', 'first': 'Mister'},
{'last': 'Goldfinger', 'first': 'Auric'},
{'last': 'Blofeld', 'first': 'Ernst'}]
```

## XML

带分隔符的文件仅有两维的数据: 行和列。如果你想在程序之间交换数据结构,需要一种方法把层次结构、序列、集合和其他的结构编码成文本。XML 使用标签(tag)分隔数据。

例子: menu.xml

```xml
<?xml version="1.0"?>
<menu>
    <breakfast hours="7-11">
        <item price="$6.00">breakfast burritos</item>
        <item price="$4.00">pancakes</item>
    </breakfast>
    <lunch hours="11-3">
        <item price="$5.00">hamburger</item>
    </lunch>
    <dinner hours="3-10">
        <item price="8.00">spaghetti</item>
    </dinner>
</menu>
```

XML 数据的特点:

- 标签以一个 < 字符开头,例如示例中的标签 menu 、 breakfast 、 lunch 、 dinner 和 item ;
- 忽略空格;
- 通常一个开始标签(例如 <menu> )跟一段其他的内容,然后是最后相匹配的结束标签,例如 </menu> ;
- 标签之间是可以存在多级嵌套的,在本例中,标签 item 是标签 breakfast 、 lunch 和dinner 的子标签,反过来,它们也是标签 menu 的子标签;
- 可选属性(attribute)可以出现在开始标签里,例如 price 是 item 的一个属性;,本例中每个 item 都会有一个值,比如第二个 breakfast item
- 标签中可以包含值(value)的 pancakes;
- 如果一个命名为 thing 的标签没有内容或者子标签,它可以用一个在右尖括号的前面添加斜杠的简单标签所表示,例如 <thing/> 代替开始和结束都存在的标签 <thing> 和 </thing> ;
- 存放数据的位置可以是任意的——属性、值或者子标签。例如也可以把最后一个 item标签写作 <item price ="$8.00" food ="spaghetti"/> 。


XML 通常用于数据传送和消息,它存在一些子格式,如 RSS 和 Atom。工业界有许多定制化的 XML 格式,

在 Python 中解析 XML 最简单的方法是使用 ElementTree。

```
>>> for child in root:
...:     print("tag:", child.tag, 'attributes:', child.attrib)
...:     for grandchild in child:
...:         print("\ttag:", grandchild.tag, 'attributes:', grandchild.attrib)
...:         

tag: breakfast attributes: {'hours': '7-11'}
	tag: item attributes: {'price': '$6.00'}
	tag: item attributes: {'price': '$4.00'}
tag: lunch attributes: {'hours': '11-3'}
	tag: item attributes: {'price': '$5.00'}
tag: dinner attributes: {'hours': '3-10'}
	tag: item attributes: {'price': '8.00'}

```

对于嵌套列表中的每一个元素, tag是标签字符串, attrib是它属性的一个字典。ElementTree 有许多查找 XML 导出数据、修改数据乃至写入 XML 文件的方法,它的文档(https://docs.python.org/3.3/library/xml.etree.elementtree.html)中有详细的介绍。

其他标准的 Python XML 库如下。

- xml.dom
    JavaScript 开发者比较熟悉的文档对象模型(DOM)将 Web 文档表示成层次结构,它会把整个 XML 文件载入到内存中,同样允许你获取所有的内容。

- xml.sax
    简单的 XML API 或者 SAX 都是通过在线解析 XML,不需要一次载入所有内容到内存中,因此对于处理巨大的 XML 文件流是一个很好的选择。

## JSON

JavaScript Object Notation(JSON,http://www.json.org)是源于 JavaScript 的当今很流行的数据交换格式,它是 JavaScript 语言的一个子集,也是 Python 合法可支持的语法。

Python 有一个解析 json 数据的模块，名字就叫做 json


```
>>> menu = {'breakfast': {'hours': '7-11',
  'items': {'breakfast burritos': '$6.00', 'pancakes': '$4.00'}},
 'dinner': {'hours': '3-10', 'items': {'spaghetti': '$8.00'}},
 'lunch': {'hours': '11-3', 'items': {'hamburger': '$5.00'}}}

>>> import json
>>> menu_json = json.dumps(menu)
>>> menu_json
'{"dinner": {"items": {"spaghetti": "$8.00"}, "hours": "3-10"},
"lunch": {"items": {"hamburger": "$5.00"}, "hours": "11-3"},
"breakfast": {"items": {"breakfast burritos": "$6.00", "pancakes":
"$4.00"}, "hours": "7-11"}}'

>>> menu2 = json.loads(menu_json)
>>> menu2
{'breakfast': {'items': {'breakfast burritos': '$6.00', 'pancakes':
'$4.00'}, 'hours': '7-11'}, 'lunch': {'items': {'hamburger': '$5.00'},
'hours': '11-3'}, 'dinner': {'items': {'spaghetti': '$8.00'}, 'hours': '3-10'}}
```

可能会在编码或者解析 JSON 对象时得到异常,包括对象的时间 datetime

```
>>> import datetime
>>> now = datetime.datetime.utcnow()
>>> now
datetime.datetime(2013, 2, 22, 3, 49, 27, 483336)
>>> json.dumps(now)
Traceback (most recent call last):
# ...... (删除栈跟踪以保存树)
TypeError: datetime.datetime(2013, 2, 22, 3, 49, 27, 483336) is not JSON serializable
```

上述错误发生是因为标准 JSON 没有定义日期或者时间类型,需要自定义处理方式。你可以把 datetime 转换成 JSON 能够理解的类型,比如字符串或者 epoch 值。

## YAML

和 JSON 类似， YAML（ http://www.yaml.org）同样有键和值，但主要用来处理日期和时间这样的数据类型。 

标准的 Python 库没有处理 YAML 的模块，因此需要安装第三方库 yaml, load() 将 YAML 字符串转换为 Python 数据结构，而 dump() 正好相反。

例子: mcintyre.yaml

```yaml
name:
    first: James
    last: McIntyre
dates:
    birth: 1828-05-25
    death: 1906-03-21
details:
    bearded: true
    themes: [cheese, Canada]
books:
    url: http://www.gutenberg.org/files/36068/36068-h/36068-h.htm
poems:
    - title: 'Motto'
      text: | 
        Politeness, perseverance and pluck,To their possessor will bring good luck.
    - title: 'Canadian Charms'
      text: | 
        Here industry is not in vain,For we have bounteous crops of grain,And you behold on every field Of grass and roots abundant yield,But after all the greatest charmIs the snug home upon the farm,And stone walls now keep cattle warm.
```


PyYAML 可以从字符串中载入 Python 对象，但这样做是不安全的。如果导入你不信任的 YAML， 使用 safe_load() 代替 load()。


## 配置文件

许多程序提供多种选项和设置。动态的设置可以通过传入程序参数， 但是持久的参数需要保存下来。在程序中配置文件可以有许多好的选择，包括之前几节中提到的格式。

我们使用标准 configparser 模块处理 Windows 风格的初始化 .ini 文件。这些文件都包含key = value 的定义，以下是一个简单的配置文件 settings.cfg 例子：

例子: settings.cfg

```cfg
[english]
gretting = Hello

[french]
greeting = Bonjour

[files]
home = /usr/local
bin = %(home)s/bin  # 简单的插入
```

其他操作包括自定义修改也是可以实现的，请参阅文档 configparser（ https://docs.python.org/3.3/library/configparser.html）。如果你需要两层以上的嵌套结构，使用 YAML 或者 JSON。

```python
>>> import configparser
>>> cfg = configparser.ConfigParser()
>>> cfg.read('settings.cfg')
['settings.cfg']
>>> cfg
<configparser.ConfigParser object at 0x1006be4d0>
>>> cfg['french']
<Section: french>
>>> cfg['french']['greeting']
'Bonjour'
>>> cfg['files']['bin']
'/usr/local/bin'
```

## 使用 pickle 序列化

存储数据结构到一个文件中也称为序列化（ serializing）。像 JSON 这样的格式需要定制的序列化数据的转换器。 Python 提供了 pickle 模块以特殊的二进制格式保存和恢复数据对象。

```python
>>> import pickle
>>> import datetime
>>> now1 = datetime.datetime.utcnow()
>>> pickled = pickle.dumps(now1)
>>> now2 = pickle.loads(pickled)
>>> now1
datetime.datetime(2014, 6, 22, 23, 24, 19, 195722)
>>> now2
datetime.datetime(2014, 6, 22, 23, 24, 19, 195722)
```

pickle 同样也适用于自己定义的类和对象。现在，我们定义一个简单的类 Tiny，当其对象强制转换为字符串时会返回 'tiny'：

```python
>>> import pickle
>>> class Tiny():
...     def __str__(self):
...         return 'tiny'
...
>>> obj1 = Tiny()
>>> obj1
<__main__.Tiny object at 0x10076ed10>
>>> str(obj1)
'tiny'
>>> pickled = pickle.dumps(obj1)
>>> pickled
b'\x80\x03c__main__\nTiny\nq\x00)\x81q\x01.'
>>> obj2 = pickle.loads(pickled)
>>> obj2
<__main__.Tiny object at 0x10076e550>
>>> str(obj2)
'tiny
```

pickled 是从对象 obj1 转换来的序列化二进制字符串。然后再把字符串还原成对象 obj1 的副本 obj2。使用函数 dump() 序列化数据到文件，而函数 load() 用作反序列化。
