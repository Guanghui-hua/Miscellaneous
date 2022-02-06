# proc步的大体框架

## 1. SAS的优势在哪里？

用户在数据步中编写SAS程序来读入、处理和描述数据以创建符合要求的SAS数据集，此后基于数据集可以调用SAS的过程步进行分析

===========**对于许多常用的和标准的统计方法，可以调用SAS系统自带的相应过程步，只有非常特殊的统计方法才需要自主编程**================

所以说，SAS的优势地位在于常用方法的权威性，对于非常用方法，那么它的使用就少了一些灵活

SAS过程步的一般格式为：

```
proc [过程步名称]  [data=data步整理好的数据集] [选项];
	过程语句1  [选项];
	过程语句2  [选项];
	......
	过程语句n  [选项];
run;
```

过程名指定SAS过程的名字，例如means 过程

[选项]规定在分析过程中的特定计算要求，不同的过程规定的选项格式也不一样，例如

+ keyword      		 	第一种选项格式是某个具体过程进一步要求某个关键字;
+ keyword=数值        某个具体过程要求某个关键字的值，值可能是数值或者字符串;
+ keyword=数据集    某个基本过程要求输入或者输出数据集;

下面介绍在proc步中常用的语句

## 2. `var` `model` `by` `class`语句

var语句被用来指定需要分析的变量，如果指定多个 变量，变量之间用空格隔开，其语句格式为

`var [变量列表]` 



model 语句在统计建模中指定模型的形式，其语句格式为

`model 因变量=自变量列表/选项;`



by语句可用在对数据集进行分组处理，**要求数据集事先按by变量进行排序（可以使用sort语句排序）**

` by <descending> 变量1 变量2 ...... 变量k`



class语句用来指定一些分类变量，其语句格式为

`class 变量列表`



class语句和by语句的区别在于：

使用class语句不要求数据集事先按照class指定的变量排序，按指定变量的不同值进行分类计算和分析后，输出的分类结果列在一张报表里，而by语句在使用时，要求数据集事先按by指定的变量排序，且输出的结果也按照分组列出许多报表

## 3. `where` `freq` `weight`语句

where语句用于选择输入数据集的子集进行分析

freq语句用来指定一个代表观测出现的频数变量

weight用来指定一个代表观测的权重

## 4. `output` `format` `label` `id`语句

output语句经常用来指定输出结果存放的数据集

format用来指定变量的输出格式

label语句用于为变量指定标签，注意在data步和proc步中都可以用format、label语句，但是在data步中规定的变量属性是永久的，而在proc步中规定的变量标签只对本次过程有效

id语句用来指定用于识别观测的一个或几个变量，使用id语句后，在左边的sas默认输出的观测列被id语句所指定的变量替代



# proc步的一些基础功能



重点：
1. 数据步的基本语法
2. 数据整理进阶1
连接、查重、导入、导出、显示数据
3. 数据整理进阶2
使用SQL过程整理数据集

##  过程步的概念和分类

proc是一系列SAS预定义好的过程， 一般需要SAS数据集作为输入源。

proc可以用来分析数据和生成统计 参数、统计报告、统计图表或管理 文件和数据集。

每个proc都包含了大量可以修改的参数，用以获得不同的统计结果。

**SAS的过程步大致可以分为`图表`、`统计`与`功能`3类**

具体可以看上传到百度云的教材

## 1 数据集的连接(append)

在data步中尝试使用set语句，可以实现数据集的"纵向连接"

proc中的append可以通过在base指定的基准数据集上追加data指定的补充数据集，实现数据集的纵向连接

```SAS
* 将sashelp中的workers数据集拆分成两部分，再用append过程连接成一个数据集
data workers1 workers2;
    set sashelp.workers;
    if _n_ <=20 then output workers1;
    else output workers2;
run;
proc append base=workers1 data=workers2;  /*可以通过在base指定的基准数据集上追加data指定的补充数据集，实现数据集的纵向链接*/
run;
```

## 2 数据的排序与查重(sort)

`proc sort `的排序和查重功能，是`proc`的重要用法,对于排序功能，`proc sort`可以指定多个变量按照不同的顺序排列,**查重功能可以保证数据的有效性**

### 2.1  在`proc sort`中加入`Where`实现在指定范围内排序

```SAS
* 在sashelp中的class数据集中对大于12岁的学生按身高排序;
proc sort data=sashlep.class out=class_age;
    where age>12;
    by height;
run;
```



```SAS
/* 在sashelp中的class数据集中，按性别进行统计分析，使用by或class语句，注意两者的区别 */
proc sort data=sashelp.class out=class;
	by sex;
run;

proc means data=class;
    var height weight;
    class sex;
run;
```



### 2.2 `sort`数据的查重功能

   （1）在过程步`proc sort`中使用`nodup`选项，可以实现查重功能，`Nodup` 是 no duplicate 的缩写，表示无重复。此时 proc运行时会对比每条记录的每个变量，如果发现某两 条记录的所有变量完全相同，则会删除重复的记录。若需要输出重复的记录到另外一个数据集，可以使用 `dupout=`。

