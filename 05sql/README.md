# Introduction to sql language

SQL(Structured Query Language) is a database query language and programming language mainly used for managing data in databases, such as accessing data, querying data, updating data and etc. SQL was developed by IBM between 1975 and 1979, and in the 1980s, SQL was defined as the standard for relational database language by the ANSI and ISO, which consists of four parts.

## Database Definition Language (DDL) 

Database definition language is mainly used to define the database, table, etc, which includes CREATE statement, ALTER statement, DROP statement .


` CREATE statement `  is used to create the database, data tables. <br> ` ALTER statement ` is used to modify the definition of the table. <br> 
` DROP statement ` is used to delete the database, delete the table. 

## Data Manipulation Language(DML)

The data manipulation Language is mainly used to add, modify and delete operations to the database, which includes `INSERT`, `UPDATE` and `DELETE` statements; <br> `INSERT` statement is used to insert data;<br>` UPDATE` statement is used to modify data; <br>` DELETE` statement is used to delete data;

## Data Query Language(DQL)

Query one or more data in the database by using `SELECT` language.

## Data Control Language(DCL)

The data control language is mainly used to control the user's access rights, which includes ` GTANT statements `, REVOKE statement, COMMIT statement, and ROLLBACK statement. <br> The GRANT statement is used to add privileges to a user <br> the REVOKE statement is used to withdraw privileges from a user, <br> the COMMIT statement is used to commit a transaction, <br> and the ROLLBACK statement is used to roll back a transaction.


The operation in the database are done by SQL language, and SQL statement are often used in the applications, for example, SQL statements are nested in Java language, and by excuting Java language to call SQL statements, you can insert, modify, delete, query and other operations of data. In addition, SQL statements can also be nested in other languages, such as C#, PHP, etc.


[MySQL学习视频](https://www.bilibili.com/video/BV1UE41147KC/?spm_id_from=333.999.0.0&vd_source=2d8eac388c51569c9c8a0b39d279dc35)
[该视频的笔记](https://zhuanlan.zhihu.com/p/222865842) 