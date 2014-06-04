很久以前就看过将vim打造称IDE的文章，无奈当时搭建了一半的IDE插件就退出了，编写C/C++程序仍然采用Eclipse CDT开发。

# 编译安装vim和vimgdb

首先删除系统自带的vim命令，执行

```
sudo yum remove vim
rpm -qa | grep vim   // 检查vim是否已经删除
```

vim-minimal该软件包不能删除，否则会将sudo命令删除。vim-common软件包作用不是非常清除，不删除。

执行：`sudo chown root.root vim74 -R`，将vim74目录属主更改为root用户。

vimgdb的下载地址为：https://github.com/larrupingpig/vimgdb-for-vim7.4

tar jvxf vim-7.4.tar.bz2

patch -p0 < vimgdb-for-vim7.4/vim74.patch

cd vim74

编译vim：

```
./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config/ --enable-perlinterp --enable-gui=gtk2 --enable-cscope --prefix=/usr --enable-luainterp --enable-gdb

make VIMRUNTIMEDIR=/usr/share/vim/vim74 && make install
```

提示如下错误：

```
Can't open perl script "/usr/share/perl5/ExtUtils/xsubpp": 没有那个文件或目录
make[1]: *** [auto/if_perl.c] 错误 2
make[1]: Leaving directory `/home/kuring/source/vim74/src'
make: *** [first] 错误 2
```

执行`yum install perl-ExtUtils-Embed`修复该错误，重新执行上述的configure和make命令，最后执行`make install`。

将vimgdb源码目录中的vimgdb_runtime文件夹复制到~/.vim/bundle目录下，执行`cp vimgdb_runtime/ ~/.vim/bundle/ -r`。

# 代码缩进显示插件vim-indent-guides

快捷键<leader> + i 开/关缩进可视化

# 代码折叠

vim自带功能，基于语法和缩进进行折叠。操作：za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠。

# 头文件和实现文件之间自动切换a.vim

常用快捷键`:A`

:A switches to the header file corresponding to the current file being edited (or vise versa)
:AS splits and switches
:AV vertical splits and switches
:AT new tab and switches
:AN cycles through matches
:IH switches to file under cursor
:IHS splits and switches
:IHV vertical splits and switches
:IHT new tab and switches
:IHN cycles through matches
<Leader>ih switches to file under cursor
<Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)
<Leader>ihn cycles through matches

# 快速开关注释NERD Commenter

<leader>cc，注释当前选中文本，如果选中的是整行则在每行首添加 //，如果选中一行的部分内容则在选中部分前后添加分别 /*、*/
<leader>cu，取消选中文本块的注释

# man帮助

系统自带功能

_:Man 命令_可查看帮助
_<leader>man_可直接显示，不需要输入命令

# 工程文件浏览NERDtree

fl：打开与关闭窗口
回车，打开选中文件；
r，刷新工程目录文件列表；
I（大写），显示/隐藏文件；
m，出现创建/删除/剪切/拷贝操作列表。

# 安装YouCompleteMe

进入到~/.vim/bundle目录中，执行：

```
cd YouCompleteMe
git submodule update --init --recursive
```

如果没有安装cmake，先安装cmake工具，下载地址：http://www.cmake.org/cmake/resources/software.html。YCM需要CMake2.8版本以上，CentOS通过yum命令安装的CMake命令版本过低，需要通过源码安装。

```
cd ~/software/ 
mkdir ycm_build 
cd ycm_build 
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBclang=ON . ~/.vim/bundle/YouCompleteMe/cpp/
make ycm_support_libs
```

# vim中编译

输入`:cope`或`:cw`命令可以弹出Quickfix窗口，输入`:make`命令可以进行编译。



# 参考文章

(Vim配置及说明——IDE编程环境)[http://www.cnblogs.com/zhongcq/p/3642794.html]
(Vim自动补全神器：YouCompleteMe)[http://marchtea.com/?p=161]
(Git时代的VIM不完全使用教程)[http://beiyuu.com/git-vim-tutorial/]