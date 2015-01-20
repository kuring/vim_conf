很久以前就看过将vim打造称IDE的文章，无奈当时搭建了一半的IDE插件就退出了，编写Linux下的C/C++程序仍然采用Eclipse CDT开发，有时也会采用在Windows下进行编译放到Linux下进行编译和调试的方式。抽时间努力学习了vim的使用技巧及各种插件的使用情况，希望我的笔记能够对大家有所帮助。

其中vim的插件安装采用的Vundle方式，需要先安装Vundle，安装方式为：`git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`。

安装完Vundle后，vimrc文件后打开vim执行`:PluginInstall`命令即可自动安装插件了。本文中YouCompleteMe插件比较特殊，还需要其他配置方能安装成功。

如下的快捷键为跟插件相关：

# 跳转

* `gd`：将函数内变量所有引用高亮显示
* `gD`：将该文件内的变量全部高亮显示
* `g]`或`<C-]>`：跳转到函数定义处
* `<C-O>`：返回跳转前的位置
* `<C-T>`：沿着经过的标签列表向回跳转

这里使用自动生成ctags文件的indexer.tar.gz插件，要自动生成ctags文件的工程需要在~/.indexer_files文件中进行配置，生成的ctags文件保存在~/.indexer_files_tags目录下，以配置工程名为单位。

# 内容查找grep.vim插件

* `:Grep`：在工程内查找
* `:Grep -i`：忽略大小写
* `:Grep -r`：递归搜索子目录
* `:GrepBffer`：在打开文件内查找
* `<Leader>sp`：在工程内全局查找
* `<Leader>sb`：在打开文件内全局查找

# 代码缩进显示插件vim-indent-guides

* `<leader> + i`：开/关缩进可视化

# 头文件和实现文件之间自动切换a.vim

* `:A` switches to the header file corresponding to the current file being edited (or vise versa)
* `:AS` splits and switches
* `:AV` vertical splits and switches
* `:AT` new tab and switches
* `:AN` cycles through matches
* `:IH` switches to file under cursor
* `:IHS` splits and switches
* `:IHV` vertical splits and switches
* `:IHT` new tab and switches
* `:IHN` cycles through matches
* `<Leader>ih` switches to file under cursor
* `<Leader>is` switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)
* `<Leader>ihn` cycles through matches

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

# global的vim插件gtags.vim

在搜索标签时，支持按Tab键智能补全

* `gtags`：在工程目录中执行该命令会生成GTAGS、GRTAGS和GPATH三个文件，也可在vim中执行`:!gtags`来生成。
* `gtags -u`：更新gtags的相关文件
* `:Gtags funcname`：查找函数名
* `:Gtags -r funcname`：查找函数引用
* `:Gtags -g string`：查找字符串

# YouCompleteMe插件

* `<leader>jd`：跳转到定义或声明，仅支持单个文件
* `<leader>;`：集成OmniCppComplete补全引擎

----

# 需要安装的软件

## 编译安装vim

首先删除系统自带的vim命令，执行

```
sudo yum remove vim
rpm -qa | grep vim   // 检查vim是否已经删除
```

vim-minimal该软件包不能删除，否则会将sudo命令删除。vim-common软件包作用不是非常清楚，不删除。

执行：`sudo chown root.root vim74 -R`，将vim74目录属主更改为root用户。

```
tar jvxf vim-7.4.tar.bz2
cd vim74
./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp  --enable-perlinterp --enable-gui=gtk2 --enable-cscope --prefix=/usr --enable-luainterp --with-python-config-dir=/usr/lib/python2.6/config/
make VIMRUNTIMEDIR=/usr/share/vim/vim74 && make install
```
需要注意的是，由于每个机器上python的环境配置一样，需要将python的路径指定正确。

安装完成后，执行`vim --version`命令查看当前的vim版本是否正确。

## 编译安装global

编译安装步骤跟普通软件一致。

## 安装YouCompleteMe

如果没有安装cmake，先安装cmake工具，下载地址：http://www.cmake.org/cmake/resources/software.html。YCM需要CMake2.8版本以上，CentOS通过yum命令安装的CMake命令版本过低，需要通过源码安装。

进入到~/.vim/bundle目录中，执行：

```
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer	// 接下来是漫长的等待直到安装完成
```

# 参考文章

* [https://github.com/yangyangwithgnu/use_vim_as_ide](https://github.com/yangyangwithgnu/use_vim_as_ide)（我的主要参考，内容非常详细）
* [Vim配置及说明——IDE编程环境](http://www.cnblogs.com/zhongcq/p/3642794.html)
* [Vim自动补全神器：YouCompleteMe](http://marchtea.com/?p=161)
* [Git时代的VIM不完全使用教程](http://beiyuu.com/git-vim-tutorial/)
* [vim源码下载地址](http://www.vim.org/sources.php)
* [cmake源码下载地址](http://www.cmake.org/cmake/resources/software.html)
* [vim脚本列表](http://vim-scripts.org/vim/scripts.html)(需翻墙)
* [global插件帮助文档](https://www.gnu.org/software/global/globaldoc_toc.html)
* [gtags在vim中的应用](http://blog.csdn.net/cohowang/article/details/5038382)
* [Vim插件简单介绍](http://blog.segmentfault.com/xuelang/1190000000630547)
