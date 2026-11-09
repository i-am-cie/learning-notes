# 链表笔记

## 单链表

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
```

## 常见操作

### 反转链表

```python
def reverse_list(head):
    prev = None
    curr = head
    while curr:
        next_node = curr.next
        curr.next = prev
        prev = curr
        curr = next_node
    return prev
```

### 找中间节点

快慢指针：快的走两步，慢的走一步，快的到末尾慢的就在中间。

### 环检测

还是快慢指针，如果快的能追上慢的就说明有环。

## 容易忘的点

- 插入删除要记得保存next指针，别搞丢了
- 虚拟头节点（dummy head）可以简化边界条件处理
- 递归写链表有时候比迭代好懂
