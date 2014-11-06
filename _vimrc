set nocompatible

call plug#begin()

Plug 'jnurmine/Zenburn'
Plug 'kien/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'moldauder/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'pangloss/vim-javascript'
Plug 'edsono/vim-matchit'
Plug 'tpope/vim-surround'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'rking/ag.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()


let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" 定义 <Leader> 为逗号
let mapleader = ","
let maplocalleader = ","

" syntax
syntax on
filetype plugin indent on

" 制表符
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" 行号
set norelativenumber
set number

" always report number of lines changed
set report=0

" 上下可视行数
set scrolloff=3

" 行距
set linespace=8

" 搜索选项
set hlsearch  " Highlight search things
set magic     " Set magic on, for regular expressions

set matchtime=2
set matchpairs=(:),{:},[:],<:>

" 让退格，空格，上下箭头遇到行首行尾时自动移到下一行（包括insert模式）
set whichwrap=b,s,<,>,[,]
set showmatch " Show matching bracets when text indicator is over them
set mat=5     " How many tenths of a second to blink
set incsearch
"set ignorecase

" fix filename completion in VAR=/path
set isfname-=\=

" 状态栏显示目前所执行的指令
set showcmd

" 不要同步滚屏
set noscrollbind

" 缩进
set autoindent
set smartindent

" 设定在任何模式下鼠标都可用
set mouse=a

" 备份和缓存
set nobackup
set noswapfile

" 自动改变当前目录
set autochdir

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 关联系统剪切板
set clipboard+=unnamed

" 文件格式
set fileformats=unix,dos,mac

" 自动换行
set wrap

" 永久撤销，Vim7.3 新特性
if has('persistent_undo')
    set undofile

    " 设置撤销文件的存放的目录
    if has("unix")
        set undodir=/tmp/,~/tmp,~/Temp
    else
        set undodir=c:/windows/temp/
    endif
    set undolevels=1000
    set undoreload=10000
endif

" Diff 模式的时候鼠标同步滚动 for Vim7.3
"if has('cursorbind')
    "set cursorbind
"end


" Don't break the words with following character
set iskeyword+=_,$,@,%,#,-

" =====================
" 多语言环境
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    lang messages zh_CN.utf-8

    set termencoding=utf-8
    set fencs=utf-8,gbk,chinese,latin1
    set fileencoding=utf-8

    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" =========
" AutoCmd
" =========
if has("autocmd")
    filetype plugin indent on

    " CSS3 语法支持
    au BufRead,BufNewFile *.{css,less,scss} set ft=css syntax=css3

    " velocity
    au BufRead,BufNewFile *.vm set ft=html syntax=velocity

    " ejs
    au BufRead,BufNewFile *.ejs set ft=html syntax=html

    " markdown
    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

    " ruby
    au BufRead,BufNewFile *.{rb,yml} set tabstop=2 shiftwidth=2 softtabstop=2

    " soy
    au BufRead,BufNewFile *.soy set filetype=html syntax=html

    " 保存编辑状态
    au BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
    au BufWinEnter * if expand('%') != '' && &buftype == '' | silent loadview | syntax on | endif
endif


if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\    " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{&fenc}]            " fileencoding
    set statusline+=\ [%{getcwd()}]          " current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" =========
" GUI
" =========
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr

    " 高亮光标所在的行
    set nocursorline

    set lines=30 columns=110

    " Under Mac, Remove support for win32
    if has("gui_macvim")
        " 抗锯齿渲染
        set anti

        set guifont=Menlo:h14

        " 半透明和窗口大小
        "set transparency=5

        " 使用 MacVim 原生的全屏幕功能
        let s:lines=&lines
        let s:columns=&columns

        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf

        func! FullScreenLeave()
            let &lines=s:lines
            let &columns=s:columns
            set nofu
        endf

        func! FullScreenToggle()
            if &fullscreen
                call FullScreenLeave()
            else
                call FullScreenEnter()
            endif
        endf

        set guioptions+=e
        " Mac 下，按 <Leader>ff 切换全屏
        nmap <f11> :call FullScreenToggle()<cr>
        nmap <Leader>ff  :call FullScreenToggle()<cr>

        "Set input method off
        set imdisable
    endif
endif

" =============
" Key Shortcut
" =============
nmap <C-Tab> :tabnext<cr>

" insert mode shortcut
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-d> <Delete>

" php
" 高亮字符串里的SQL语句
let php_sql_query=1
" 高亮字符串里的HTML
let php_htmlInStrings=1
" 禁用php的短标记
let php_noShortTags=1
" 启用代码折叠（用于类和函数、自动）
let php_folding=0

set background=dark

if strftime("%H") < 18 && strftime("%H") > 2
    colorscheme slate  
else
    " 晚上
    colorscheme zenburn
endif


" 显示tab，空格
set nolist
"set listchars=tab:>-,trail:-

" NERDTree
"nmap <Leader>dd :NERDTree<cr>
"let NERDTreeShowBookmarks=1
"let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
"let NERDTreeChDirMode=0
"let NERDTreeQuitOnOpen=1
"let NERDTreeShowHidden=1
"let NERDTreeKeepTreeInNewTab=1

" NERDComment
let g:NERDMenuMode = 0

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|build|node_modules)$'
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0
nmap <Leader>mr :CtrlPMRU<cr>

" vim-indent-guides
let g:indent_guides_level=2
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" markdown
let g:vim_markdown_folding_disabled=0

" YouCompleteMe
" http://www.html-js.com/article/Editor-YouCompleteMe-you-worth-having
" ./install.sh
