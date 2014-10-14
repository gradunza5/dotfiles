" Pathogen
execute pathogen#infect()

" enable syntax highlighting
syntax enable

"spell check
set spell

" let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" .tex files will always be latex code
let g:tex_flavor = "latex"

" don't mess with "
let g:Tex_SmartKeyQuote=0

" latex compile/viewing rules
let g:Tex_ViewRule_pdf="evince"
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_MultipleCompileFormats='dvi,pdf'

" highlight current line
:set cursorline

" add toggle for current line highlight
:nnoremap <Leader>c :set cursorline! <CR>

" do nice soft wrapping
set wrap
set linebreak

" set tabs->4 spaces
" set expandtab
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

" add tag files
"set tags+=./tags
"set tags+=/home/ben/.vim_tags/usr_include_tags
"set tags+=/home/ben/.vim/tags/bullet
"set tags+=/home/ben/.vim/tags/cpp
"set tags+=/home/ben/.vim/tags/gl
"set tags+=/home/ben/.vim/tags/sdl
"set tags+=/home/ben/.vim/tags/assimp

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

set laststatus=2

" Some fancy keymappings
imap jk <Esc>
