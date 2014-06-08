" ----------------Vundle begin------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ----------------安装插件------------------
Plugin 'Lokaltog/vim-powerline'             " 控制台插件
Plugin 'Mizuchi/STL-Syntax'                 " STL语法高亮插件
Plugin 'nathanaelkane/vim-indent-guides'    " 代码缩进高亮插件
Plugin 'a.vim'                              " 在.h文件和.cpp文件进行切换插件
Plugin 'scrooloose/nerdcommenter'           " 快速注释插件
Plugin 'Valloric/YouCompleteMe'             " 代码补全插件
Plugin 'scrooloose/nerdtree'                " 工程文件浏览
Plugin 'fholgado/minibufexpl.vim'           " 多文档编辑
Plugin 'plasticboy/vim-markdown'            " markdown插件
Plugin 'indexer.tar.gz'                     " tags文件自动更新插件
Plugin 'DfrankUtil'                         " indexer.tar.gz插件依赖插件
Plugin 'Vimprj'                             " indexer.tar.gz插件依赖插件
Plugin 'gtags.vim'                          " global插件

" ----------------Vundle end------------------
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ----------------常规配置------------------
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
" 解决粘帖代码时代码换行问题
set paste

" [代码折叠相关]
" 基于缩进或语法进行代码折叠
set foldmethod=indent
" set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" 定义快捷键的前缀，即 <Leader>
let mapleader=";" 

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" vim 自身命令行模式智能补全
set wildmenu

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T 

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
" set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" 设置 gvim 显示字体
set guifont=YaHei\ Consolas\ Hybrid

" 自动换号显示
set wrap

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on
" 修正插入模式下backspace键不能用问题
set backspace=2 " make backspace work like most other apps
" ----------------插件配置------------------
" 配色方案
set background=dark
" set background=light
" colorscheme solarized
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
" colorscheme phd

" +++++状态栏++++
" 设置状态栏主题风格
" let g:Powerline_theme = 'solarized256'
let g:Powerline_colorscheme = 'solarized256'
" set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

" +++++代码缩进显示vim-indent-guides++++
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=0
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle
let g:indent_guides_auto_colors = 1

" +++++查看工程文件插件NERDTree++++
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

" +++++多文档编辑插件MiniBufExplorer++++
" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
" buffer 切换快捷键
nmap <Tab> :MBEbn<cr>
nmap <S-Tab> :MBEbp<cr>

" +++++markdown插件++++
" markdown默认不折叠
let g:vim_markdown_folding_disabled=1
" markdown折叠层次
let g:vim_markdown_initial_foldlevel=1

" +++++indexer插件++++
" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

