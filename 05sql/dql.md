# Data Query Language

```sql
SELECT [DISTINCT] fieldName1, filedName2,...
		FROM tableName
		WHERE conditional expression 1
		GROUP BY fieldName HAVING conditional expression 2
		ORDER BY fieldName [ASC|DESC]
		LIMIT [OFFSET] record numbers
		;
```

`DINSTINCT` is an optional parameter to reject duplicate data in the query result.
`GROUP BY` is also an optional parameter  to group the query results by the specified fields. `HAVING` is also an optional parameter to filter the results after grouping.
`ORDER ` is an optional parameter to sort the query results by the specified fields, the sorting method is controlled by the parameter ASC or DESC.

The most common SELECT statement is to use the WHERE clause to specify query conditions, and there are eight types of queries with the WHERE clause.

### query with relational operators to filter the data ----filter the data

```sql

SELECT * FROM product WHERE Product_Place = '天津';

SELECT * FROM product WHERE Product_Name = '京瓷KM-4030复印机`;

SELECT * FROM Product_ID, Product_Name FROM product WHERE Price >= 1000;

```

### query with `IN` keyword

```sql

SELECT * FROM product WHERE Product_Place in ('天津','日本','北京');

```

### query with  `BETWEEN ... AND ...` keyword

```sql

SELECT * FROM product WHERE Price BETWEEN 200 AND 500;

```

### query with `NULL` `DISTINCT`

```sql

SELECT Product_Name, Price FROM product WHERE Product_Place IS NULL;
SELECT Product_Name, Price FROM product WHERE Prodcut_Place IS NOT NULL;

SELECT DISTINCT Product_Place FROM product;
SELECT DISTINCT Sort_ID, SubSort_ID FROM product;

```


### query with `LIKE` and `matching strings`

```sql

SELECT Product_ID, Product_Name, Price FROM product WHERE Product_Name LIKE '%复印机%';
SELECT Product_ID, Product_Name, Price FROM product WHERE Product_Name LIKE '______复印机';
SELECT Product_ID, Product_Name, Price FROM product WHERE Product_Name LIKE '%\_%'；

```

## search by condition


```sql

SELECT * FROM product WHERE Product_Name LIKE '%_复印机' AND Product_Place='天津';
SELECT * FROM product WHERE Product_Name LIKE '%复印机' OR Product_Name LIKE '%过胶机';

```

`AND` has higher priority than `OR`

```sql

SELECT * FROM product WEHRE Product_Name LIKE '%复印机' AND Product_Place = '北京' OR Prodcut_Place LIKE '%过胶机' AND Product_Place = '北京';

```

## Advanced Query

### Commonly used aggregation functions

```sql

SELECT AVG(Price) FROM product;
SELECT MAX(Price) FROM product;
SELECT MIN(Price) FROM product;
SELECT COUNT(*) FROM product;

SELECT * FROM product WHERE Product_Name LIKE '%理光%墨粉%' ORDER BY Price DESC;

```

### Use `group by` to group field values for queries

```sql

