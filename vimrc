" =============================================================================
" General
" =============================================================================
" dark background
set background=dark

" easier than reaching for Escape
imap jk <Esc>

" absolute movement
nmap j gj
nmap k gk

" copy/paste
nmap <leader>v "+gp
imap <leader>v <esc>"+gpa
vmap <leader>c "+y
vmap <leader>y "+y

" open new split panes to right and below
set splitright
set splitbelow

" cursorline
set cursorline

" line numbering
set relativenumber
set nu rnu " hybrid numbers

" arrows switch buffers
map <right> :bn<cr>
map <left> :bp<cr>

" window movement
noremap <C-J> <C-W>w
noremap <C-K> <C-W>W
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h

" tabs and spaces and whatnot
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" scroll offset
set scrolloff=4

" enable auto-read if file changes
set autoread

" split defaults
set splitbelow
set splitright

" toggle search highlight
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Netrw (file explorer) setup; NERDTree-ish
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
map <leader>t :Lexplore<CR>

" folding defaults
set foldmethod=syntax
set nofoldenable

" nice line breaks
set wrap
set linebreak

" ignore case in files and folders
set wildignorecase

" ignore case in text search
set ignorecase

" config mappings
nnoremap <leader>vc :e $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" Limit git commit length
au FileType gitcommit setlocal tw=72
