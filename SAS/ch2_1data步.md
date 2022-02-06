# data步

## 1. 数据步中的基本语法

### 1.1 data步的一般使用格式

```
DATA 数据集名：
	INPUT 变量名1[$] 变量名2[$] ... /*如果为字符型变量后面加符号$*/
	其他数据步语句；
	CARDS;    /*注意，当变量中包含有;符号时，此处使用CARDS4*/
源数据行
...
...
...
;     /*注意，此处的分号要另起一行*/
RUN;

```

### 1.2 `INPUT`语句

(1) 自由格式

`INPUT 变量名1[$]  变量名2[$] ... 变量名n[$] `

(2) 列标识方式

`INPUT 变量名1[$]起始列-终止列  变量名2[$]起始列-终止列 ... 变量名n[$]起始列-终止列; `

(3) 格式输入

常见变量输入： `W.`  宽度为W的标准数字

​							`W.D`  含有小数点的标准数字

​							`COMMAW.D`  长度为W的数字

​							`$CHARW`

常见的日期输入： 略

>  SAS把1960年1月1日作为基准，所有日期与这一基准的差转换成天数存放。如果早于1960年1月1日，差为负数，如果晚于1960年1月1日，差为正数。  



一个例子，注意一个汉字占据3个字符，不然会出现显示不了的状况

```SAS
data test; /*在word逻辑库中创建名为test的数据集*/
length num$2;
length sex$3;
length xueli$ 9;
length zhicheng$ 15;    /*在这里一定要搞清楚一个汉字占据3个占位符，而不是两个*/
input num sex$ xueli$ zhicheng$;
label sex='性别' xueli='学历' zhicheng='职称';
cards;
1 男 研究生 小学高级
2 女 本科 小学三年级
3 女 研究生 小学高级
4 男 大专 小学二年级
5 男 本科 小学三年级
6 女 本科 小学一年级
7 女 大专 小学一年级
8 男 本科 小学二年级
9 女 大专 小学二年级
10 男 研究生 小学三年级
11 男 大专 小学一年级
12 女 本科 小学二年级
13 男 本科 小学二年级
14 女 本科 小学二年级
15 男 大专 小学一年级
16 女 本科 小学高级
17 男 研究生 小学高级
18 男 本科 小学二年级
19 女 本科 小学三年级
20 女 研究生 小学高级
21 男 本科 小学二年级
22 男 本科 小学三年级
23 女 研究生 小学高级
24 男 本科 小学三年级
25 女 大专 小学一年级
26 男 本科 小学一年级
27 女 大专 未评定职称
28 男 本科 小学一年级
29 女 大专 小学一年级
30 女 大专 未评定职称
;
run;
proc freq data=test; /*单变量的列联表分析*/
tables sex xueli zhicheng;
run;
```

另外一个例子，关于日期的输入

这里面还有一个问题，就是因为名字是张三，考虑到中文里面名字可能有三位数，所以就有空格，空格不好处理，所以不能在像上面的例子一样，直接确定一个长度，不然空格会自动把他们分开，此时必须确定他们的长度，要保证长度数清楚

```SAS
data chap1.example1_1;
input ID$1-4 name$5-14  Type$15-24 birth YYMMDD8. +1 N; /*定义变量输入格式*/
cards;
0101 张   三 金   卡64/10/06 20
0102 李   四 银   卡 82/09/16 13
0103 王   五 普通卡 87/01/27 5
;
Run;
proc print;
format birth YYMMDD8.; /*设置变量birth的输出格式*/
run;
```

### 1.3 赋值语句

`变量名=表达式;`

常量 -> 字符型、数值型、日期型和时间型数据

变量 -> 字符型和数值型变量

运算符 -> 算术运算符、逻辑运算符和关系运算符

算术运算符 -> `+ - * / **`注意SAS中乘方运算为`**`

### 1.4 逻辑运算符和关系运算符

逻辑运算符

