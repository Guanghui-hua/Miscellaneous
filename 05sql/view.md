## VIEW

视图是从一个或多个表（视图）中导出来的表，它是一种虚拟存在的表，并且表的结构和数据都依赖于基本表。

优点：

1. 简化查询语句

   日常开发中我们可以将经常使用的查询定义为视图，从而使用户避免大量重复的操作。

2. 安全性

   通过视图用户只能查询和修改他们所能见到的数据，数据库中的其他数据则既看不到也取不到。

3. 逻辑数据独立性

   视图可以帮助用户屏蔽真实表结构变化带来的影响。

```sql
CREATE [OR REPLACE] [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}] VIEW view_name [(column_list)]
AS 
SELECT 查询语句
[WITH [CASCADE | LOCAL | CHECK OPTION] ];

# example
CREATE VIEW view_product 
	AS 
	SELECT * FROM product;

CREATE VIEW view_product2
	AS 
	SELECT product_ID, Product_Name, Product_Place, sort_ID FROM product;

CREATE VIEW sum_product
	AS 
	SELECT product_Place, COUNT(product_ID) FROM product
	GROUP BY product_place;

# 在多表中建立视图
CREATE VIEW view_sort_product
	AS 
	SELECT sort.sort_name, COUNT(product.product_ID)
	FROM product JOIN sort ON product.sort_ID = sort.sort_ID
	GROUP BY sort.sort_name;
	
# 在视图中重命名表中字段
CREATE VIEW sum_product2(product_place, num_product)
	AS
	SELECT product_place, COUNT(product_id) FROM product
	GROUP BY product_place;
	
# 重命名方法2
CREATE VIEW sum_product3(product_place, num_product)
	AS
	SELECT product_place, COUNT(product_id) AS num_product FROM product
	GROUP BY product_place;

```



### 如何查看视图

使用DESCRIBE语句可以查看视图的字段信息。

```sql
DESCRIBE view_name;
DESC view_name;
```

使用SHOW CREATE VIEW语句不仅可以查看创建视图时的定义语句，还可以查看视图的字符编码

```sql
SHOW CREATE VIEW view_name;
```

###  如何修改视图

1. 使用`CREATE OR REPLACE VIEW`语句修改视图

   ```sql
   CREATE [OR REPLACE ][ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
   VIEW view_name [(column_list)]
   AS SELECT_statement
   [WITH[CASCADED | LOCAL] CHECK OPTION]
   
   ```

   通过create or replace可以新建或者修改视图，如果修改的视图已存在，那么修改视图；如果视图不存在，则创建视图。

2. 使用`ALTER`语句修改视图

```sql
ALTER [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
VIEW view_name [(column_list)]
AS SELECT_statement
[WITH[CASCADED | LOCAL] CHECK OPTION]

```

注意：被修改的视图必须要存在数据库中

### 如何更新视图

> 尽管更新视图有多种方式，但是并非所有情况下都能执行视图的更新操作。当视图中包含有如下内容时，视图的更新操作将不能被执行：
>
> 视图中不包含基本表中被定义为非空的列。
>
> 在定义视图的SELECT语句后的字段列表中使用了数学表达式。
>
> 在定义视图的SELECT语句后的字段列表中使用聚合函数。
>
> 在定义视图的SELECT语句中使用了DISTINCT，UNION，TOP，GROUP BY或HAVING子句。

1. 使用`UPDATE`语句更新视图

   ```sql
   SET SQL_SAFE_UPDATES=0
   	UPDATE view_product
   	SET product_place="中国"
   	WHERE product_place="国产";
   	
   SELECT * FROM view_product WHERE product_place="中国";
   SELECT * FROM product WHERE product_place="中国";
   ```

   

2. 使用`DELETE`语句更新视图

   ```sql
   DELETE FROM view_product
   	WHERE product_name='3d打印机';	
   ```

   

3. 使用`INSERT`语句更新视图

   ```sql
   INSERT INTO view_product(product_ID, product_Name, product_Place)
   	VALUES('12345','3d打印机','上海');
   ```

### 删除视图

```sql
DROP VIEW 视图名称;

# example
DROP VIEW sum_product3;
```


