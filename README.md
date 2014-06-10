很久以前就看过将vim打造称IDE的文章，无奈当时搭建了一半的IDE插件就退出了，编写C/C++程序仍然采用Eclipse CDT开发。

#  复制和粘帖

* `:reg`：查看vi寄存器内容
* `"+p`：将系统剪贴板中的内容复制到vi中，加号表示系统剪贴板
* `"+y`：在选择模式下，将选中的内容复制到系统剪贴板中

# 跳转

* `gd`：将函数内变量所有引用高亮显示
* `gD`：将该文件内的变量全部高亮显示
* `g]`或`<C-]>`：跳转到函数定义处
* `gO`或`<C-O>`：返回跳转前的位置
* `<C-T>`：沿着经过的标签列表向回跳转

这里使用自动生成ctags文件的indexer.tar.gz插件，要自动生成ctags文件的工程需要在~/.indexer_files文件中进行配置，生成的ctags文件保存在~/.indexer_files_tags目录下，以配置工程名为单位。

# 书签

系统自带功能

* `ma`：创建一个书签，标记为a，为当前文件内书签。如果为大写字母，可以创建全局书签。
* `\`a`：跳转到书签a所在的位置
* `:marks`：显示所有书签
* `:marks a`：显示书签的详细信息
* `\`.`：跳转到上次修改的位置

# 内容查找grep.vim插件

* `:Grep`：在工程内查找
* `:Grep -i`：忽略大小写
* `:Grep -r`：递归搜索子目录
* `:GrepBffer`：在打开文件内查找
* `<Leader>sp`：在工程内全局查找
* `<Leader>sb`：在打开文件内全局查找

# 编译安装vim和vimgdb

首先删除系统自带的vim命令，执行

```
sudo yum remove vim
rpm -qa | grep vim   // 检查vim是否已经删除
```

vim-minimal该软件包不能删除，否则会将sudo命令删除。vim-common软件包作用不是非常清楚，不删除。

执行：`sudo chown root.root vim74 -R`，将vim74目录属主更改为root用户。

vimgdb的下载地址为：https://github.com/larrupingpig/vimgdb-for-vim7.4

tar jvxf vim-7.4.tar.bz2

patch -p0 < vimgdb-for-vim7.4/vim74.patch

cd vim74

编译vim：

```
./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.6/config/ --enable-perlinterp --enable-gui=gtk2 --enable-cscope --prefix=/usr --enable-luainterp --enable-gdb

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

* `<leader> + i`：开/关缩进可视化

# 代码折叠

vim自带功能，基于语法和缩进进行折叠。

* `za`：打开或关闭当前折叠
* `zM`：关闭所有折叠
* `zR`：打开所有折叠

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

* `<leader>cc`：注释当前选中文本，如果选中的是整行则在每行首添加 //，如果选中一行的部分内容则在选中部分前后添加分别 /*、*/
* `<leader>cu`：取消选中文本块的注释

# man帮助

系统自带功能

* `:Man`：可查看帮助
* `<leader>man`：可直接显示，不需要输入命令

# 工程文件浏览NERDtree

* `<leader>fl`：打开与关闭窗口
* 回车：打开选中文件；
* r：刷新工程目录文件列表；
* I（大写）：显示/隐藏文件；
* m：出现创建/删除/剪切/拷贝操作列表。

# 多文档编辑插件minibufexpl

* <Leader>bl：显示和隐藏MiniBufExplorer窗口
* Tab：正向切换目录（在常规模式下）
* Shift+Tab：逆向切换目录（在常规模式下）
* d：光标在文件列表窗口中时关闭打开的文件

# 保存会话

系统自带功能，需要mksession和viminfo支持。

* <leader>ss：保存会话
* <leader>sr：恢复会话

# 安装YouCompleteMe

进入到~/.vim/bundle目录中，执行：

```
cd YouCompleteMe
git submodule update --init --recursive
```

如果没有安装cmake，先安装cmake工具，下载地址：http://www.cmake.org/cmake/resources/software.html。

YCM需要CMake2.8版本以上，CentOS通过yum命令安装的CMake命令版本过低，需要通过源码安装。

```
cd ~/software/ 
mkdir ycm_build 
cd ycm_build 
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBclang=ON . ~/.vim/bundle/YouCompleteMe/cpp/
make ycm_support_libs
```

* `<leader>jd`：跳转到定义或声明，仅支持单个文件
* `<leader>;`：集成OmniCppComplete补全引擎

# vim中编译

* `:make`：可以进行编译。

# quickfix窗口

* `:cope`或`:cw`：可以弹出Quickfix窗口
* `:ccl`：关闭quickfix窗口
* `:cn`：go to the next entry
* `:cp`：go to the previous entry
* `:ccN`：go to the N’th entry
* `:cl`：单独一个窗口列出所有标签
* `:h quickfix`：查看帮助文档

# global的vim插件gtags.vim

在搜索标签时，支持按Tab键智能补全

* `gtags`：在工程目录中执行该命令会生成GTAGS、GRTAGS和GPATH三个文件
* `:Gtags funcname`：查找函数名
* `:Gtags -r funcname`：查找函数引用
* `:Gtags -g string`：查找字符串

# 参考文章

(Vim配置及说明——IDE编程环境)[http://www.cnblogs.com/zhongcq/p/3642794.html]
(Vim自动补全神器：YouCompleteMe)[http://marchtea.com/?p=161]
(Git时代的VIM不完全使用教程)[http://beiyuu.com/git-vim-tutorial/]
(vim源码下载地址)[http://www.vim.org/sources.php]
(cmake源码下载地址)[http://www.cmake.org/cmake/resources/software.html]
(vim脚本列表)[http://vim-scripts.org/vim/scripts.html](需翻墙)
(global插件帮助文档)[https://www.gnu.org/software/global/globaldoc_toc.html]
(gtags在vim中的应用)[http://blog.csdn.net/cohowang/article/details/5038382]
