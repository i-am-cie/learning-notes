# SQL窗口函数笔记

## 基本语法

```sql
SELECT 
  column,
  ROW_NUMBER() OVER (PARTITION BY group_column ORDER BY order_column)
FROM table_name
```

## 常用函数

### ROW_NUMBER()

每行一个唯一编号，不管有没有重复。

### RANK() / DENSE_RANK()

- RANK()：并列会占位置（1,1,3）
- DENSE_RANK()：并列不占位置（1,1,2）

### SUM() OVER()

累计求和，比如按月累计销售额。

## 练习题

### 问题：查询每个部门工资第二高的员工

```sql
WITH ranked AS (
  SELECT 
    name,
    department,
    salary,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) as rk
  FROM employees
)
SELECT * FROM ranked WHERE rk = 2
```

## 踩过的坑

- 窗口函数是在WHERE之后执行的，所以不能在WHERE里直接用
- 要过滤窗口函数结果得用CTE或者子查询
