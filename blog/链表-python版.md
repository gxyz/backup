author: me
title: 链表(python版)
date: 2016-12-21 23:26:31
tags: 
    - python
---


用链接关系来表示元素之间的顺序关联，这种方式实现的线性表就是链表。

<!-- more -->

由于要实现链接关系，所以链表中的一个节点需要存储自身的数据，还有下一个节点的链接。所以需要定义一个节点的类型:


```python
class LinkedNode:

    def __init__(self, data, next_node=None):
        self.data = data
        self.next = next_node

```

下面是链表的具体实现：


```python
# coding:utf-8

# 自定义异常
class LinkedListUnderflow(ValueError):
    pass


class LinkedList:
    '''
        链表类
        主要实现的操作有：判空，前端添加和删除元素，后端添加和删除元素，指定位置添加，链表反转等
    '''


    def __init__(self):
        self.head = None

    # 判空
    def is_empty(self):
        return self.head is None

    # 前端添加元素:O(1)
    def prepend(self, data):
        self.head = LinkedNode(data, self.head)

    # 尾部添加元素: O(n)
    def append(self, data):
        if self.is_empty():
            self.head = LinkedNode(data)
            return
        current = self.head
        while current.next is not None:
            current = current.next
        current.next = LinkedNode(data)

    # 前端删除:O(1)
    def lpop(self):
        if self.is_empty():
            raise LinkedException("in lpop")
        elem = self.head.data
        self.head = self.head.next
        return elem

    # 后端删除:O(n)
    def rpop(self):
        if self.is_empty():
            raise LinkedException("in rpop")
        if self.head.next is None:
            elem = self.head.data
            self.head = None
            return elem
        current = self.head
        while current.next.next is not None:
            current = current.next
        elem = current.next.data
        current.next = None
        return elem

    # 指定位置插入:O(index)
    def insert(self, index, data):
        clen = self.length()
        if index < 0 or index > clen - 1:
            raise LinkedException("in insert")
        current = self.head
        for i in range(1, index):
            current = current.next
        current.next = LinkedNode(data, current.next)

    # 循环输出链表的元素: O(n)
    def foreach(self):
        p = self.head
        while p is not None:
            print p.data,
            p = p.next
        print ''

    # 返回遍历链表元素的生成器：O(n)
    def range(self):
        p = self.head
        while p.next is not None:
            yield p.data
            p = p.next

    # 反转链表:O(n)
    def reverse(self):
        if self.head is None and self.head.next is None:
            return self.head
        current = self.head
        while current.next is not None:
            next_node = current.next
            next_next_node = next_node.next
            next_node.next = self.head
            self.head = next_node
            current.next = next_next_node

    # 求链表的长度:O(n)
    def length(self):
        current = self.head
        n = 0
        while current is not None:
            current = current.next
            n += 1
        return n

# 简单的测试
if __name__ == "__main__":
    li = LinkedList()
    li.prepend(190)
    li.prepend(20)
    li.append(10)
    li.append(20)
    li.append(30)
    li.append(40)
    li.insert(3, 70)
    li.foreach()
    li.reverse()
    li.foreach()
    print(li.length())
    li.rpop()
    li.rpop()
    li.foreach()
    print(li.length())
    li.lpop()
    li.lpop()
    li.foreach()
    print(li.length())

```


输出结果:

```
20 190 10 70 20 30 40
40 30 20 70 10 190 20
7
40 30 20 70 10
5
20 70 10
3
```

上面看到，求长度的操作还需要O(n)时间复杂度，其实只需小小的改进就可以变为O(1)时间,就是让链表的头部也成为一个节点，其中的data就放链表当前的长度，每次添加和删除元素，维护头节点中的长度即可

```python
# coding:utf-8

class LinkedListUnderflow(ValueError):
    pass

class LinkedNode:

    def __init__(self, data, next=None):
        self.data = data
        self.next = next


class LinkedList:

    def __init__(self):
        # 这里将指针也是用LinkedNode表示，其中data表示链表的长度
        self._head = LinkedNode(0, None)

    def length(self):
        return self._head.data

    def is_empty(self):
        return self.length() == 0

    def prepend(self, data):
        self._head.next = LinkedNode(data, self._head.next)
        self._head.data += 1

    def pop(self):
        if self.is_empty():
            raise LinkedListUnderflow("LinkedList is empty(in pop)")
        elem = self._head.next.data
        self._head.next = self._head.next.next
        self._head.data -= 1
        return elem

    def append(self, data):
        if self.length() == 0:
            self._head.next = LinkedNode(data)
            self._head.data += 1
            print "***"
            return

        current = self._head.next
        while current.next is not None:
            current = current.next
        current.next = LinkedNode(data)
        self._head.data += 1

    def pop_last(self):
        if self.is_empty():
            raise LinkedListUnderflow("LinkedList is empty(in pop_last)")
        current = self._head.next
        if current.next is None:
            elem = current.data
            self._head.next = None
            self._head.data -= 1
            return elem
        while current.next.next is not None:
            current = current.next
        elem = current.next.data
        current.next = None
        self._head.data -= 1
        return elem

    def foreach(self):
        current = self._head.next
        i = 0
        while current is not None:
            print "第%d个元素: %d" % (i, current.data)
            current = current.next
            i += 1


    def insert(self, index, data):
        if index >= self.length():
            raise LinkedListUnderflow("index out of range (in insert)")
        current = self._head.next
        for i in range(0, index-1):
            current = current.next
        current.next = LinkedNode(data, current.next)
        self._head.data += 1

    def reverse(self):
        current = self._head.next
        if current == None or current.next == None:
            return self._head

        while current.next != None:
            next_node = current.next
            next_next_node = next_node.next
            next_node.next = self._head.next
            self._head.next = next_node
            current.next = next_next_node

    def find_last_nth_elem(self, n):
        if n <= 0 or n > self.length():
            raise LinkedListUnderflow("LinkedList is is too short (in find_last_nth_elem)")
        first = self._head.next
        second = self._head.next

        for i in range(1, n):
            first = first.next

        while first.next is not None:
            first = first.next
            second = second.next
        print second.data

# 测试
if __name__=="__main__":
    link = LinkedList()
    link.append(1)
    link.append(2)
    link.append(3)
    link.append(4)
    link.append(5)
    link.append(6)
    link.append(7)
    link.append(8)
    link.append(9)
    link.foreach()
    print "---------"
    link.reverse()
    link.foreach()
    link.find_last_nth_elem(1)

```


输出结果:

```
第0个元素: 1
第1个元素: 2
第2个元素: 3
第3个元素: 4
第4个元素: 5
第5个元素: 6
第6个元素: 7
第7个元素: 8
第8个元素: 9
---------
第0个元素: 9
第1个元素: 8
第2个元素: 7
第3个元素: 6
第4个元素: 5
第5个元素: 4
第6个元素: 3
第7个元素: 2
第8个元素: 1
1
```

