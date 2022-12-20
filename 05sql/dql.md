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