SELECT * FROM product WHERE Product_Name LIKE '%理光%墨粉%' GROUP BY Product_Place;
```
Three usage cases of `GROUP BY`

1. Use `group by` alone
2. `group by` is used in conjunction with the aggregation function
3. `group by` is used together with `HAVING` 
Both HAVING and WHERE are used to set conditions to filter the query results. The difference between the two is that HAVING can be followed by an aggregate function, while WHERE cannot.

example:

1. Calculate the maximum unit price（单位商品） of products of different origins according to the product table, and sort them in descending order by Product_ID

```sql
SELECT Product_Place, MAX(Price) FROM product GROUP BY Product_Place ORDER BY Product_ID DESC;
```

2. Calculate the maximum unit price of goods from different places of origin according to the product table, and display the place of origin and the maximum unit price of products with the maximum unit price greater than 5000 yuan.

```sql
SELECT MAX(price), Product_Place FROM product GROUP BY Product_Place HAVING MAX(price)>5000; 
```

### the difference between `HAVING` and `WHERE` in advanced query

```sql
SELECT MAX(price), Product_Place FROM product WHERE price > 5000 GROUP BY Product_Place ;  
SELECT MAX(price), Product_Place FROM product GROUP BY Product_Place HAVING MAX(price) > 5000;
```
The result of executing the above two statements is the same!

Cautions:

`SELECT price, Product_Place FROM product WHERE price > 5000 GROUP BY Product_Place;` will report ERRORS ! 
> ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'purchase.product.Price' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

reasons:

> 使用 GROUP BY 语句违背了sql_mode=only_full_group_by。因为 mysql 版本5.7之后默认的模式是ONLY_FULL_GROUP_BY
> 大概意思是说：拒绝选择列表、HAVING 条件或 ORDER BY 列表引用非聚合列的查询，这些列既不在 GROUP BY 子句中命名，也不在功能上依赖于（唯一确定的）GROUP BY 列。

example:

Calculate the average unit price of goods with different Sub_Sort_ID. List the top 10 records.

```sql
 SELECT SubSort_ID, AVG(price) FROM product GROUP BY SubSort_ID LIMIT 10;
```



## Aliases for tables and fields

How to alias a table in mysql?

```sql
SELECT * FROM tableName [AS] alias;
```

attention: **`AS` can be omitted.**

example: Give the table product an alias Tb_Pro

 ```sql
 SELECT * FROM product Tb_Pro;
 ```

**The same goes for aliasing fields**



## Foreign Key constraint

外键（Foreign Key）是约束的一种，是指引用另一个表中的一列或多列，被引用的列应该具有主键约束或唯一性约束。

外键用于建立和加强两个表数据之间的链接。

简单来讲，如果一个表的某个字段的数据必须来源于另一个表的主键，那么要在这个字段上建立外键。

外键字段所在的表为从表（子表），被引用的表为主表（父表）。



### Primary key and foreign key

|                     | primary key                  | foreign key                                                |
| ------------------- | ---------------------------- | ---------------------------------------------------------- |
| definition          | 唯一标识，不能重复，不能为空 | 表的外键可以是另一张表的主键，外键可以有重复的，可以是空值 |
| effect              | 用来保证数据完整性           | 用来和其他表建立联系                                       |
| quantity in a table | 主键只能有一个               | 一张表可以有多个外键                                       |

引入外键后，外键列只能插入参照列存在的值，**参照列被参照的值不能被删除**，这就保证了数据的参照完整性。

想要真正连接两个表的数据，就需要为表添加外键约束

cautions:

(1)建立外键的表必须是InnoDB型的表，不能是临时表。因为MySQL中只有InnoDB型的表才支持外键。

(2)定义外键名时，不能加引号。如：constraint 'FK_ID' 或 constraint " FK_ID "都是错误的。



什么是数据库引擎？

MyISAM存储引擎：不支持事务、也不支持外键，优势是访问速度快，对事务完整性没有 要求或者以select，insert为主的应用基本上可以用这个引擎来创建表

InnoDB存储引擎：该存储引擎提供了具有提交、回滚和崩溃恢复能力的事务安全。但是对比MyISAM引擎，写的处理效率会差一些，并且会占用更多的磁盘空间以保留数据和索引。 InnoDB存储引擎的特点：支持自动增长列，支持外键约束

MEMORY存储引擎：Memory存储引擎使用存在于内存中的内容来创建表。每个memory表只实际对应一个磁盘文件，格式是.frm。memory类型的表访问非常的快，因为它的数据是放在内存中的，并且默认使用HASH索引，但是一旦服务关闭，表中的数据就会丢失掉。

MERGE存储引擎：Merge存储引擎是一组MyISAM表的组合，这些MyISAM表必须结构完全相同，merge表本身并没有数据，对merge类型的表可以进行查询，更新，删除操作，这些操作实际上是对内部的MyISAM表进行的。

example:

分析表product和sort可以发现，表product中的Sort_ID字段取值应引用于表sort中的Sort_ID字段，因此为product表的Sort_ID字段添加外键约束。

```sql
# 首先，被引用的主表字段应该是主键，因此需为sort表的Sort_ID字段添加主键约束，具体语句如下：
ALTER TABLE Sort MODIFY Sort_ID char(2) PRIMARY KEY;
# 为表product 的Sort_ID 字段添加外键约束
ALTER TABLE Product ADD CONSTRAINT FK_Sortid FOREIGN KEY(Sort_ID) REFERENCES Sort(Sort_ID);
```

### Add parameter description of foreign key constraint

如果从表试图创建一个在主表中不存在的外键值，MySQL会拒绝任何INSERT或UPDATE操作。

我们知道建立外键是为了保证数据的完整和统一性，即主表和从表中对应的数据保持统一，可以在建立外键时添加ON DELETE或ON UPDATE子句。

如果主表试图DELETE或者UPDATE任何从表中存在或匹配的外键值，最终动作取决于外键约束定义中的ON DELETE和ON UPDATE选项。 

```sql
ALTER TABLE 表名 ADD CONSTRAINT [外键名]
	FOREIGN KEY(外键字段名) REFERENCES 外表表名(主键字段名)
	[ON DELETE {CASCADE|SET NULL|NO ACTION|RESTRICT}];
	
