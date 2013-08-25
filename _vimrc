set nocompatible
set background=dark

" git://github.com/tpope/vim-pathogen.git
call pathogen#infect()

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
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" 行号
set number

" always report number of lines changed
set report=0

" 上下可视行数
set scrolloff=3

" 行距
set linespace=4

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

" 不要自动换行
"set nowrap
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
if has('cursorbind')
    set cursorbind
end


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
    au BufRead,BufNewFile *.css set ft=css syntax=css3

    " velocity
    au BufRead,BufNewFile *.vm set ft=html syntax=velocity

    " ejs
    au BufRead,BufNewFile *.ejs set ft=html syntax=html

    " markdown
    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd

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
    set cursorline

    set lines=30 columns=100

    if has("win32") || has('win64')
        " Windows 兼容配置
        source $VIMRUNTIME/mswin.vim

        " f11 最大化
        nmap <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>
        nmap <Leader>ff :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>

        " 字体配置
        set guifont=Monaco:h9:cANSI
        set guifontwide=Simsun:h11:cANSI
    endif

    " Under Mac
    if has("gui_macvim")
        " 抗锯齿渲染
        set anti

        "set guifont=Monaco:h11
        "set guifont=Courier\ New:h13
        "set guifont=Courier:h13
        set guifont=Consolas:h12
        "set guifont=Menlo\ Regular:h13
        "set guifont=Andale\ Mono:h14

        " 半透明和窗口大小
        "set transparency=10

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

if has('syntax')
    if has('gui_running')
        set background=dark
        colorscheme evening
    else
        set background=light
    endif
endif

" 显示tab，空格
set list
set listchars=tab:>-,trail:-

" NERDTree
nmap <Leader>dd :NERDTree<cr>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

" NERDComment
let g:NERDMenuMode = 0

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_working_path_mode = 2
nmap <Leader>mr :CtrlPMRU<cr>

" vim-indent-guides
let g:indent_guides_level=2
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" NeoComplCache
let g:neocomplcache_enable_at_startup=1
let g:neoComplcache_disableautocomplete=1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" <TAB>: completion.
" pumvisible 如果弹出菜单可见返回非0，否则返回0
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"close_popup 补全后关闭弹出框
inoremap <expr><C-y>  neocomplcache#close_popup()
"cancel_popup 直接关闭弹出框---与zencoding冲突
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" zencoding
let g:user_zen_expandabbr_key = '<C-e>'
let g:user_zen_complete_tag = 1
let g:user_zen_settings = {
\    'html': {
\        'default_attributes': {
\            'select': {'name': ''}
\        },
\        'expandos': {
\            'select': 'select'
\        },
\        'block_elements': 'address,applet,blockquote,button,center,dd,del,dir,div,dl,dt,fieldset,form,frameset,hr,iframe,ins,isindex,li,link,map,menu,noframes,noscript,object,ol,p,pre,script,table,tbody,td,tfoot,th,thead,tr,ul,h1,h2,h3,h4,h5,h6,select',
\        'inline_elements': 'a,abbr,acronym,applet,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,iframe,img,input,ins,kbd,label,map,object,q,s,samp,script,small,span,strike,strong,sub,sup,textarea,tt,u,var'
\    }
\}