| 操作符 | 符号 | 意义 |        运算格式         |               特征               |
| :----: | :--: | :--: | :---------------------: | :------------------------------: |
|  AND   |  &   |  与  | 运算对象1 AND 运算对象2 |        结果全为真，则为真        |
|   OR   |  \|  |  或  | 运算对象1 OR 运算对象2  |       一个对象为真，则为真       |
|  NOT   |  ^   |  非  |      NOT 运算对象       | 运算结果和运算对象本身真假性相反 |


关系运算符
| 操作符 | 意 义                   | 符 号 |
| ------ | ----------------------- | ----- |
| LT     | 小于(Less Than)         | <     |
| GT     | 大于(Greater Than)      | >     |
| EQ     | 等于(Equal)             | =     |
| LE     | 小于等于(Less Equal)    | <=    |
| GE     | 大于等于(Greater Equal) | >=    |
| NE     | 不等于(Not Equal)       | ^=    |
| IN     | 等于列举中一个          |       |

### 1.5 循环语句

(1) DO循环

```
DO 计数变量=起始值 TO 结束值 BY 步长;
循环体…;
END;  
```

示例：

```SAS
data example2_1;
	do x=5 to 30 by 5; /*设置x的起始值为5，终止值为30，步长为5*/
        y=log(x); /*给变量y赋值为x的自然对数*/
        if y>3 then leave; /*若y的值大于3则离开，进而结束循环*/
        output; /*将变量x,y的值写入数据集*/
        format y 8.5; /*定义y的输出格式为总长度为8位，小数点占5位*/
	end; /*结束循环*/
run;
```

(2) DO-WHIEL循环

```SAS
DO WHILE (循环继续条件);
	循环体语句;
END;
```

示例：

```SAS
data example2_2;
y=100; /*取y的初始值为100*/
do x=2 to 10 by 2 while (y<3000); /* 当y的值小于3000时，继续循环*/
	y=y*x; /*给变量y赋值，迭代更新*/
	output; /*将变量x,y的值写入数据集*/
end;
run;
```

(3) DO UNTIL 循环

```
DO UNTIL(循环退出条件);
	循环体语句…;
END;  
```

示例：

```SAS
data example2_3;
y=100; /*取y的初始值为100*/
do x=2 to 10 by 2 until (y>=3000); /* 执行循环直到y的值大于等于3000*/
    y=y*x; /*y的值为前一次循环结束后y的值和当次循环x值的乘积*/
    output;
end;
run;
```

### 1.6 判断语句

(2) IF-ELSE语句

+ 格式一： `IF 条件表达式 THEN;`

+ 格式二： 

  ```
  IF 条件表达式 THEN SAS语句;
  <ELSE SAS语句 >;  
  ```

### 1.7 分支结构

(1) IF语句

`if 条件 then;`

(2) SELECT 语句也有两种用法

+ 用法一 （适用于分类型数据）

  ```
  select(选择表达式);
  	when(值列表一)SAS语句1;
  	...
  	when(值列表K)SAS语句K;
  	...
  	otherwise SAS语句N;
  end;
  ```

  示例：

  ```SAS
  data Example2_4_1;
  	set sashelp.class;  /*导入sashelp中的数据*/
  	length sex_type$8;   
  	select(sex);
  		when('M') sex_type='Male';
  		when('F') sex_type = 'Female';
  		otherwise sex_type = 'others';
  	end;
  run;
  ```

+ 用法二（适用于数值型数据）

  ```
  select;
  	when(条件一)SAS语句1;
  	...
  	when(条件K)SAS语句K;
  	...
  	otherwise 语句N;
  end;
  ```

  示例：

  ```SAS
  data Example2_4_2;
  	set sasuser.example1_2;
  	length type$10;
  	BMI = weight(height**2);
  	select;
  		when(BMI<18.5) type='轻体重';
  		when(18.5=<BMI<24) type = '健康体重';
  		when(24=<BMI<28) type = '超重';
  		when(28=< BMI) type = '肥胖';
  	end;
  run;
  ```

## 2. SAS数据集整理

### 2.1 在数据集中增加、筛选变量（列）和观测（行）