ALTER TABLE 表名 ADD CONSTRAINT [外键名]
	FOREIGN KEY(外键字段名) REFERENCES 外表表名(主键字段名)
	[ON UPDATE {CASCADE|SET NULL|NO ACTION|RESTRICT}];
```

| 参数名称 | 功能描述 |
|---------|--------|
|CASCADE  |主表中删除或更新对应的记录时，同时自动地删除或更新从表中匹配的记录。	  |
|SET NULL |主表中删除或更新对应的记录时，同时将从表中的外键列设为空。	|
|NO ACTION |拒绝删除或者更新主表，从表也不进行任何操作。	|
|RESTRICT |拒绝主表删除或修改**外键关联列**(在不定义ON DELETE 和ON UPDATE子句时，这是默认设置，也是最安全的设置)	|

### Delete foreign key constraints

```sql
ALTER TABLE 表名 DROP FOREIGN KEY 外键名;
```

example: `ALTER TABLE product DROP FOREIGN KEY FK_sortid;`

## 操作关联表

### 数据表之间的关联关系

1. 一对一

   一对一的对应关系中，需要分清主从关系，**通常在从表中建立外键。**

2. 多对一

   一个部门可以有多个员工，而一个员工不能属于多个部门。

   **在多对一的表关系中，应该将外键建在多的一方。**

3. 多对多

   一个老师可以教多个学生，同时一个学生可以上多个老师的课程。

   **为了实现数据表多对多的关系，需要定义一张第三方中间表（连接表），该表保存两个关系表的外键。**



在开发中，最常见的关联关系就是多对一关系

### 为关联表添加数据

为表product和表sort中添加外键约束来建立两个表的关联关系之后，为product表添加一条记录，这条记录的Sort_ID字段值只能插入参照列存在的值，即sort表中Sort_ID字段值的一个。

如果尝试向product表的Sort_ID字段添加其他值则会发生错误。

此时，如果要为关联的两个表添加数据，首先应先为**主表**（此例中为primary key所在的表即sort表）添加数据。因此，如果要向product表添加Sort_ID为99的数据，则应先向主表sort添加Sort_ID为99的数据，再向product表执行操作。

```sql
# 未添加外键约束之前插入数据，不会报错
INSERT INTO product(Product_ID, Sort_ID) VALUES(9999,99);

