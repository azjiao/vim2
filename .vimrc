"------------------Vundle 插件自动管理------------
"插件自动管理部分 Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
"设置Leader为','
let mapleader = ','

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle/
call vundle#begin()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#begin(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle'

" The following are examples of different formats supported.
" Keep bundle commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
" Plugin 'tpope/vim-rails.git'
"--------------------------------------------------
"                 NerdTree树形目录文件查看
"--------------------------------------------------
Plugin 'scrooloose/nerdtree.git'
	" map <F4> :NERDTreeToggle<cr>
	let NERDTreeWinSize=25
	let NERDTreeShowBookmarks=1 
	let NERDTreeShowHidden=0  "开始时不显示隐藏文件
	let NERDTreeDirArrows=0
	let NERDTreeQuitOnOpen=1 "使用o/i/t/T等打开文件后自动关闭文件树

"--------------------------------------------------
"                 bufexplorer缓冲区查看
" scripts from http://vim-scripts.org/vim/scripts.html
"--------------------------------------------------
Plugin 'bufexplorer.zip'
let g:bufExplorerDisableDefaultKeyMapping=0
"--------------------------------------------------

"                 Nerdcommenter快速注释与反注释
"                 <leader>cc 单行注释
"                 <leader>c<space> 注释与反注释 *使用几率大
"                 <leader>cm 多行注释
"                 <leader>cs 另一种多行注释sexy comment
"                 <leader>c$ 从当前光标开始到行尾注释，cc是全行注释.
"                 <leader>cu 取消注释.
"                 <C-c>      插入模式下立刻插入注释并且开始编辑。
"                 <leader>ca 注释符号切换,比如从/* */切换成//
"--------------------------------------------------
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
imap <C-c> <plug>NERDCommenterInsert

" map <C-kDivide> <plug>NERDCommenterToggle

"--------------------------------------------------
"                vim-surround 快速处理环绕符号
"				 ysw(	从当前光标开始的一个单词添加()
"				 ysaw(	在一个单词中任意位置把当前单词用()环绕.
"				 yssB	在当前行或当前v块添加{}环绕。
"				 v块然后S' 　在选中的v块添加'＇环绕．
"                ds"	在一个环绕中任何位置删除""
"				 cs])	在一个环绕中任何位置把当前环绕符[]替换成().
"--------------------------------------------------
Plugin 'tpope/vim-surround.git'

"-------------------------------------------------
"                 auto pairs 
"-------------------------------------------------
Plugin 'jiangmiao/auto-pairs'

"-------------------------------------------------
"                 ag
"-------------------------------------------------
Plugin 'rking/ag.vim'

"-------------------------------------------------
"                 CtrlSF 类似sublime的查找文件内容功能
"-------------------------------------------------
Plugin 'dyng/ctrlsf.vim'

"-------------------------------------------------
"                 文件快速搜索
"-------------------------------------------------
Plugin 'kien/ctrlp.vim'
let g:ctrlp_match_window='order:ttb,max:20'
if executable('ag')
	" 使用ag代替grep
	set grepprg=ag\ --nogroup\ --nocolor	
	" Use ag in CtrlP for listing files.Lightning fast and respects .gitignore
	let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
endif
"-------------------------------------------------
"                 多光标vim-multiple-cursors，类似sublime中的多点编辑
"-------------------------------------------------
"Plugin 'terryma/vim-multiple-cursors'
" let g:multi_cursor_exit_from_visual_mode=0
" let g:multi_cursor_exit_from_insert__mode=0
"-------------------------------------------------
"                 vim-expand-region
"-------------------------------------------------
Plugin 'terryma/vim-expand-region'
"-------------------------------------------------
"                 tagbar
"-------------------------------------------------
Plugin 'majutsushi/tagbar' 
" 当打开tagbar时自动获得焦点
let g:tagbar_autofocus = 1
" 按照源文件位置来排序
let g:tagbar_sort = 0
"-------------------------------------------------
"                 状态栏
"-------------------------------------------------
" if has('gui_running')
Plugin 'bling/vim-airline'
"状态栏插件airline主题
let g:airline_theme="badwolf"
" endif
"-------------------------------------------------
"                 配色方案插件
"-------------------------------------------------
Plugin 'altercation/vim-colors-solarized.git' 

