""" Auto-Download vim-plug
let _is_first_plug_install = 0
if !filereadable(stdpath('data') . '/site/autoload/plug.vim')
  let _is_first_plug_install = 1
  execute '!curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Plugins
call plug#begin(stdpath('data') . '/plugged')

"colors
Plug 'altercation/vim-colors-solarized'

" Buffer Management
Plug 'qpkorr/vim-bufkill'
Plug 'ap/vim-buftabline'

" C# Support
Plug 'OmniSharp/omnisharp-vim'

" Linting
Plug 'dense-analysis/ale'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Statusline
Plug 'itchyny/lightline.vim'

" Vimwiki
Plug 'vimwiki/vimwiki'

" Auto-Install Plugins
if _is_first_plug_install == 1
execute 'PlugInstall'
endif

call plug#end()

" =============================================================================
" VimWiki
" =============================================================================
let g:vimwiki_hl_headers = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_folding='expr'

let wiki_1 = {}
let wiki_1.path = '~/CloudStation/work/wiki/'
let wiki_1.path_html = '~/CloudStation/work/wiki/html/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.template_path = '~/CloudStation/work/wiki/templates/'
let wiki_1.template_default = 'default'
let wiki_1.template_ext = '.tpl'
let wiki_1.custom_wiki2html = 'vimwiki_markdown'
let wiki_1.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'cpp': 'cpp', 'sh': 'sh', 'cs': 'cs'}

let wiki_2 = {}
let wiki_2.path = '~/CloudStation/me/wiki/'
let wiki_2.path_html = '~/CloudStation/me/wiki/html/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'
let wiki_2.template_path = '~/CloudStation/me/wiki/templates/'
let wiki_2.template_default = 'default'
let wiki_2.template_ext = '.tpl'
let wiki_2.custom_wiki2html = 'vimwiki_markdown'
let wiki_2.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'cpp': 'cpp', 'sh': 'sh', 'cs': 'cs'}

let wiki_3 = {}
let wiki_3.path = '~/CloudStation/dnd/wiki'
let wiki_3.path_html = '~/CloudStation/dnd/wiki/html'
let wiki_3.syntax = 'markdown'
let wiki_3.ext = '.md'
let wiki_3.template_path = '~/CloudStation/dnd/wiki/templates/'
let wiki_3.template_default = 'default'
let wiki_3.template_ext = '.tpl'
let wiki_3.custom_wiki2html = 'vimwiki_markdown'

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]

" =============================================================================
" ALE
" =============================================================================
" tell ALE to only use OmniSharp for cs linting, and nothing else
" If ALE tries to use some of the cs linters it comes with naturally, it 
" locks up neoVim whenever linting. this SUCKS
let g:ale_linters = { 'cs': ['OmniSharp'] }

nmap <silent> <C-K> <Plug>(ale_previous_wrap)
nmap <silent> <C-J> <Plug>(ale_next_wrap)

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" =============================================================================
" Omnisharp
" =============================================================================
" Note: This is the default configuration, based on the omnisharp-vim github
" page.

" Note: this is required for the plugin to work
filetype indent plugin on

" Use the stdio OmniSharp-roslyn server
let g:OmniSharp_server_stdio = 1
"
" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" Allow OmniSharp to do its thing when no .sln is present
let g:OmniSharp_start_without_solution = 1

" Quicker server timeout
" Should help get to faster completion in files without a *.sln
let g:OmniSharp_server_loading_timeout = 5 " seconds, i think?

" Also helps the server load faster, but isn't good for big projects. Probably
" leave it disabled for now.
"let g:OmniSharp_server_stdio_quickload = 1

" Set the type lookup function to use the preview window instead of echoing it
" This can be nice, but it happens on hover sometimes when there's no type
" info, so there's just a random blank popup sometimes.
"let g:OmniSharp_typeLookupInPreview = 1

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet: 
" https://github.com/neovim/neovim/issues/10996
set completeopt=longest,menuone,preview ",popuphidden

" Highlight the completion documentation popup background/foreground the same as
" the completion menu itself, for better readability with highlighted
" documentation.
"set completepopup=highlight:Pmenu,border:off

" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Update semantic highlighting on BufEnter, InsertLeave and TextChanged
let g:OmniSharp_highlight_types = 2

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    "autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    "autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Enable snippet completion
" let g:OmniSharp_want_snippet=1

" =============================================================================
" COC
" =============================================================================
" Let coc use omnisharp
let g:coc_global_extensions=[ 'coc-omnisharp' ]
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" diagnostic navigation
nmap <silent> <Space>j <Plug>(coc-diagnostic-next)
nmap <silent> <Space>k <Plug>(coc-diagnostic-prev)

nmap <silent> <Space>J <Plug>(coc-diagnostic-next-error)
nmap <silent> <Space>K <Plug>(coc-diagnostic-prev-error)

" =============================================================================
" Solarized
" =============================================================================
" colors
colorscheme solarized

" =============================================================================
" Bufkill
" ============================================================================
" kill buffer
map <Leader>d :BD<cr>

" =============================================================================
" General
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
