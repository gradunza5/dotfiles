" Pathogen
execute pathogen#infect()

set nocompatible

" for vimwiki
let wiki_work = {}
let wiki_work.path = '~/Sync/work/wiki/'
let wiki_work.path_html = '~/Sync/work/wiki/html/'
let wiki_work.syntax = 'markdown'
let wiki_work.ext = 'md'

let wiki_me = {}
let wiki_me.path = '~/Sync/me/wiki/'
let wiki_me.path_html = '~/Sync/me/wiki/html/'
let wiki_me.syntax = 'markdown'
let wiki_me.ext = 'md'

let g:vimwiki_list = [wiki_me, wiki_work]

" for powerline fonts
let g:airline_powerline_fonts = 1

" for NERDTree
map <Leader>t :NERDTreeToggle<CR>

" enable syntax highlighting
syntax enable

" split defaults
set splitbelow
set splitright

"spell check
" set spell
set nospell

" let g:solarized_termcolors=256
set background=dark
colorscheme solarized


" highlight current line
set cursorline

" add toggle for current line highlight
nnoremap <Leader>c :set cursorline! <CR>

" do nice soft wrapping
set wrap
set linebreak
"set breakindent "for better wrapped indenting?

" set tabs->4 spaces
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set scrolloff=4

" enable line numbering
set number
" set relativenumber

" keep undo history
set hidden

" persistent undo history
set undofile
set undodir=~/.vim/undo

" enable auto indent
set nocp
filetype plugin on
filetype indent on

" omnicomplete
set omnifunc=syntaxcomplete#Complete

" enable auto re-read if changed
set autoread

"ignore case when searching
set ignorecase
set smartcase

" show matching bracket
set showmatch

"blink time
set mat=2  

" auto/smart indent
set ai
set si

" make movement absolute
nmap j gj
nmap k gk

" smart window movements
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" arrows switch buffers
map <right> :bn<cr>
map <left> :bp<cr>

" code folding
set foldmethod=syntax
set nofoldenable
set foldlevel=1

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<CR>
map <F8> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

set laststatus=2

" Some fancy keymappings
imap jk <Esc>

" gui or non-gui font sizes
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Meslo\ LG\ S\ for\ Powerline:h14
    set guioptions-=r
    set guioptions-=L
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" odd filetypes
au BufNewFile,BufRead *.master set filetype=html