"-------------------------------------------------
"                 C语言自动补全YouCompleteMe
"-------------------------------------------------
Plugin 'Valloric/YouCompleteMe'
"设置ycm默认的配置文件
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"因为<leader>jd和easymotion的<leader>j有用法的冲突，会导致easymotion使用"<leader>j时较慢，所以改为<leader>yd．
"使用了YCM的GoTo后ctags都可以不用了.
nnoremap <leader>yd :YcmCompleter GoTo<CR>
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'

"-------------------------------------------------
"                 语法检查syntastic
"-------------------------------------------------
" Plugin 'scrooloose/syntastic'
"-------------------------------------------------
"                 java自动补全VJDE
"-------------------------------------------------
" Plugin 'vim-scripts/Vim-JDE'
"--------------------------------------------------
"                java自动补全
"--------------------------------------------------
"Plugin 'vim-scripts/javacomplete'

"if has('gui_running')
"vim-Powerline 插件设置。
"Bundle '/vim-powerline'
"endif

"let g:Powerline_symbols = 'unicode'
"let g:Powerline_colorscheme = 'solarized256'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" scripts from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
"-------------------------------------------------
"                 VOom大纲树状文本编辑
"-------------------------------------------------
Plugin 'VOoM'

"--------------------------------------------------
"                JavaBrowser,改用tagbar
"--------------------------------------------------
" Plugin 'JavaBrowser'
" let JavaBrowser_Ctags_Cmd = '/usr/local/bin/ctags'
" let JavaBrowser_Use_Highlight_Tag = 1
" map <F11> :JavaBrowser<CR>
" imap <F11> <ESC><F11>

"--------------------------------------------------
"                jcommenter
"--------------------------------------------------
Plugin 'jcommenter.vim'

"Plugin 'FuzzyFinder'
" scripts not on GitHub
"Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Bundle 'file:///~/GitRepository/airline/'
" ...

"--------------------------------------------------
"                emmet
"用于web前端开发，在html/js等中用来简化书写，以前的项目名是Zen-coding
"--------------------------------------------------
Plugin 'mattn/emmet-vim'
"使emmet仅作用在文件类型为html和css、php上。
let g:user_emmet_install_global = 0
autocmd filetype html,css,php EmmetInstall

call vundle#end()
filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install (update) bundles
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
" Put your stuff after this line
"-----------------Vundle end--------------------------------------------------

"-----------------------------------------------------------
"                 编码方式和字体
"-----------------------------------------------------------
"set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2313,cp936
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"正确处理中文字符的折行和拼接
set formatoptions+=mM
"设置字体，注意字体大小前面和\之间有一个空格,并且字体名如果有空格也要用\空格。
set guifont=YaHei\ Consolas\ Hybrid\ 14
" set guifont=M+\ 1m\ regular\ 14

"--------------------外观设置--------------------------------------
"开机不显示救助乌干达孤儿的信息
"set shortmess=atI
"gui下窗口设置
if has("gui_running")
	set guioptions+=c
	set guioptions-=m
	set guioptions-=T
	set guioptions-=L
	set guioptions-=r
	set guioptions-=b
	set guioptions-=0
endif

"---------------------------------------------------------------------------
"           设置配色方案为Solarized.
"---------------------------------------------------------------------------
if has('gui_running')
	set background=dark
	colorscheme solarized
else
	set background=dark
	colorscheme solarized
endif

"高亮当前行"
set cursorline

