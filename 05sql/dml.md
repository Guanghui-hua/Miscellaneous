# Database Manipulate Language

## Insert data

### 1. add data to all fields in the table

+ Method One

```sql
INSERT INTO tableName(field names, ...) VALUES(fields values);
SELECT * FROM tableName;

```

example:

`INSERT INTO student(id, name, grade) VALUES(1, 'zhangsan', 98.5);SELECT * FROM student;`

`INSERT INTO student(name, id, grade) VALUES('zhangsan', 1, 98.5); SELECT * FROM student`

+ Method Two

```sql

INSERT INTO student VALUES(3, 'wangwu', 61.5);

```


### 2. add data to specified fields in the table
The condition is that inserted records that have non-null constraints need to specify.

example:

```sql
INSERT INTO student(id, grade) VALUES(5,'97');
```

```sql 
INSERT INTO student(id, grade) VALUE(5,'97'); 
```
An error occured because the field 'name' was not assigned a default value when the data table was created, but then a non-NULL constraints was added.

### 3. Use `INSERT ... SET` statement to add date to a specifed field or all fields in a table.

```sql
INSERT INTO student SET id=5, name='boya',grade = 99;
```

### 4. add multiple records at the same time

```sql

INSERT INTO tableName (fieldName1, fieldName2,...) VALUES 
(value1, value2,...),
(value1, value2,...),
(value1, value2,...);

```

example:
```sql
INSERT INTO student VALUES
(6,'lili',99),
(7,'hanmei',100),
(8,'poly',40.5);

```

```sql
INSERT INTO student(id, name) VALUES
(9,'liubei'),
(10,'guanyu'),
(11,'zhangfei');
```

## Update data
Updating data means making changes to the data that exists in a table.<br> Use the where clause to specify the conditions for updating the rows to update one or more rows in a table. <br> If the where clause is not used, the specified fields of all records in the table will be updated.

```sql
UPDATE tableName
	SET fieldName1 = value1,fieldName2 = value2,...
	WHERE conditional expressions.
```

example:

```sql

UPDATE student SET name='caocao', grade = 50 WHERE id = 1;

UPDATE student SET grade = 100 WHERE id < 4;

```

If the where clause is not used, the specified fields of all records in the table will be updated.

```sql
UPDATE student SET grade=80;
```

## Delete data

### use DELETE statements

```sql
# copy the student table into student_bak table ;
CREATE TABLE student_bak1 SELECT * FROM student;

# delete a record with a field value of 11;
DELETE FROM student_bak1 WHERE id = 11;

# delete one or more records in a table according to specified conditions 
DELETE FROM student_bak1 WHERE id>5;

# delete all the records from the student_bak1
DELETE FROM student_bak1;
 
```

### use TRUNCATE keywords

```sql

# use TRUNCATE to delete all records in the student talbe

TRUNCATE TABLE student_bak2;
```

