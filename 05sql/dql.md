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

```sql

SELECT AGE(Price) FROM product;
SELECT MAX(Price) FROM product;
SELECT MIN(Price) FROM product;

SELECT COUNT(*) FROM product;

SELECT * FROM product WHERE Product_Name LIKE '%理光%墨粉%' ORDER BY Price DESC;

```

```sql

SELECT * FROM product WHERE Product_Name LIKE '%理光%墨粉%' GROUP BY Product_Place;

```

## Aliases for tables and fields

