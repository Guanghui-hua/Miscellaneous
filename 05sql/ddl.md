# database and basic operations of database

## 1. basic database operations

1.1 create database

` CREATE DATABASE XXX`
` SHOW DATABASES`

1.2 view database

`SHOW CREATE DATABASE XXX`

1.3 modify database

`ALTER DATABASE name DEFAULT CHARACTER SET encodingMethod COLLATE encodingMethod_bin; `

for examble, `ALTER DATABASE itcast DEFAULT CHARACTER SET gbk COLLATE gbk_bin; `


1.4 delete database

`DROP DATABASE name;`

## the method of exporting data and importing data

We use the workbench(MySQL Workbench is a database modeling tool designed for MySQL) to export or import database.

## the basic operation of data tables

The syntax for creating a data table is as follows:

```sql
CREATE TABLE name
(
field name, data type

);
```

for example, 

```sql
CREATE	DATABASE stu_info;
USE stu_info;
CREATE TABLE tb_grade(
		id INT(11),
		name VARCHAR(20),
		grade FLOAT
);
SHOW CREATE TABLE tb_grade;
DESCRIBE tb_grade;

```

## modify data table

### 1. modify table name

```sql

ALTER TABLE oldName RENAME TO newName

```

for example, change the name of the data table tb_grade to grade <br> `ALTER TABLE tb_grade RENAME TO grade`

### 2. modify field name

```sql
ALTER TABLE tableName CHANGE oldFieldName newFiledName newDataType;
```

for example, change the name of field name 'name' in the table to username <br> `ALTER TABLE grade CHANGE name username VARCHAR(20); `

### 3. modify the data type of field 

```sql
ALTER TABLE tableName MODIFY fieldName dataType;
```

for example , change the data type of the id field in the data table grade from INT(11) to INT(20) <br> `ALTER TABLE grade MODIFY id INT(20);`

### 4. add field

```sql
ALTER TABLE tableName ADD newFieldName dataType;
```

for example, add the field 'age' with data type INT to the table 'grade' <br> ` ALTER TABLE grade ADD INT(10);`

### 5. delete field

```sql

ALTER TABLE tableName DROP fieldName;

```

for example, delete field 'name' in the table 'grade';  <br> `ALTER TABLE grade DROP age;`

### 6. copy data table

```sql
CREATE TABLE newTableName select * from oldTableName;
```

for example, copy the 'grade' table into a `grade_bak` table <br> `CREATE TABLE	grade_bak SELECT * FROM grade;`

### 7. modify the alignment of the fields

```sql
ALTER TABLE tableName MODIFY fieldName1 dataType [FIRST] [AFTER]  fieldName2;
```

for example, change field name 'username' in the grade_bak to the first field <br> `ALTER TABLE grade_bak MODIFY username VARCHAR(20) FIRST`

Insert the 'id' field in the grade_bak table after the 'grade' field <br> `ALTER TABLE grade_bak MODIFY id INT(20) AFTER grade;`

## the representation of different types of data in SQL statements

When using a MySQL database to store data, different data types determine how MySQL stores data differently.

### Numeric Type 

| Type | Memories | Uses|
|--| -- | -- |
|TINYINT | 1 byte| small integer value|

### String Type

### Date & Time Type


