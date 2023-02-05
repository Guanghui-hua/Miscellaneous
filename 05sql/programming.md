# SQL programming

为了便于MYSQL代码维护和提高代码重用性，MYSQL开发人员经常需将频繁使用的业务逻辑封装成存储程序。MYSQL的存储程序分为4类：函数、触发器、存储过程以及事件

## 常量

1. 字符串常量 ->字符串常量是指用单引号或双引号括起来的字符串序列。

2. 数值常量 `SELECT 1 AS a, 1.23 AS b, -1 AS c;`

3. 日期和时间常量 `SELECT NOW() AS now;`

4. 布尔值常量 `SELECT TRUE, FALSE;`

5. 二进制

    二进制可以用0b紧跟二进制数，或者直接用前缀b+二进制字符串；

    **使用select语句显示二进制数时，会将二进制数自动转换为字符串再进行显示。**

    ```sql
    SELECT 0b111001, b'111001';              
    SELECT CONV('10', 10, 2);              #10进制数转化为2进制 
    SELECT BIN(8);                         #10进制数转化为2进制
    ```

    `CONV(m, a, b)`函数: 把`a进制数`m转化为`b进制数`
    进制中：BIN、OCT、HEX、DEC分别代表二、八、十六、十进制

6. 十六进制

    ```sql
    SELECT x'41',X'4D7953514C';
    SELECT 0x41,0x4d793514c;
    SELECT CONV('42', 10, 16);            #10进制数转化为16进制
    SELECT hex(42), hex(16);              #10进制数转化为16进制
    ```

7. NULL

    Null值适用于各种字段类型，通常用来表示“值不确定”、“没有值”等含义。Null参与算术、比较和逻辑运算时，结果依然为null。

## 用户自定义变量

MySQL中的变量分为用户变量和系统变量

用户变量：是指与数据库的一次连接中声明的变量，在连接断开后就会消失。

 1. 变量命名 

  变量名必须以`@`开头，例如`@name`

2. 声明及赋值 

  声明与赋值的方法两种，一种是使用`set`语句，一种是使用`select`语句

  ```sql
  /*使用set语句声明变量并赋值（注：声明的时候必须赋初值）*/
  set @name='zhangsan';
  /*使用select语句声明并赋值*/
  select @age:=23;
  
  ```

  

3. 查看用户变量 

  查看变量使用select语句

  ```sql
  select @name;
  ```

4. 使用`set`定义用户变量

  ```sql
  set @变量名称1 = 表达式1[, @变量名称2 = 表达式2, …,]
  ```

  ```sql
  SET @user_name='张三';
  SELECT @user_name;  
  
  SET @user_name=b'11', @age=18;
  SELECT @user_name,@age; 
  
  SET @age=18;
  SET @age=@age+1;
  SELECT @age;          #查看age的更新值
  
  ```

5. 使用`SELECT`语句定义用户变量

  ```sql
  select @变量名称1 := 表达式1 [, @变量名称2 := 表达式2,…];
  select 表达式1[, 表达式2…] into @变量名称1[, @变量名称2,…];
  ```

  

  ```sql
  SELECT @a:='b';
  SELECT @a;           #查看a的值
  
  SELECT @a:='b';
  SELECT @a='a';      #返回0
  SELECT @a;          #结果为b
  
  SELECT '张三', 19 INTO @user_name,@age;
  SELECT @user_name,@age;
  
  ```

  请注意：select中语句`:=`和`=`的区别。

  `=`在select语句中为比较运算符，所以如果使用`select @a =‘a’`，则表示`变量a`与`‘a’`进行等值比较，如果a之前定义了，则返回1或0；如果a之前未被定义，则返回null。

  `:=`在select中是赋值的作用

## 使用用户变量保存sql查询结果的5种方式

将product表中的记录数赋值给用户变量@product_count。

1. ` SET @变量名=SELECT语句`

    ```sql
    SET @product_count=(SELECT COUNT(*) FROM Product);
    SELECT @product_count AS '产品数量';
    ```

    > `=`在set和update中是和select语句中的`:=`一样，是赋值的作用。在其它语句中都是等于的作用。

2. `SELECT @变量名 := SELECT语句`

   ```sql
   SELECT @product_count2:=(SELECT COUNT(*) FROM Product);
   SELECT @product_count2 AS 产品数量;
   ```

3.  `SELECT @变量名:=聚合函数 FROM 表`

   ```sql
   SELECT @product_count3:=COUNT(*) FROM Product;
   SELECT @product_count3 AS 产品数量;
   ```

4. `SELECT 聚合函数 INTO @变量名 FROM 表`

   ```sql
   SELECT COUNT(*) INTO @product_count4 FROM Product;
   SELECT @product_count4 AS 产品数量;
   ```

