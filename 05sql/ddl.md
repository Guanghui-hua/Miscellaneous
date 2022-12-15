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

The syntax for creating a data table is sa follows:

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


## the representation of different types of data in SQL statements

## understanding the different data types
