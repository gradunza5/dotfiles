" PLUGINS
" ============================================================================================
" Use vim-plug for plugin management.
" :PlugInstall to install new plugins.
" :PlugUpdate to update installed plugins.
call plug#begin('~/.vim/plugged')

" please don't include '.git' extensions. it does weird things.
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'qpkorr/vim-bufkill'
Plug 'ap/vim-buftabline'
Plug 'altercation/vim-colors-solarized'
Plug 'inside/vim-grep-operator'
Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki'

call plug#end()

" Powerline
" ============================================================================================
"let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" for NERDTree
" ============================================================================================
let NERDTreeChDirMode=2

" width
let g:NERDTreeWinSize=60

map <Leader>t :NERDTreeToggle .<CR>
nnoremap <leader>d :bp<cr>:bd #<cr>

" for VimWiki
" ============================================================================================
let g:vimwiki_hl_headers = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
set nocompatible

" vimwiki 
let wiki_1 = {}
let wiki_1.path = '~/Drive/Drive/me/wiki/'
let wiki_1.path_html = '~/Drive/Drive/me/wiki/html/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'cpp': 'cpp', 'sh': 'sh', 'cs': 'cs'}

let wiki_2 = {}
let wiki_2.path = '~/Drive/Drive/work/wiki/'
let wiki_2.path_html = '~/Drive/Drive/work/wiki/html/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'
let wiki_2.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'cpp': 'cpp', 'sh': 'sh', 'cs': 'cs'}

let wiki_3 = {}
let wiki_3.path = '~/Drive/Drive/dnd/wiki/'
let wiki_3.path_html = '~/Drive/Drive/dnd/wiki/html/'
let wiki_3.syntax = 'markdown'
let wiki_3.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]

" for CtrlP
" ============================================================================================
set runtimepath^=~/.vim/bundle/ctrlp.vim
" start file search with \o or <c-p>
nmap <Leader>o :CtrlP<CR>

" for easymotion
" ============================================================================================
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" for Ag
" ============================================================================================
" sets the ack search command
nnoremap <Leader>a :Ack!<Space>

" overrides ack to use ag instead. (Keeps bindings for ack)
if executable('ag')
    let g:ackprg='ag --nogroup --nocolor --column --vimgrep'
    let g:grep_operator='ag --nogroup --nocolor --column --vimgrep'
endif
" ============================================================================================
" ============================================================================================

" automatically change directory to acive buffer
"set autochdir
"autocmd BufEnter * silent! lcd %:p:h

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

<<<<<<< HEAD

=======
>>>>>>> 9fc095580bd54a07f89e032b8e9690997a838924
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
"set number
set relativenumber
set nu rnu " hybrid line numbers

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

<<<<<<< HEAD
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<CR>
map <F8> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

=======
>>>>>>> 9fc095580bd54a07f89e032b8e9690997a838924
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview

set laststatus=2

" Some fancy keymappings
imap jk <Esc>

"turn on syntax autocompletion
filetype plugin on 
set omnifunc=syntaxcomplete#Complete

" gui or non-gui font sizes
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
<<<<<<< HEAD
    set guifont=Meslo\ LG\ S\ for\ Powerline:h14
    set guioptions-=r
    set guioptions-=L
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
=======
 	set gfn=Monaco:h12
>>>>>>> 9fc095580bd54a07f89e032b8e9690997a838924
  endif
endif

" odd filetypes
au BufNewFile,BufRead *.master set filetype=html
au BufNewFile,BufRead *.md set filetype=vimwiki
au BufNewFile,BufRead *.cake set filetype=cs
au BufNewFile,BufRead *.js set filetype=javascript

" start in the appropriate directory
cd /Users/benreeves/work/code/

" save swap, backup, and undo files to a single directory
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//

" Limit git comment length to 72 characters
au FileType gitcommit setlocal tw=72