(1) Keep\Drop语句

+ KEEP语句格式1：` KEEP 变量1 变量2 …变量N;`
+ KEEP语句格式2：` DATA=数据集名称（KEEP=变量1 变量2 …变量N）;`
+ DROP语句格式1： `DROP变量1 变量2 …变量N;`
+ DROP语句格式2： `DATA=数据集D名称（DROP=变量1 变量2 …变量N）;`

(2) IF-ELSE语句

+ 格式一： `IF 条件表达式 THEN;`

+ 格式二： 

  ```
  IF 条件表达式 THEN SAS语句;
  <ELSE SAS语句 >;  
  ```

示例：Example2_5_1

```SAS
/*新建数据集mylib.example2_5；*/
data Mylib.example2_5;
	length ID$3;
	length weight$4;
	length height$4;
	input ID$ name$4-13 sex$14-17 weight$ height$;
	cards;
	01 姚籽萱 女 50.5 1.63
	02 徐若黛 女 51 1.53
	03 张   林 男 60 1.72
	04 谢欣然 女 62 1.70
	05 夏   天 女 54 1.67
	06 刘子然 男 70 1.80
	07 赵   赵 男 65 1.75
	08 章   峰 男 84 1.68
	;
run; 
/*以上程序新建数据集mylib.example2_5*/

data mylib.example2_5;
	retain ID name sex weight height;  /*保持原来的变量的顺序不变*/
	set mylib.example2_5;
	BMI=weight/(height**2); /*根据公式计算BMI*/
run;

data mylib.example2_5;
	set mylib.example2_5;
	keep ID sex BMI; /*保留变量ID, sex, BMI,此行也可改写为drop name weight height;*/
run;

data mylib.example2_5;
	set mylib.example2_5;
	if BMI>18 && BMI<25; /*保留BMI在18至25之间的观测*/
run;
```

keep(drop)还有一种使用方法

示例： Example2_5_2

```SAS
data mylib.example2_5;
	retain ID name sex weight height;
	set mylib.example2_5;
	BMI = weight/(height**2);
run;

data mylib.example2_5(keep =ID name BMI);  /*使用和上面不同的语法*/
	set mylib.example2_5;
	if BMI>18 && BMI<25;
run;

```



### 2.2 对数据集排序

```
PROC SORT <选项>;
	BY <DESCENDING> 变量名；
RUN;  
```

示例：Example2_6Sort

```SAS
/*对变量进行排序*/
proc sort data=mylib.example2_5 out=mylib.example2_6;
	by descending BMI;
run;

proc print data=mylib.example2_6;
run;
```

### 2.3 数据集纵向连接

`set 数据集名称1 数据集名称2…数据集名称n;`
结果数据集的变量集合，是参加合并数据集变量集合的并集；
相同变量中的观测将被纵向合并。 

示例：Example2_7Set

```SAS
/*数据集的纵向连接，也就是变量的并集*/
data mylib.A;
	length name$4;
	length statistic$2;
	length chinese$2;
	input name$ statistic$ chinese$;
cards;
LR 89 92
HW 78 89
YJ 85 76
SJ 91 87
;
run;

data mylib.B;
	length name$2;
	length statistic$2;
	length chinese$2;
	input name$ statistic$ chinese$;
cards;
SL 78 87
LY 90 69
;
run;

data mylib.C;
	length name$2;
	length statistic$2;
	length English$2;
	input name$ statistic$ English$;
cards;
YH 78 80
LJ 89 83
;
run;

data mylib.AB;
	set mylib.A mylib.B; /*合并数据集mylib.A和mylib.B*/
run;

proc print data=mylib.AB;
run;

data mylib.AC;
	set mylib.A mylib.C; /*合并数据集mylib.A和mylib.C*/
run;

proc print data=mylib.AC;
run;
```

 

### 2.4数据集横向合并

```
merge 数据集名称1 数据集名称 2…数据集名称n;
by 变量名称；
```

将多个数据集中的多个观测，按关键变量合并为结果数据集中的一个观测。

合并分为一对一合并和匹配合并

