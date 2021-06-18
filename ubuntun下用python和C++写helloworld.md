# ubuntun下用python和C++写helloworld.md

首先要下载vim，是linux下的文本编辑器，命令是 `sudo apt install vim` （感觉这个和pip install 有点像，linux下安装好像都用这个）
1. 创建一个hello.py 或者 hello.cpp 文件，方法是使用 `touch 文件名`的命令  
2. `vim hello.cpp`
3. 输入 `i` 表示Insert  
4. 开始编辑你的程序吧
5. 编辑完成之后，需要按 `Esc`键，然后 `:wq`，注意不要忘记 `:`

这样就完成了一个脚本的创建过程，而后编译即可
python的话是 `python hello.py`  
对于C++需要先安装g++编译器，命令`sudo apt install g++`  
然后 `g++ hello.cpp`而后当前文件夹内生成一个`a.out`文件    
运行的时候需要输入`./a.out`才算是最终的运行