# 添加外键约束
ALTER TABLE product ADD CONSTRAINT FK_sortid FOREIGN KEY(Sort_ID) REFERENCES sort(Sort_ID);
# 添加外键约束之后插入数据
INSERT INTO product(Product_ID, Sort_ID) VALUES(9999,99);
# ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails

# 先在主表sort添加一条记录
INSERT INTO sort VALUES(99, "其他类别");
# 再向product添加一条记录
INSERT INTO product SET Product_ID=9999, Sort_ID=99;
```

### 使用关联表查询数据

如果要查询根类别为“办公机器设备”的产品，但是product表中并没有“根类别名称”字段，可以使用表的关联关系查询，具体步骤如下

```sql
# 先在sort表中查询name为"办公机器设备"的Sort_ID;
SELECT Sort_ID FROM sort WHERE Sort_Name="办公机器设备";

# 在product表中查询Sort_ID 为11的产品信息
SELECT * FROM Product WHERE Sort_ID=11;
```



### 删除关联表中的数据。

第一种方法：将从表里引用参照列的记录全部删除后，再删除主表里的相应记录。

```sql
DELETE FROM product WHERE Sort_ID = 14;
DELETE FROM sort WHERE Sort_ID = 14;
```



第二种方法：将从表里引用参照列的记录字段值改为NULL，再删除主表里的相应记录。注意，前提是从表里外键字段没有非空约束。

```sql
UPDATE product SET Sort_ID=NULL WHERE Sort_ID=99;
DELETE FROM sort WHERE Sort_ID=99;
```



第三种方法：将从表里的主键约束参数修改为cascade方式后，再删除主表里的记录，同时从表里引用主表参照列的记录也相应被删除。

```sql
# 在命令行里需先删除外键再重新添加带有参数的外键约束
ALTER TABLE product DROP FOREIGN KEY FK_sortid;
# 将从表里的主键约束参数修改为cascade方式
ALTER TABLE product ADD CONSTRAINT FK_sortid FOREIGN KEY(Sort_ID) REFERENCES sort(Sort_ID) ON DELETE CASCADE;
# 删除主表里的记录，同时从表里引用主表参照列的记录也相应被删除。
DELETE FROM sort WHERE Sort_ID = 21;


# 在product表中查询Sort_ID为21的记录，结果为空，因为product表中的相应记录也已被删除。
SELECT * FROM product WHERE Sort_ID=21;
```



## multi-join queries 

### CROSS JOIN

比较少用，就是笛卡尔积，一个例子`SELECT * FROM Sort CROSS JOIN Subsort;`

### INNER JOIN 

**内连接使用比较运算符对两个表中的数据进行比较，列出与连接条件匹配的数据行，组合成新的记录**

```sql
SELECT 查询字段 FROM 表1 [INNER] JOIN 表2 
	ON 表1.关系字段=表2.关系字段;
```

example:

使用内连接，查询根类别表（sort表）和子类别表（subsort表）中的根类别名称和子类别名称

```sql
SELECT Sort_name, SubSort_name FROM sort JOIN subsort ON sort.Sort_ID = subsort.Sort_ID;
```

使用where语句同样可以实现上述结果

```sql
SELECT Sort_name, SubSort_name FROM sort,subsort WHERE sort.Sort_ID = subsort.Sort_ID;
```

使用WHERE子句的查询结果与使用INNER JOIN的查询结果一致，**要注意的是WHERE是条件判断语句，在后面可以直接添加其他条件，但INNER JOIN作为内连接语句是不可以的**

内连接和where一起使用

```sql
# 使用内连接，查询发货地址(Delivery_address)为“上海”以下相关信息：Product_id, Prodcut_name, User_name, Delivery_address
SELECT product.Product_ID, product.Product_name, product.User_name,product,Delivery_address FROM product JOIN order ON product.Product_ID = order.Product_ID WHERE Delivery_address  LIKE "上海%";	
```

### LEFT|RIGHT [OUTER] JOIN

```sql
SELECT 所查字段 FROM 表1 LEFT|RIGHT [OUTER] JOIN 表2 
	ON 表1.关系字段 = 表2.关系字段 WHERE 条件
