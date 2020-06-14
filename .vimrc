" =============================================================================
" General Configuration
" =============================================================================
" dark background
set background=dark

" easier than reaching for Escape
imap jk <Esc>

" cursorline
set cursorline

" line numbering
set relativenumber
set nu rnu " hybrid numbers

" arrows switch buffers
map <right> :bn<cr>
map <left> :bp<cr>

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

" Limit git commit length
au FileType gitcommit setlocal tw=72
