call plug#begin(stdpath('data') . '/plugged')
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }  " file tree
Plug 'kristijanhusak/defx-icons'
Plug 'vim-airline/vim-airline'                             " status line
Plug 'vim-airline/vim-airline-themes'                      " airline theme 
Plug 'ryanoasis/vim-devicons'                              " icon
Plug 'dracula/vim', { 'as': 'dracula' }                    " theme
Plug 'kristijanhusak/defx-git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vista.vim'     " symbols
Plug 'jiangmiao/auto-pairs'
Plug 'rizzatti/dash.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
"Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ryanolsonx/vim-lsp-javascript'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

