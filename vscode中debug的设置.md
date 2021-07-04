# 如何设置vscode中的debug环境 

今天我在我的服务器上设置自己的环境，  

不同的语言都可以使用vscode进行编辑，可以进行debug进行调试，但是要配置好launch.json和tasks.json两个文件  

其中tasks.json应该是用来编译文件的，其中有很多可以设置的地方，但是目前还没有完全搞懂  

其中具体看法参照`vscode配置环境中的launch.json`和`vscode中配置环境的tasks.json`两个解释的内容

记录一个我在服务器上面的一个问题：  
一直提示我`miDebuggerPath is valid` 看了一下 `miDebuggerPath`是`/usr/bin/gdb`后来到目录里面看了一下，  
原来是没有`gdb`这个东西，所以就`sudo apt -y isntall gdb`，后来就好了，这是我处理的一个问题
