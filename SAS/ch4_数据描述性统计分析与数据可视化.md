# 数据描述性统计分析与数据可视化

 描述性统计分析指标 `means/univariate`过程

常见统计图 `gplot/gchart`过程

# 描述性统计分析指标

## 1. 基本统计分析指标

## 2. means过程

```
一般使用格式
proc means data=sas数据集 <选项列表>;
	var 变量列表;
	by 变量列表;
	freq 变量;
	weight 变量;
	id 变量列表;
	... /* 指定输出统计量 */
	output <out=输出数据集名> <统计量关键字=变量名列表>;
run;
```

means过程的关键字，略



## 3. univariate过程

指定计算参数、功能输出统计量

```
proc univariate data=sas数据集<选项列表>;
	var 变量列表;
	by 变量列表;
	freq 变量;
	weight 变量;
	id 变量列表;
	output <out=输出数据集名>  <统计量关键字=变量名列表>;
run;
```



```SAS
proc means data=... maxdec=2;  /* 输出结果保留两位小数 */
	var count; /* 指定分析变量为count */
run;

proc univariate data=... plot;  /* 调用univariate过程，输出茎叶图、箱线图和正态概率图 */
	var count;
run;
```



# 描述性统计图形

## 1. 常见统计图形介绍

条形图、圆饼图、直方图、折线图、散点图

## 2. gplot过程

```
proc gplot data=数据集;
	plot 纵坐标变量Y*横坐标变量X ......</选项列表>;
	symboln <选项列表> ;
	axisn <选项列表>;
run;
```

## 3. gchart过程

```
proc gchart data=数据集;
	vbar ...;
	hbar ...;
	block ...;
	pie ...;
	star ...;
	by ...;
run;
```

```SAS

proc gplot data=...;  /*调用gplot绘图过程*/
    plot sbp*age/vaxis=axis2 haxis=axis1;  /* 定义绘图变量，指定两个方向的坐标轴 */
    symbol v=star i=none c=black;  /* 指定用黑色星形表示数据、数据间不连接 */
    axis1 label=('age') order=(20 to 64 by 4); /* 定义坐标轴1的标签和刻度 */
    axis2 label=('systolic blood pressure') order(100 to 160 by 10); 
run;
```











