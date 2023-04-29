"一般设定
"""""""""""""
" 设定默认解码
  set fenc=utf-8
  set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
" 不要使用vi的键盘模式，而是vim自己的
  set nocompatible

" history文件中需要记录的行数
  set history=500

" 在处理未保存或只读文件的时候，弹出确认
  set confirm

" 与windows共享剪贴板
  set clipboard+=unnamed

  " 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
  "set mouse=a
  "set selection=exclusive
  "set selectmode=mouse,key


" 侦测文件类型
  filetype on
 
"显示风格
"""""""""""
"语法高亮显示
  syntax on
"修改注释颜色
  highlight Comment ctermfg=Cyan
"高亮显示当前
  set cursorline
"启用行号
  set number
"Tab键的宽度
  set tabstop=4
"自动缩进
  set autoindent
"使用C语言的缩进方式，根据特殊字符如“{”、“}”、“:”和语句是否结束等信息自动调整缩进；在编辑C/C++等类型文件时会自动设定；使用 nocindent 取消设置；
  set cindent
  set smartindent

"统一缩进为4
  set softtabstop=4
  set shiftwidth=4
"不要用空格代替制表符
  set noexpandtab
" 带有如下符号的单词不要被换行分割
  set iskeyword+=_,$,@,%,#,-

" 高亮字符，让其不受100列限制
  :highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
  :match OverLength '\%101v.*' 
" 状态行颜色
  highlight StatusLine guifg=SlateBlue guibg=Yellow
  highlight StatusLineNC guifg=Gray guibg=White
" 文件设置
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 不要备份文件（根据自己需要取舍）
  set nobackup

" 不要生成swap文件，当buffer被丢弃的时候隐藏它
  setlocal noswapfile
  set bufhidden=hide

" 字符间插入的像素行数目
  set linespace=0

" 增强模式中的命令行自动完成操作
  set wildmenu

" 在状态行上显示光标所在位置的行号和列号
  set ruler
  set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

" 命令行（在状态行下）的高度，默认为1，这里是2
  set cmdheight=2

" 使回格键（backspace）正常处理indent, eol, start等
  set backspace=2

" 允许backspace和光标键跨越行边界
  set whichwrap+=<,>,h,l
" 启动的时候不显示那个援助索马里儿童的提示
  set shortmess=atI

  " 通过使用: commands命令，告诉我们文件的哪一行被改变过
  set report=0

  " 在被分割的窗口间显示空白，便于阅读
  set fillchars=vert:\ ,stl:\ ,stlnc:\

" 搜索和匹配
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 高亮显示匹配的括号
  set showmatch

  " 匹配括号高亮的时间（单位是十分之一秒）
  set matchtime=5

  " 在搜索的时候忽略大小写
  set ignorecase

  " 不要高亮被搜索的句子（phrases）
  set nohlsearch

  " 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
  set incsearch

  " 输入:set list命令是应该显示些啥？
  set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

  " 光标移动到buffer的顶部和底部时保持3行距离
  set scrolloff=3

  " 不要闪烁
  set novisualbell
