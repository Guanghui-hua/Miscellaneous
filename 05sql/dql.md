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

