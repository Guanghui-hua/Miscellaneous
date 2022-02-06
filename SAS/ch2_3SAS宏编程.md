# SAS宏编程

宏：重复的事情交给程序

到底什么是宏？

宏（Macro）是一种批量处理的称谓。（维基百科）

宏根据一系列`预定义的规则`特换一定的文本格式。（计算 机科学）

SAS宏工具是SAS系统的重要编程工具，功能强大，可以 给一个变量、一段程序、一段文本命名，供以后调用，是 编制用户化的SAS系统的重要工具。

使用宏工具来完成以下任务：

+ 执行重复性任务
+ 使用宏变量实现文本替代  -->其他语言中的字符串功能
+ 使用宏产生程序语句
+ 使用宏循环以及条件判断语句完成程序交互

# 1. 宏变量

+ 宏变量是SAS宏语言中用于存储一段字符串的SAS命名

+ 宏变量的主要用途是进行SAS文本替代

  ​	不区分字符型和数值型，系统自动识别

+ SAS宏变量分类

  - 用户定义宏变量 -->用户根据自己需要定义的宏变量
  - 自动宏变量 -->SAS系统提供的可以引用的宏变量

## 1.1  定义和引用宏变量`%let 宏变量名=值`

 自定义宏变量：`%let 宏变量名=值`

系统自带宏变量：`sysdate` `sysday` `systime` `syslast` `sysdsn` `sysver` `sysscp`

## 1.2 宏引用：`&宏变量名`

示例：

```SAS
* Example_MVar 宏变量示例;
%let data=sashelp.class;  /* 定义宏变量data,data表示一个数据集，若处理不同的数据集，给它赋予不同的值 */
proc print data=&data;  /*第一次引用宏*/
title "Display of Data set &data"; /* 第二次引用宏 */
run;
```



## 1.3 显示宏变量以及宏变量的值  `%put`

```SAS
* example_MVar2 显示宏变量;
%put _user_;  /* 显示用户定义的宏变量 */
%put _automatic_;  /* 显示系统提供的自动宏变量 */
%put _all_;  /* 显示所有宏变量 */
```

```SAS
*example_MVar3 显示指定宏变量的值;
* %put &宏变量名;
%put &data;
%put this is my test:&data;
```



## 1.4 间接引用宏变量

`&宏变量名`来引用宏的方式是直接引用，如果引用的宏变量名是通过宏产生的，则需要间接引用，此时需要用 `&&` 

```SAS
*example_MVar4 间接引用宏变量;
/*例如，有三个宏变量：data1，data2, data3，只是末尾 数字不同。采用下列方式引用时，需用间接引用方式。*/
%let data1=x; %let data2=y; %let data3=z;
%let i=1; %put &&data&i;  /* &data&i不能用 */
%let i=2; %put &&data&i;
%let i=3; %put &&data&i;
```
## 1.5 宏变量嵌套使用

!!! **宏变量可以是变量，可以是数据集，可以是过程**

```SAS
* example_MVar5 宏变量嵌套使用;
%let exa=score; /* 定义宏变量exa */
%let xvar=math;
%let yvar=phys;
%let plot=%str(
				proc gplot;
				plot &yvar*&xvar;
				run;
				)  *引用宏变量xvar与yvar定义宏变量plot;
data score;
input math phys@@;
cards;
91 81 98 65 70 92 60 65 85 91
;
run;

data temp;
set &exa;  /* 引用宏变量exa */
run;

&plot;  /* 引用宏变量plot */
```

宏变量可以是变量，如`xvar`,`yvar`; 也可以是数据集，如`exa` ，也可以是过程，如`plot`



这里解释一下程序中`@@`这个符号的意思

>SAS 中的@是指针控制符。用来规定指针的位置，
>
>@numerical expression的话，就是把指针移动到该expression所指向的位置。
>
>如果@在input语句末尾，则代表将指针停留在数据行的末尾直到执行下一个input语句。
>
>如果是@@在input语句末尾，则代表将指针停留在数据行的末尾直到执行下一个data步。
>
>举一个例子就明白了：
>
>data score1;
>	input a b @@; 
>	cards;
>	31 76 76 92 62 37
>;
>run;
>
>这段程序我刚开始没有加上@@，结果数据显示的时候只是显示了31 76 两项，因为只给了 a 和 b两个变量，结果如下所示
>
>a    b 
>
>31 76
>
>后来我加上@@之后，发现6个数据全显示了，
>
>a    b 
>
>31 76
>
>76 92
>
>62 37
>
>这样应该能够比较容易理解@@这个符号的含义了



# 2. 宏程序 `%macro 宏名称 ...... %mend 宏名称`

宏是被存储的文本，用一个名字去识别它，可以从SAS程序中调用执行.

```SAS
%macro 宏名称;   /* 表示宏程序的开始 */
	宏文本...;   /* 宏的主体部分 */
%mend 宏名称;   /* 宏程序的结束 */
```

宏定义语句提交运行后，SAS只是编译这段程序，如果有错，则会在log窗口提示；

如果没有错误，则将编译之后的宏储存到work.sasmacr目录中（默认），但不会执行宏

示例：创建一个宏myprint，其功能为打印最近建立的SAS数据集

```SAS
*example_macro1 创建宏程序;
%macro myprint;
	title "the data of syslast";
	proc print data=&syslast;
	run;
%mend;
```