5.  `SELECT 聚合函数 FROM 表 INTO @变量名`

   ```sql
   SELECT COUNT(*) FROM Product INTO @product_count5;
   SELECT @product_count5 AS 产品数量;
   ```

   

## 运算符

1. 算数运算符 -> 加+、减-、乘*、除/、求余%

2. 比较运算符 -> `=、>、>=、<、<=、!=、<> `  ` BETWEEN...AND... ` `IN`

    ```
    SELECT 'b' BETWEEN 'a' AND 'c';
    SELECT 10 NOT BETWEEN 5 AND 9;
    SELECT 1 IN (1,2,'a');
    SELECT 1 NOT IN (1,2,'a');
    ```

    正则表达式

    正则表达式是对字符串操作的一种逻辑公式，就是用事先定义好的一些特定字符、及这些特定字符的组合，组成一个“规则字符串”，这个“规则字符串”用来表达对字符串的一种过滤逻辑。给定一个正则表达式和另一个字符串，我们可以达到如下的目的：1. 给定的字符串是否符合正则表达式的过滤逻辑（称作“匹配”）2. 可以通过正则表达式，从字符串中获取我们想要的特定部分。

3. 逻辑运算符 -> `和( and &&)`  `或(or ||)`  `非(not !)`

    AND：如果表达式1和表达式2都为非0值，那么值为1，否则值为0

    OR：   如果表达式1和表达式2中至少一个为非0，那么值为1，否则则为0

    NOT：当操作数为0 时，所得值为 1；当操作数为非0 时，所得值为 0

4. 重新定义命令结束符号 `delimiter`

    在mysql中，默认的命令结束符号为`;`，在编程过程中通常存在多条mysql表达式。为了编码这些表达式被拆开，需要利用delimiter命令重置mysql客户机的命令结束标记。

    ```sql
    DELIMITER $$                     #将命令结束标记临时设置为$$
    SELECT * FROM sort;              #按回车并不执行语句
    SELECT * FROM subsort LIMIT 5; $$ #按回车执行二条select语句
    DELIMITER ;                      #将命令结束符重新设定为;
    ```

## 自定义函数

```sql
create function 函数名称 (par1, par2, ...) returns 返回值数据类型
[函数选项]
begin
函数体;
return 语句;
end;


“begin” 和“and” 用于将多个表达式包含起来形成语句块，一个典型的begin-end语句块格式如下，其中开始标签与结束标签名称必须相同。
[开始标签：] begin
  [局部]变量的声明;
  错误条件触发条件的声明;
  游标的声明;
  错误处理程序的声明;
  业务逻辑代码;
end [结束标签];
注意：局部变量用declare 变量名称 进行声明，局部变量只在当前begin-end语句块中有效。

```

创建自定义函数时，不能与已有的函数名（包括系统名）重复。建议在自定义函数名中统一添加‘fn_’或者后缀‘_fn’。

函数的参数无需使用declare命令定义，但它仍属于局域变量，且必须提供参数的数据类型。

自定义函数如果没有参数，则使用空参数“（）”即可。

函数必须制定返回值的数据类型，且需与return预计中的返回值的数据类型相近（长度可以不同）。

### 查看用户自定义的函数

```sql
# 语法
show function status where definer=‘用户名@主机';

# 示例
show function status where definer='root@localhost';
```



### 查看函数的定义语句

```sql
# 语法
show create function 函数名称

# 示例
show create function get_sum_sort_fn;
```



### 删除用户自定义函数

```sql
# 语法
drop function 函数名称;

# 示例
drop function get_sum_sort_fn;
show function status where definer='root@localhost'; #查看是否删除

```



## 条件控制语句

```sql
If 条件表达式1 then 语句块1;
[elseif 条件表达式2 then 语句块2];
...
[else 语句块n]
end if;

```

创建函数f, 输入x，如果x<0，计算y=-x;如果x>=0，计算y=x*2，返回y。

```sql
delimiter $$
create function f(x float)returns float
	no sql
	begin 
		declare y float;
		if (x < 0) then
			set y = -x;
		else
			set y = x * 2;
		end if;
		return y;
	end;
$$
delimiter;

set @x=5;
select @x as 'x0',f(@x) as "y0';
```



## 控制循环语句

```
while语句的语法结构：
[循环标签:] 
while 条件表达式 
do循环体;
end while [循环标签];

```

创建函数get_sum_fn，返回整数1到n的累加和

```sql
delimiter $$
create function get_sum_fn (n int) returns int
no sql
begin
	declare accum_sum int default 0;
	declare start_num int default 0;
    while start_num < n do
        set start_num = start_num + 1;
        set accum_sum = start_num + accum_sum;
        end while;
    return accum_sum;
end;
$$
delimiter;

select get_sum_fn(100);
```