```SAS
/* 对比数据集dose中的所有记录的每个变量，如果发现某两条变量记录的所有变量完全相同，则删除重复的记录，*/
/*将删除的记录完整的保存到数据集dupdose中，*/
/*数据集dose2为查重整理后的结果数据集 */
data dose; /* 创建记录注射次数与计量的数据集dose */
	input id time dose;
	cards;
	1 1 12
    1 2 10
    1 2 10 
    2 1 15
    2 2 15
    3 1 10;
    run;
proc sort data=dose out=dose2 nodup dupout=dupdose;
	by id;
run;
```

**注意sas中的选项：**

选项是在`proc`中使用，可以对`proc`功能进行整体性修改，它们与语句不同，一般放置在`proc`语句之内，作为sas预定义的功能参数，可以改变proc执行的结果



（2）proc sort 的查重功能不仅局限于删除完全重复的记录，**也可以指定对比的变量**然后进行查重

假设需要获取每名患者的id号，则可以使用by语句

```SAS
*指定对比的变量为患者的id号，进行查重;
proc sort data=dose out=dose3 nodupkey dupout=dupid;
	by id;
run;
```

`nodupkey`与`nodup`不同，它只查看`by`后面所接的变 量，如果该变量有超过一条的记录，那么只保留第一条， 多余的则被舍弃。
被nodupkey筛选掉的记录也可以使用`dupout=输出`



## 3 数据的输出(print)

数据输出可以简单地分为输出到SAS输出(output)窗口和输出到外部文件

output窗口是SAS存放统计分析结果(主要是proc的生成 结果)的地方，将数据输出到output窗需要用到`proc print`语句， `print`是SAS中最简单的proc语句, 它的功能是在结果栏打印数据集, 基本语法为: 

> proc print data=;
>
>  run;
>

指定“data=”后的数据集名称，即可完成最基本的数据 集打印操作。

`print`过程可以将SAS数据集打印到output窗口之中，并且可以自由筛选数据并添加表头、脚注，还可以进行简单的求和计算

|   语句    | 用途                             |
| :-------: | :------------------------------- |
|    var    | 指定输出的变量                   |
|   where   | 筛选输出的记录                   |
|   label   | 将变量名改为标签输出             |
|   title   | 设定表头                         |
| footnote  | 设定脚注                         |
|   noobs   | 不输出记录序号，只输出数据集本身 |
|    sum    | 在表的尾部输出数值型变量的和     |
|    id     | 设定用于id的变量以代替记录序号   |
| firstobs  | 指定第一条输出内容               |
|    obs    | 指定最后一条输出内容             |
|   page    | 按照某变量分页                   |
|  format   | 设定输出变量的输出格式           |
|  split=   | 设定文本中的分隔符               |
| sumlabel= | 设定求和结果的标签               |



## 4 数据的导入与导出

+ import过程、data步+infile语句将外部数据导入SAS;

+ Export过程将SAS导出为其他格式的数据

+ sas7bdat是SAS存储数据的文件的格式，每个文件最小占128KB或 256KB

+ 以sas7bdat为扩展名的文件可以被 SAS直接打开，但工作中遇到的数据有时不是这种格式。因此将各式各样的数据读取到SAS之中就成了数据 分析的第一步。



### 4.1 `proc import`是读取外部文件的一种方式

`proc import`的基本语法为：

```
proc import datafile='文件路径\文件名.文件后缀'  out=输出数据集 dbms=数据格式; 
/* 注意这都是没有分号结尾的 */
run;
```

`datafile=`、 `out=`和`dbms=`是import过程必须包含的内容,三者缺一不可；

`datafile=`用于指定文件的路径、名称和扩展名

`out=`用于指定输出数据集

`dbms=`指定数据的格式，这是SAS系统预定义的数据格式



### 4.2 `data步+infile`语句是将外部数据导入SAS的另一种方式。

 infile 语句可以让data步读取数据文件，同时定义数据文件的格式、缺失值、分隔符等信息。

它的语法为: `infile“文件路径\文件全名“ dlm=控制符;`
在data步中，使用`infile`指定输入的文件名和路径，然后用`input`语句指定变量名称。

```SAS
data read; /* 创建数据集read */
    infile "...";  /* 应该填写文件路径和文件全名 */
    input date$ electric masonry; /* 指定变量名称与类型 */
run;

data read1;
    set read;
    date1=input(date,monyy5.); /* 将字符型变量date转换为数值型，重新命名为date1 */
run;
```

### 4.3 如果只使用一次文件，在infile中定义文件路径是最简单的方法； 

若需要多次使用该文件，修改的时候就需要每个地方都进行修改，使用filename语句可以给文件创建别名，再用到此文件的时候只需要修改 filename中的内容就可以了。

**注意filename既不属于data步，也不属于proc，而是独立于它们之外的语句。**

```SAS
filename 文件索引 "路径/文件名";
data read2;
	file 文件索引;
	input date$ electric masonry;
run;
```