## 2.1 调用宏格式： `%宏名称`

```SAS
* example_macro2 调用宏程序;
%myprint;
```

## 2.2. 宏参数：让宏程序活起来

创建宏：

>%macro 宏名称（宏参数）;
>	宏实体;
>%mend 宏名称;

宏调用：

> %宏名称（参数）

示例：

```SAS
%macro printClass(dset);
	proc print data=&dset;
	title;
	run;
%mend printClass;


data score1;
	input a b @@;
	cards;
	31 76 76 92 62 37
	;
	run;
	
/* 调用宏，参数为score1，打印不同的数据集，只要调用宏并利用参数指定的数据集即可 */
%printClass(score1)   
```



## 2.3 位置参数

位置参数：调用时需严格按位置顺序指定参数的值

```SAS
*example_macro4 创建与调用带位置参数的宏;
%macro myprint2(dataset,var1,var2);
	proc print data=&dataset;
        title;
        var &var1 &var2;
	run;
%mend;

*调用宏myprint2，依序指定参数的值;
%myprint2(sashelp.class,name,sex)
```

说明：参数与参数之间用逗号分隔，引用时，依序给出三个参数的值

## 2.4 关键字参数的定义与调用

命名和调用时用等号（=）指定参数名称与值的参数为关键字参数，此时可以给参数赋初值

示例：

```SAS
* example_macro5 创建与调用带关键词参数的宏;
* 创建宏，带关键词参数;
%macro myprint3(dataset=,varlist=);
	proc print data=&dataset;
		var &varlist;
	run;
%mend;

* 调用宏，指定参数;
%myprint3(varlist=name sex, dataset=sashelp.class);

%macro myprint4(dataset=,varlist=_numeric_);
	proc print data=&dataset;
		var &varlist;
	run;
%mend;

%myprint4(dataset=sashelp.class)
%myprint4(dataset=sashelp.class,varlist=name sex)
/* 该宏默认时打印指定数据集中的所有数值型变量；
也可以设置默认数据集为系统最新建立的数据集（dataset=&syslast） */
```



## 2.5 一个很好的例子

由SAS生成一个100000个服从正态分布的随机数，并对生成的样本作描述性统计分析和分布拟合检验

```SAS
%macro ran(dataset,seed,varname,n);
	data &dataset;
		do i=1 to &n;
			&varname = normal(&seed);
			output;
		end;
	run;
%mend;

%ran(rannor,0,r,100000);
proc univariate data=rannor normal plot;
	var r;
	histogram r/normal;
run;
```



## 2.6 宏内流程控制结构

### 2.6.1 计数型循环

> %do  循环变量=初值  %to  终值  [%by  步长]
>
> ​	循环体;
>
> %end;

**循环变量是一个宏变量，在宏定义的内部使用**



一个示例：

```SAS
*example_macro_do1  计数型循环;
%macro dotest1;
    %do i=1 %to 5;
    %put this is a test for do_loop: &i;
    %end;
%mend;

%dotest1;
```



```SAS
*example_macro_do2  生成重复文本;
*提交data步之后得到5个数据集 AB1 AB2 AB3 AB4 AB5，但是其中都没有变量和观测

%macro dsn(name,num);
	%do i=1 %to &num;
		&name&i;
	%end;
%mend;

*在data语句中调用宏dsn;
data %dsn(AB,5); run;
```

### 2.6.2 until型循环

> %do  %until(表达式);
>
> ​	循环体;
>
> %end;

### 2.6.3 while型循环

>%do  %while(表达式);
>
>​	循环体;
>
>%end;

当型循环和直到型循环需设置一个宏变量作为循环变量，对循环变量累加赋值时需使用函数`%eval( )`来计算算术表达式的值。

### 2.6.4 条件判断语句

> %if  表达式  %then 语句1;
>
> ​	%else 语句2;

或者复合语句

>%if 表达式  %then  %do;
>
>​		语句组;
>
>%end;
>
>​	%else 	%do;
>
>​		语句组;
>
>%end;
>

# 3. 宏函数

宏功能包括很多宏程序语句和宏函数，下面列出几个常用的：

| 函数名    | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| %eval     | 计算算术和逻辑表达式  整数格式                               |
| %sysevalf | 计算算术和逻辑表达式  浮点格式                               |
| %sysfunc  | 调用数据步函数，功能强大`%SYSFUNC(数据步函数(参数)，<输出格式>)` |
| %str      | 引用除%和&外的固定文本                                       |



# 4. 宏的调用与储存

用户自定义的宏可以存储在指定的逻辑库中， 供其他程序调用。
SAS会自动将用户自定义的宏存储在临时逻辑库work的文件夹sasmacr中。
用户也可以将自定义的宏存储在指定位置的永久逻辑库中。
（1）系统选项语句：
`OPTIONS MSTORED SASMSTORE=指定逻辑库；`
（2）在宏定义语句中使用选项： `/STORE SOURCE DES=指定逻辑库`



用户可以调用存储于指定逻辑库中的宏，分为直接运行宏和查看宏代码两种方式。
（1）直接运行存储的宏：
OPTIONS MSTORED SASMSTORE=指定逻辑库； 

指定系统搜索宏的位置，再调用宏即可。
（2）查看宏代码： %copy 宏名称  /source;
即可在log窗口查看所存储的宏的代码。



# 5. 宏编程举例