合并前必须把每个数据集根据关键变量排序

示例：Example2_8Merge

```SAS
/*数据集的横向合并*/
data mylib.D;
	length name$2;
	input name$ chinese$;
	cards;
YH 89
LJ 78
HL 92
;
run;

proc sort data=mylib.C out=mylib.C;
by name;
run;
proc sort data=mylib.D out=mylib.D;
by name;
run;
*横向合并数据集mylib.C和mylib.D;
data mylib.CD;
merge mylib.C mylib.D; /*横向合并数据集mylib.C和mylib.D*/
by name; /*设置关键变量为 name */
run;

proc print data=mylib.CD;
run;
```



### 2.5数据集转置

数据集的转置即把SAS数据集行列互换

```
PROC TRANSPOSE <DATA=输入数据集 OUT=转置数据集><选项列表>;
    VAR 变量列表；
    ID 变量；
    COPY 变量列表；
RUN;
```

示例：Example2_9Transform

```SAS
proc transpose data=mylib.A out=mylib.TA name=course;
/*将数据集mylib.A转置为新数据集mylib.TA，变量名name改为course*/
var statistic chinese; /*指定转置变量*/
id name;
run;

proc print data= mylib.TA;
run;
```



### 2.6 数据集的导入和导出

方法一 菜单法，建议使用

方法二

```SAS
/*如何导入导出文件*/

filename reffile="/home/u59452618/Homework/work1/homework1.xls";
proc import datafile=reffile  /*注意此处没有分号*/
	dbms=xls  /*注意此处也没有分号*/
	out=homework.work1;
	getnames=no;
run;


proc contents data=homework.work1; run; /*用来查看work1的属性*/
```



## 3. SAS函数

数学函数

字符函数

日期和时间函数

分布密度函数、分布函数

分位数函数

随机数函数

样本统计函数



示例：SAS函数.sas

```SAS
data mylib.funtest;
x=0;    
do i=1 to 100 by 1;  /*进行循环控制*/
	x=x+i;  /*计算求和*/
	y = normal(0);  /*生成正态分布随机数，其中0是缺省值，根据系统的时间确定随机数种子*/
	u = uniform(0)*100+1;   /*生成1~100均匀分布的随机数*/
	u1 = int(u);  /*对生成的随机数向下取整*/
	u2 = round(u);  /*对生成的随机数四舍五入*/
	output;  /*注意output的位置，会对输出造成一定的影响*/
end;
run;
title;  /*消除之前的标题*/
proc print;
	id i;  /* 以id所定义的变量代替观测序号*/
	var y u1 x;  /*在output窗口打印变量y,u1,x的值*/
run;
	
```



## 4. ODS输出系统

SAS的计算结果可以通过多种方式输出
主要输出形式 

RTF： 多文本文件格式。 

OUTPUT： SAS数据集格式。 

LISTING：传统的SAS汇总输出。 

HTML：超文本连接，网页格式。 

PRINTER：高分辨率打印输出格式

CSV: excel 逗号分隔格式；                                  

PDF： PDF格式输出

示例： HowToImportData.sas

```SAS
/*输出为csv格式*/
ODS listing close;    /*关闭SAS列表输出*/ 
ODS csv file='/home/u59452618/Chap2/outputtest.csv' ;    /*定义输出文档为: csv格式，并指明其位置*/
proc print data=mylib.funtest noobs;    /*noobs的作用是不用产生观测序号 no observation */              
	var  i x y u u1;                                                                 
run;                                                                                     
ODS csv close;      /*关闭SAS运算结果csv形式输出*/ 
ODS  listing; 

/*输出为pdf格式*/
ods listing close;
ods pdf file='/home/u59452618/Chap2/outputtest.pdf';
proc print data=mylib.funtest noobs;
	var i x y u1 u2;
run;
ods pdf close;
ods listing;
```

如何把结果输出为pdf格式

```SAS

ods printer pdf file ='odsprinter.pdf';
proc reg data=a;
   model y = x;
run;
ods printer close;

```
