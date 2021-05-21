尽量每天学一点Linux命令，以至于后来能够熟练使用服务器

<<<<<<< HEAD
=======
ls -a  查看该级目录里面所有的文件   

+ 目录处理命令： mkdir  
命令英文原意： make directories  
命令所在路径： /bin/mkdir  
执行权限： 所有用户  
语法： mkdir -p\[目录名\]  
功能描述： 创建新目录  

不能在不存在的目录下面创建子目录  
` mkdir /tmp/study/math `   会报错，因为没有/study目录，所以不能创建/math  
` mkdir -p /tmp/study/math `  这样就不会报错，因为加上 -p 之后可以递归创建  

使用命令行可以同时创建两个目录  
` mkdir /tmp/study/math /tmp/study/computer `   
+ 目录处理命令  
命令名称： cd    
命令英文原意： change directory    
命令所在路径： shell内置命令    
语法： cd\[目录\]    
使用这个命令可以进入任意一个目录，注意需要使用完整目录    

有一个问题是进入此目录后只能显示当前最近一级目录    
使用 **pwd** 就可以显示当前目录的绝对路径    
` cd .. ` 回到上一级目录，注意cd后面要加上空格    

+ 删除空目录：  rmdir
remove empty directory  
rmdir 目录名称  
注意只能删除空目录  

+ 复制文件或者目录：  cp
即copy  
命令所在路径： /bin/cp  
语法：  cp -rp 原文件或目录  目标目录  
          -r  复制目录  
          -p  保留文件属性  
也可以同时添加多个目录名称，同时复制  
复制的时候可以同时改名  

+ 剪切文件、改名  mv
原意： move  
语法： mv 原文件或目录  目标目录  
>>>>>>> 751d7d8ed31b567aefb75a6e523d3c8b7b058195