```

左连接的结果包括LEFT JOIN子句中指定的左表的所有记录，和所有满足连接条件的记录。如果左表的某条记录在右表中不存在，则在右表中显示为空。

右连接与左连接正好相反，返回右表中所有指定的记录和所有满足连接条件的记录。如果右表的某条记录在左表中没有匹配，则左表将返回空值。

```sql
SELECT sort.Sort_ID,sort.Sort_name, subsort.SubSort_name FROM sort 
	LEFT JOIN subsort ON sort.Sort_ID =subsort.Sort_ID;

SELECT sort.Sort_ID,sort.Sort_name, subsort.SubSort_name FROM sort 
	RIGHT JOIN subsort ON sort.Sort_ID =subsort.Sort_ID;
```



## subquery

子查询是指一个查询语句嵌套在另一个查询语句内部的查询。在执行查询语句时，首先会执行子查询中的语句，然后将返回的结果作为外层查询的过滤条件

| 关键字               | 作用                                                         |
| -------------------- | ------------------------------------------------------------ |
| IN                   | 使用IN关键字进行子查询时，内层查询语句仅返回一个数据列，这个数据列中的值将供外层查询语句进行比较操作。 |
| EXIST                | EXIST关键字后面的参数可以是任意一个子查询，这个子查询的作用相当于测试，它不产生任何数据，只返回True或False，当返回True时外层查询才会执行。 |
| ANY                  | ANY关键字表示满足其中任意一个条件，它允许创建一个表达式对子查询的返回值列表进行比较，只要满足内层子查询中任意一个比较条件，就返回一个结果作为外层查询条件。 |
| ALL                  | ALL关键字与ANY关键字类似，带ALL关键字的子查询返回的结果需同时满足所有内层查询条件。 |
| comparison operators | 子查询中还可以使用诸如>、<、>=、<=、=、!=等比较运算符        |



```sql
# 使用IN关键字查询存在子类别为“闹钟”的根类别信息
SELECT * FROM sort 
	WHERE Sort_ID IN (SELECT Sort_ID FROM subsort WHERE SubSort_name  REGEXP "闹钟");
/*
在查询过程中，首先会执行内层子查询，得到子类别名为闹钟的根类别编号Sort_ID;
然后根据根类别编号Sort_ID与外层查询的比较条件，最终得到符合条件的数据。
*/
```

```sql
# 使用EXISTS关键字查询根类别，如果存在子类别编号为3101。
SELECT * FROM sort 
	WHERE EXISTS (SELECT Sort_ID FROM subsort WHERE SubSort_ID = 3101);
/*
由于subsort表中存在subsort_id为3101的记录，因此子查询的返回结果为True，所以外层查询语句会执行，返回的是所有根类别信息。
*/	
```

```sql
# 使用带ANY关键字的子查询，查询满足条件的根类别信息。
SELECT * FROM sort 
	WHERE Sort_ID < ANY(SELECT Sort_ID FROM subsort WHERE SubSort_ID < 2100);
/* 
在查询过程中，首先子查询会将subsort表中SubSort_ID小于2100的记录的Sort_ID都查询出来，分别为11、12、13、14;
然后将sort表中的Sort_ID值与之进行比较，只要小于11或12或13或14的任意一个值，就是符合条件的查询结果。
*/
```
```sql
# 使用带ALL关键字的子查询，查询满足条件的根类别信息。
SELECT * FROM sort 
	WHERE Sort_ID > ALL(SELECT Sort_ID FROM subsort WHERE SubSort_ID < 2100);

/*
在查询过程中，首先子查询会将subsort表中SubSort_ID小于2100的记录的Sort_ID都查询出来，分别为11、12、13、14;
然后将sort表中的Sort_ID值与之进行比较，只有大于11、12、13、14的所有值，才是符合条件的查询结果。
*/
```