"设置状态栏显示内容,在gui下该设置被vim-airline插件取代。
 " if !has('gui_running')
	 set statusline=%F%m%r%h%w\[FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
	 set statusline+=%#warningmsg#
	 set statusline+=%{SyntasticStatuslineFlag()}
	 set statusline+=%*
 " endif
 let g:syntastic_always_populate_loc_list = 1
 let g:syntastic_auto_loc_list = 1
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0

"状态行显示开关：1启动显示；2总是显示
set laststatus=2

"显示行号
set nu

"显示标尺
set ruler

"显示键入的命令
set showcmd

"命令行高度
set cmdheight=1

"设置显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif
"如果支持鼠标，这开启鼠标支持.
if has('mouse')
	set mouse=a
endif

"语法高亮
syntax enable
syntax on

	"自动缩进
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set autoindent
" set ai!
set smartindent

"-------------------------------------------------------
"                    搜索与匹配
"-------------------------------------------------------
"括号高亮匹配
set showmatch  
"括号高亮匹配的时间，单位1/10秒
set matchtime=5
"搜索到文件两端时不再回环
set nowrapscan

"搜索时忽略大小写
set ignorecase 
"当搜索匹配串输入时立刻同时匹配
set incsearch
	
"-----------------------------------------------
"                 易用性设置
"----------------------------------------------
"窗口获取焦点定位操作
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
"Alt-[hjkl]:插入模式下在上下左右移动，并不改变插入模式。
imap <m-h> <left>
imap <m-j> <down>
imap <m-k> <up>
imap <m-l> <right>
" 在插入模式下使用ctrl-a,l来快速移动到行首和行尾.
imap <C-a> <C-o>^
imap <C-l> <C-o>$
"使用F2键来开关搜索/替换的高亮显示。<C-O>用于在插入模式时临时执行一个普通模式的命令.
nmap <silent> <F2> :nohlsearch<CR>
imap <silent> <F2> <c-o>:nohlsearch<CR>
"引号自动匹配.由插件取代。
" :inoremap ( ()<ESC>i
" :inoremap { {}<ESC>i
" :inoremap [ []<ESC>i
" :inoremap " ""<ESC>i
" :inoremap ' ''<ESC>i
" :inoremap < <><ESC>i

"把<ESC>键映射成"jj",在编辑是很方便，不用去远程操作ESC键了。
map! jj <ESC>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
" noremap <leader>f :NERDTreeFind<CR>
" F11的映射在终端已经把F11作为内部快捷键时失效.所以改为F3
nnoremap <F3> :TagbarToggle<CR>

"--------------------------------------------------------------
"                      easymotion config
"----------------------------------------------------------------
"取消缺省映射。
let g:EasyMotion_do_mapping = 0
"激活智能大小写匹配.
let g:EasyMotion_smartcase = 1
"设置前导激活字符
map <Leader> <Plug>(easymotion-prefix)
"2字符跳转
nmap <Leader><Space> <Plug>(easymotion-s2)
"行间跳转
map  <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"行内跳转
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)

"-----------------------------------------------------------------
"修改.vimrc配置后不用退出重启vim就能立即生效.
noremap <silent> <leader>vv :source ~/.vimrc<CR> :filetype detect<CR> :exe  "echo 'vimrc reloaded.'" <CR>
"快速载入.vimrc文件方便修改
map <Leader>ee :e ~/.vimrc<CR>
"--------------------------------------------------------------
"                      CtrlSF config
"----------------------------------------------------------------
" 在命令栏自动输入:CtrlSF，等待完成后续命令。
map <Leader>sf <Plug>CtrlSFPrompt
" 用当前光标下的word作为搜索串，等待完成命令。（等待输入路径等）
map <Leader>sfc <Plug>CtrlSFCwordPath

"--------------------------------------------------------------
"                      java自动补全设置
"----------------------------------------------------------------
"autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"autocmd Filetype java setlocal omnifunc=javacomplete#CompleteParamsInfo
"autocmd Filetype java inoremap <buffer> <C-X><C-O> <C-X><C-O><C-P>
"autocmd Filetype java inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>

"--------------------------------------------------------------
"                      html/css自动补全设置
"----------------------------------------------------------------
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS

""-------------------------------------------------------------------
""                    自动编译文件 
""-------------------------------------------------------------------
func! Compile_Run_Code()
	exec "w"
	if &filetype == "java"
		exec "!javac %:t && java %:r"
	endif
endfunc

imap <F9> <ESC>:call Compile_Run_Code()<CR>
nmap <F9> :call Compile_Run_Code()<CR>
vmap <F9> <ESC>:call Compile_Run_Code()<CR>
"-------------------------------------------------------------------
"                    使用quickfix,另一种编译代码的方式。 
"-------------------------------------------------------------------
set makeprg=javac\ %:t 
