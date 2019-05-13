
set number  "show linenumber
filetype on  "check file type
set background=dark  "背景使用黑色
syntax on  "开启语法高亮

set autoindent  "自动缩进,vim使用自动对起，也就是把当前行的对起格式应用到下一行
set smartindent "依据上面的对起格式，智能的选择对起方式

set textwidth=79  " lines longer than 79 columns will be broken"

set tabstop=4   "设置tab键为4个空格
set shiftwidth=4  "设置当行之间交错时使用4个空格
set softtabstop=4  " insert/delete 4 spaces when hitting a TAB/BACKSPACE"
set shiftround     " round indent to multiple of 'shiftwidth'"
set expandtab
set smarttab

set showmatch  "设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号


set ruler  "在编辑过程中，在右下角显示光标位置的状态行

set incsearch "搜索设置

" vim-Plug start
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'rust-lang/rust.vim'
Plug 'fatih/molokai'

" vim-Plug end
call plug#end()

"tagbar settings: F8打开tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1  " 启动时自动focus
let g:tagbar_width=30  "设置tagbar的宽度
let g:tagbar_zoomwidth=0  "设置缩放时的宽度，此时
autocmd FileType c,cpp,py,js nested :TagbarOpen

"nerdtree setting:
"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:rustfmt_autosave = 1

"vim-go
set autowrite
"next error
map <C-n> :cnext<CR>
"previous erros
map <C-m> :cprevious<CR>
"\a to close
nnoremap <leader>a :cclose<CR>
" ctrl+o+x  complete
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

