prerequisites

```Makefile
g++ hello.c -g -o hello

```

## basic usage
gdb hello
`l` or `list`    list source code
`b` or `break`   set breakpint
`i`              information
`i b`            view information about breakpoints
`r` or `run` 
`p`           print
`p str`       print str's value
`n`           next
`c` or `continue`
`i locals` view local variables
`quit`

启动调试并传递参数

```

gdb --args <exe> <args>
set args <args>
r <args>

```

附加到进程 ->适用于程序已经启动

```
gdb attach <pid>
gdb --pid <pid>

```
只要我们知道pid，就可以附加到这个进程，进行调试，设置断点，查看变量


逐过程执行
`next`  step-over   遇到函数跳过函数

逐语句执行
`step` step-into     遇到函数进入



退出函数  `finish`
退出调试
`detach`  如果我们使用attach的方式进来，我们给detach后还继续运行，只是调试器退出了
`quit`    调试器退出，程序也结束了


断点操作

在源代码某一行设置断点 `b 文件名:行号`

> `b main.cpp:38`
>
>  `b main.cpp:46`
>
> 在38行和46行设置了两个端点

为函数设置断点      `b 函数名`  如果函数同名，会把同名函数全部设置断点

为满足regular expression的函数设置断点`rb 正则表达式`

> `rb work` 会把所有带有work的函数全部设置断点，如`test_work， person::work(), student::work()`都被设置了断点

设置条件断点       `b 断点 条件`

> `b main.cpp:14 if i==90`在第14行设置一个条件断点，仅当i==90时才会停下来


设置临时断点     `tb 断点` 断点命中之后，会立即删除（在循环中设置断点）

查看/禁用/删除 breakpoint

`i b` 是info breakpoint的简称，查看所有断点

`disable/enable 断点编号`   禁用/启用断点

`delete 断点`   删除断点


查看变量

`info args` 查看函数参数

`print 变量名 `   查看变量名

`set print null-stop `  设置字符串的显示规则

`set print pretty `    显示结构体

`set print array on`   显示数组

