# 如何在一台新电脑上添加github的ssh公钥

大概原理

使用 git 在自己电脑上生成一个`id_rsa`和`id_rsa.pub` 两个文件

然后复制`id_rsa.pub`中的到github中生成一个ssh公钥

具体步骤及代码 

可以看链接 [操作链接](https://blog.csdn.net/qq_43705131/article/details/107965888)

```
1.设置用户名
git config --global user.name ‘用户名’

2.设置用户名邮箱
git config --global user.email ‘你的邮箱’

3.查看设置
git config --list

4. 然后继续输入命令:修改后面的邮箱即可
ssh-keygen -t rsa -C "你的邮箱"

```

然后是github的操作

+ 进入主页 -> settings  -> SSH and GPG keys ->随便取一个title 

+   -> 找到自己电脑的.ssh文件夹下的`id_rsa.pub`文件，然后复制里面的内容到github中，然后点击 Add SSH keys 就完成了

