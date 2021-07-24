# apt 终端命令

apt 是 Advanced Packaging Tool，是 Ubuntu 下的 安装包管理工具

大部分 的软件 安装/更新/卸载 都是利用 apt 命令来实现的

直接在终端中输入 apt 即可以查阅命令的帮助信息

常用命令如下：

+ 1. 安装软件 $ sudo apt install 软件名

+ 2. 卸载软件 $ sudo apt remove 软件名

+ 3. 更新可用软件包列表 $ sudo apt update

+ 4. 更新已安装的包 $ sudo apt upgrade

## <1> 软件更新和升级

通常安装完 ubuntu 之后，可以先使用 upgrade 更新一下当前系统中可以升级的的软件包

sudo apt update

sudo apt upgrade

如果增加、更换了软件源，通常需要使用 update 更新一下本地缓存

## <2> 安装常用工具

apt 安装命令的格式是不需要记忆的，如果在终端中输入的软件没有安装，系统会提示 apt 命令 的使用格式

python

sudo apt install python

sudo apt install python3

sudo apt install python-pip

sudo apt install python3-pip

安装 ssh 服务器

sudo apt install openssh-server

安装之后，才可以在其他系统中，通过 ssh 工具远程登陆。

## <3> 删除不使用的软件

我们如果在安装系统时选择正常安装，安装后系统会自带很多软件，我们有的软件不需要我们就得会卸载这些软件

libreoffice

libreoffice是一套类似于微软 Office的 免费的 办公套件

不过无论是界面交互还是执行性能都还有很大的提升空间

卸载 libreoffice 可以释放大概 300M 的磁盘空间。

卸载方法：

sudo apt remove libreoffice-common

Amazon

Amazon是亚马逊购物软件

卸载方法：

sudo apt remove unity-webapps-common

## <4> apt 和 apt-get

apt 和 apt-get 都是 ubuntu 下常用的安装软件的命令

早期 使用 apt-get，从 ununtu 16 开始，官方建议使用 apt

这两个命令的 使用方式非常类似

deb 安装格式

deb 是 Debian Linux 的安装格式，在 ubuntu 中同样可以使用。要安装 deb 安装包，需要使用 dpkg 这个终端命令，命令格式如下：

sudo dpkg -i <package.deb>

1>谷歌浏览器

从 https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 下载最新版本的安装文件
在终端中执行以下命令：

sudo apt install libappindicator1 libindicator7

sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo apt -f install

2> 搜狗输入法

fcitx 被称为 小企鹅输入法，是一个以 GPL 方式发布的 输入法平台，可以通过安装引擎支持多种输入法。它的优点是，短小精悍、跟程序的兼容性比较好！

打开 系统设置 语言支持

将 键盘输入法系统 修改为 fcitx

在新装的系统中没有fcitx，所以我们得先安装fcitx

sudo apt install fcitx

安装完成后就可以安装输入法了

访问网站 http://pinyin.sogou.com/linux/ 下载最新版本的安装文件

在终端中执行以下命令：

sudo dpkg -i sogoupinyin_2.2.0.0108_amd64

sudo apt -f install
