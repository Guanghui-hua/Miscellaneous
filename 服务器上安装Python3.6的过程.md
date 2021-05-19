我一时没事做所以买了腾讯的服务器来玩,在CentOS7上搭建Pthon3.6环境
并安装numpy,pandas,matplotlib
目前好像找不到把画的图显示出来的方法，只能plt.save()来看
把过程记录下来，说不定哪一天就用到了
+ 下载python3.6.5
```
wget http://cdn.npm.taobao.org/dist/python/3.6.5/Python-3.6.5.tgz
```
+ 然后解压下载目录，进行解压
```
tar -zxvf Python-3.6.5.tgz
yum install -y gcc
yum install -y zlib*
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
```
+ 进入解压目录
```
cd Python-3.6.8
```
+ 设置安装路径并安装
```
./configure --prefix=/usr/local/python3 --with-ssl
```
+ 后面的不懂，不解释了
```
make
make install
```
+ 然后疯狂报错
```
ln -s /usr/local/python3/bin/python3 /usr/bin/python3
ln -s /usr/local/python3/bin/python3 /usr/bin/python3
```

+ 解决办法
```
ln -sf /usr/local/bin/python3.6 /usr/bin/python
```
注意：
然后想进入python必须输入**python3.6**而不是python


+ 输入接下来命令来使用pip3
```
 sudo ln -s /usr/local/python3.6/bin/pip3 /usr/bin/pip
```

同样注意：
想要使用pip安装模块需要使用   **pip3**而不是pip
```
sudo pip3 install numpy
sudo pip3 install pandas
sudo pip3 install matplotlib
```
+ 最后一个问题，没有找到可视化的方法
  
对于plt.show()没有用
如果用到matplotlib模块作图，会无法显示图片弹窗（即plt.show()没用），
只能委曲求全选择`plt.savefig(path, 'plot.png')`存到本地来看。
可能的原因是没有安装tkinter模块。
但是安装好难，我放弃了