let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
"sort
Plug 'RRethy/vim-illuminate'
Plug 'bluz71/vim-moonfly-colors'
Plug 'jiangmiao/auto-pairs'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'neovim/nvim-lspconfig',
Plug 'nvim-lua/plenary.nvim',
Plug 'nvim-telescope/telescope.nvim',
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-commentary'
Plug 'williamboman/nvim-lsp-installer'
"sort

"sort
Plug 'dart-lang/dart-vim-plugin'
"sort
call plug#end()

"sort
colorscheme moonfly
filetype plugin indent on
syntax on
"sort

function! Sort()
	let nums = []
	g/^\"sort/call add(nums, line('.'))
	let i = 0
	for num in nums
		if i
			let num -= 1
			execute i.','.num.'sort'
			let i = 0
		else
			let i = num + 1
		endif
	endfor
	call feedkeys("\<C-o>")
endfunction

au BufWritePre *.vim call feedkeys("gg=G\<C-o>")
au BufWritePre init.vim call Sort()
augroup FormatAutogroup
	autocmd!
	autocmd BufWritePost * FormatWrite
augroup END

"sort
let g:coq_settings = { 'auto_start': 'shut-up', 'keymap.jump_to_mark': '', 'display.pum.fast_close': v:false }
let g:dart_style_guide = 2
let g:rainbow_active = 1
let mapleader = " "
"sort

"sort
imap jk <Esc>
inoremap <silent><expr> <CR> pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
map <leader>? <plug>NERDCommenterSexy
nmap <C-f> :CHADopen<CR>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-n> gt
nmap <C-p> gT
nmap <leader>/ gcc
nmap <leader>Q :qa!<CR>
nmap <leader>a :lua vim.lsp.buf.code_action()<CR>
nmap <leader>c :bd!<CR>
nmap <leader>d :lua vim.diagnostic.open_float()<CR>
nmap <leader>f :Telescope find_files hidden=true<CR>
nmap <leader>g :lua vim.lsp.buf.definition()<CR>
nmap <leader>h :lua vim.lsp.buf.hover()<CR>
nmap <leader>l :noh<CR>
nmap <leader>m :messages<CR>
nmap <leader>n :tab split<CR>
nmap <leader>q :q!<CR>
nmap <leader>r :lua vim.lsp.buf.rename()<CR>
nmap <leader>w :w!<CR>
nmap <leader>x :tabclose!<CR>
nmap H ^
nmap J :bn<CR>
nmap K :bp<CR>
nmap L $
nmap M '
nmap<leader>o :so %<CR>
nmap<leader>p :PlugInstall<CR>
vmap <leader>/ gc
vmap H ^
vmap L $
"sort

"sort
set clipboard=unnamedplus
set conceallevel=0
set cursorline
set fileencoding=utf-8
set hidden
set hlsearch
set ignorecase
set incsearch
set mouse=a
set nobackup
set noswapfile
set nowrap
set number
set numberwidth=4
set pumheight=10
set relativenumber
set scrolloff=999
set shiftwidth=4
set shortmess+=c
set showtabline=2
set sidescrolloff=2
set signcolumn=yes
set smartcase
set smartindent
set splitbelow
set splitright
set statusline+=%F
set tabstop=4
set termguicolors
set timeoutlen=300
set title
set undofile
set updatetime=300
"sort

lua require("plug")