先使用filename语句创建了一个名为txt的**文件索引**，在infile语句中直接用txt代替一长串的文件名和文件路径。



### 4.4 Export过程将SAS导出为其他格式的数据。
SAS的很多语法都是相互对应的结构，例如format和informat、input 和put, 

proc import用于输入外部文件, proc export则表示输出到外部文件。

proc export的基本语法为:

```
proc export data=数据集名称 outfile="文件路径\文件名“ dbms=输出类型;
run;
```

举例：将SAS数据集 sashelp.air导出为CSV格式的文件，保存在zjxsas 文件夹中名称为air.csv的文件中。

## 5. 读取数据库和逻辑库信息

在一个数据分析项目运行期间，为了保证项目的可靠性，需要进行的一些数据分析之外的工作，这些工作往往需要对数据集和逻辑库进行操作，善用适当的proc可以可观地降低我们的工作量、 提高工作效率。利用contents和datasets过程，针对数据集和库本身进行操作，管理数据集和逻辑库。包括**数据集和库的信息的查看、修改、删除**等。

### 5.1 contents过程

contents的功能是获取数据集的信息，基本语法：指定数据集即可获得数据集的信息。

```SAS
proc contents data=sashelp.workers;
	out=info_workers directory;
run;
```

contents过程的运行结果：

(1) contents过程执行信息，包括数据集的一些基本信息，包括创建时间、修改时间、记录数、变量数等。

(2) 引擎/主机相关信息，它主要包含操作系统和SAS版本的信息。

(3) 数据集中变量的细节信息，也经常是我们使用proc contents 的主要目的。每条记录包括了变量的序号、名称、类别、 长度、格式和标签。
注：
选项 ` out=info_workers `将该数据集的主要信息存入指定数据集； 

选项 `directory `提供数据集所在逻辑库中其他数据集的信息。



### 5.2 datasets 过程 ”万能过程“

datasets主要功能是管理库与库中的数据集。分为4类：
（1）获取SAS逻辑库信息，是datasets的基本功能。
（2）修改数据集中变量的信息。因为是修改而非重新生成，因此它占用的系统资源也比重新生成的数据集要小得多。
（3）修改SAS数据集的信息。实现如对数据集添加标签、进行加密等处理。
（4）管理SAS文件。包括复制、版本控制等。

datasets语法：

```
proc datasets lib=库名;
quit;
```

从上面可以看出，我们有两个需要注意的地方：

+ 因为`proc datasets`是针对库进行操作，所以不用`data=`操作，而是用`lib=`
+ proc datasets对应的结尾是`quit`而非`run`，因为它是一个复杂语句，可以使用`run`表示阶段运行，所以最终的结尾需要使用`quit`

```SAS
/* 获取逻辑库sashelp的信息 */
proc datasets lib=sashelp memtype=data;
quit;
```

注意：
（1）运行结果与`proc contents `加上`directory`选项后的结果基本相同，只是不包含具体数据集的变量信息。
（2）选项`memtype=data`指定仅显示逻辑库中的数据集成员，与`proc contents`选项相同。
（3）datasets过程还集成了大量其他过程的功能，如可以在这个过程中使用`contents`语句查看某个数据集的信息。

```SAS
/* 获取逻辑库sashelp信息，并且查看其中数据集shoes的信息 */
proc datasets lib=sashelp memtype=data;
	contents data=shoes;
run;
```



```SAS
*修改数据集shoes中变量returns信息,修改格式、标签并且 重新命名;
data=shoes;
	set sashelp.shoes;
run;

proc datasets lib=work;
	modify shoes;
        format returns comma10.2;
        label returns="Total earnings";
        rename returns=earnings;
run;
quit;

```



datasets还可以为数据集设置密码nosee;

```sas
proc datasets lib=work nolist;
	modify shoes(pw=nosee);
quit;
```

还可以进行删除和修改密码：

在`pw=`选项后按照`老密码/新密码`的格式重新输入密码，例如`(pw=nosee/)`即可删除原密码，`(pw=nosee/notsee)`则将原密码nosee改为新密码notsee

```SAS
*为数据集shoes的读取权限和修改权限分别设置密码;
proc datasets lib=work nolist;
	modify shoes(read=noread alter=nochange);
quit;

data shoes1;
	set shoes; rate =earnings/sales;
run;


```

上面的例子为读取设置的密码为noread，使用data步中的set语句读取该数据集时，就需要使用noread密码；对数据集进行修改时，则需要使用nochange密码。两者相互独立，拥有不同的权限，可以更好地保障数据安全。 

## 6.在SAS中使用SQL

SAS中，可以在sql过程中使用sql语言

sql过程基本的语法

```
proc sql;
	select 变量;
	from. 数据集;
	where筛选条件;
	group by分组变量;
	having-分组后条件;
	order by排序变量;
quit;
```

注意：

+ sql过程和datasets过程一样，都是以quit结尾，因为它们内部都具有复杂语法，内部都有延申功能
+ 为了保持sql语言的原汁原味，在sql过程中，变量和数据集分隔符是逗号

