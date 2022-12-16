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

## 2.the basic operation of data tables

### 2.1 create a data table

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

### 2.2 modify data table

#### (1) modify table name

```sql

ALTER TABLE oldName RENAME TO newName

```

for example, change the name of the data table tb_grade to grade <br> `ALTER TABLE tb_grade RENAME TO grade`

#### (2) modify field name

```sql
ALTER TABLE tableName CHANGE oldFieldName newFiledName newDataType;
```

for example, change the name of field name 'name' in the table to username <br> `ALTER TABLE grade CHANGE name username VARCHAR(20); `

#### (3) modify the data type of field 

```sql
ALTER TABLE tableName MODIFY fieldName dataType;
```

for example , change the data type of the id field in the data table grade from INT(11) to INT(20) <br> `ALTER TABLE grade MODIFY id INT(20);`

#### (4) add field

```sql
ALTER TABLE tableName ADD newFieldName dataType;
```

for example, add the field 'age' with data type INT to the table 'grade' <br> ` ALTER TABLE grade ADD INT(10);`

#### (5) delete field

```sql

ALTER TABLE tableName DROP fieldName;

```

for example, delete field 'name' in the table 'grade';  <br> `ALTER TABLE grade DROP age;`

#### (6) copy data table

```sql
CREATE TABLE newTableName select * from oldTableName;
```

for example, copy the 'grade' table into a `grade_bak` table <br> `CREATE TABLE	grade_bak SELECT * FROM grade;`

#### (7) modify the alignment of the fields

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

omit...

### Date & Time Type

omit...

### 2.3 Table constraints

To prevent incorrect data from being inserted into a data table, there are rules defined in MySQL to maintain database integrity, i.e. 'table constraints'.

#### (1) PRIMARY KEY CONSTRAINTS

Fields defined as PRIMARY KEY cannot have 'duplicate values' and cannot be 'NULL values'.

+ Set primary key constraints by modifying field properties.

```sql
ALTER TABLE tableName MODIFY fieldName fieldType PRIMARY KEY;
```

example: set the 'id' field in the data table 'grade' as the primary key. <br> 'ALTER TABLE grade MODIFY id int PRIMARY KEY;`

+ Set primary key constraints by creating a new data table

```sql 
CREATE TABLE tableName( field1 fieldType PRIMARY KEY,
			field2 fieldType,
			field3 fieldType);
```

example:create a new data talbe 'example' and create a field 'id' with the property INT(10) and set it as the primary key.  `CREATE TABLE example( id INT(10) PRIMARY KEY);`
+ set Multi-Field primary key constraints ```sql CREATE TABLE tableName(field1 fieldType, 
			field2 fieldType,
			PRIMARY KEY(field1, field2)
);
```
example: create a table called course and create three fields named 'stu_id', 'course_id','grade', where stu_id and course_id are set as multi-field primary keys.

```sql 
CREATE TABLE course(
		stu_id INT,
		course_id INT, 
		grade FLOAT,
		PRIMARY KEY(stu_id, course_id)
);
```

#### (2) FOREIGN KEY

#### (3) UNIQUE

Unique constraints are used to ensure the uniqueness of fields in a data table, i.e., the values of fields in the table cannot be repeated.
Set a uniqueness constraint on the  field 'username' in the data table 'grade'.  `ALTER TABLE grade MODIFY username VARCHAR(20) UNIQUE;`

#### (4) NOT NULL

The non-null constraint means that the value of the field cannot be NULL

```sql
fieldName dataType NOT NULL;
```
example: set a non-null constraint on the username field in the data table grade <br> `ALTER TABLE grade MODIFY username VARCHAR(20) NOT NULL;`

#### (5) CHECK

#### (6) DEFAULT

The default constraints is used to assign a default value to a field in a table. That is, when a new record is inserted into a table, if no value is assigned to the field, then the database system automatically inserts a default value for the field.

example: Set the default constraint value to 0 for the grade field in the data table grade. <br> `ALTER TABLE grade MODIFY grade FLOAT DEFAULT 0;`
