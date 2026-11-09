# Python装饰器笔记

## 什么是装饰器

就是一个函数，接收另一个函数作为参数，返回一个新函数。

## 最简单的例子

```python
def my_decorator(func):
    def wrapper():
        print("函数调用前")
        func()
        print("函数调用后")
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")
```

## 带参数的装饰器

```python
def repeat(times):
    def decorator(func):
        def wrapper(*args, **kwargs):
            for _ in range(times):
                result = func(*args, **kwargs)
            return result
        return wrapper
    return decorator

@repeat(times=3)
def greet(name):
    print(f"Hello {name}")
```

## 常用场景

- 计时：计算函数运行时间
- 日志：打印函数调用信息
- 权限检查
- 缓存（functools.lru_cache）

## 注意点

- 记得用 functools.wraps 保留原函数的元信息
- 带参数的装饰器要多套一层
