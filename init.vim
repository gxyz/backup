
" begin vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/denite.nvim'
Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jiangmiao/auto-pairs'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()
" end vim-plug

" general
set smartindent "依据上面的对起格式，智能的选择对起方式
set autoindent  "自动缩进,vim使用自动对起，也就是把当前行的对起格式应用到下一行
set shiftwidth=4  "设置当行之间交错时使用4个空格
set softtabstop=4  " insert/delete 4 spaces when hitting a TAB/BACKSPACE"
set showmatch  "设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
syntax on
color dracula
filetype plugin indent on
let mapleader="#"
set autoread
set autowrite
set laststatus=2
set showtabline=2
set number
set backspace=indent,eol,start
set tabstop=4
set encoding=UTF-8
set autoindent shiftwidth=4
set expandtab
set showmatch
set t_Co=256
set guifont=DroidSansMono\ Nerd\ Font\ 11


" ======= NERDTree CONFIG START ========
" auto open NERDTree whem vim start
autocmd vimenter * NERDTree

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" map a specific key or shortcut to open NERDTree
" Ctrl + n
map <C-n> :NERDTreeToggle<CR>

" when only NERDTree window, close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('rs', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('go', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('py', 'Magenta', 'none', '#ff00ff', '#151515')
" =======  NERDTree CONFIG END   ========

" ======= vim-go CONFIG START ========
" GoBuild : compile package
" GoInstall : install package
" GoTest : test
" GoTestFunc : sigle test
" GoRun : quick execute curent files
" GoDebugStart : debug programs with integrated delve
" GoDef : go to symbol/declaration
" GoDoc/GoDocBrowser: lookup document
" GoImport : import package
" GoDrop : remove package
" GoRename : type-safe renaming of identifiers
" GoCoverage : See which code is covered by tests 
" GoAddTags/GoRemoveTags : add or remove tags on struct fields
" GoLint : Lint our code
" GoVet : run code and catch static errors
" GoErrCheck : make sure error are checked
" ======= vim-go CONFIG END   ========

" ======= deoplete CONFIG START ========
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_skip_check = 1

" deoplete-go
let g:deoplete#sources#go#gocode_binary	= $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#unimported_packages = 1

" deoplete-jedi python
" ======= deoplete CONFIG END   ========
let g:deoplete#sources#jedi#statement_length =  79
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'

