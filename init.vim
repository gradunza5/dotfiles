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
Plug 'phanviet/vim-monokai-pro'
Plug 'rakr/vim-two-firewatch'
Plug 'liuchengxu/space-vim-dark'
Plug 'lifepillar/vim-solarized8'

" Buffer Management
Plug 'qpkorr/vim-bufkill'
Plug 'ap/vim-buftabline'

" C# Support
Plug 'OmniSharp/omnisharp-vim'

" Linting
Plug 'dense-analysis/ale'

" Statusline
Plug 'itchyny/lightline.vim'

" Vimwiki
Plug 'vimwiki/vimwiki'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

let wiki_work = {}
let wiki_work.path = '~/Drive/Drive/work/wiki/'
let wiki_work.path_html = '~/Drive/Drive/work/wiki/html/'
let wiki_work.syntax = 'markdown'
let wiki_work.ext = '.md'
let wiki_work.template_path = '~/Drive/Drive/work/wiki/templates/'
let wiki_work.template_default = 'default'
let wiki_work.template_ext = '.tpl'
let wiki_work.custom_wiki2html = 'vimwiki_markdown'
let wiki_work.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'cpp': 'cpp', 'sh': 'sh', 'cs': 'cs'}
let wiki_work.auto_tags = 1

let wiki_me = {}
let wiki_me.path = '~/Drive/Drive/me/wiki/'
let wiki_me.path_html = '~/Drive/Drive/me/wiki/html/'
let wiki_me.syntax = 'markdown'
let wiki_me.ext = '.md'
let wiki_me.template_path = '~/Drive/Drive/me/wiki/templates/'
let wiki_me.template_default = 'default'
let wiki_me.template_ext = '.tpl'
let wiki_me.custom_wiki2html = 'vimwiki_markdown'
let wiki_me.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'cpp': 'cpp', 'sh': 'sh', 'cs': 'cs'}
let wiki_me.auto_tags = 1

let wiki_dnd = {}
let wiki_dnd.path = '~/Drive/Drive/dnd/wiki'
let wiki_dnd.path_html = '~/Drive/Drive/dnd/wiki/html'
let wiki_dnd.syntax = 'markdown'
let wiki_dnd.ext = '.md'
let wiki_dnd.template_path = '~/Drive/Drive/dnd/wiki/templates/'
let wiki_dnd.template_default = 'default'
let wiki_dnd.template_ext = '.tpl'
let wiki_dnd.custom_wiki2html = 'vimwiki_markdown'
let wiki_dnd.auto_tags = 1

let g:vimwiki_list = [wiki_me, wiki_work, wiki_dnd]

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
set termguicolors
colorscheme solarized8

" =============================================================================
" Bufkill
" ============================================================================
" kill buffer
map <Leader>d :BD<cr>

" =============================================================================
" General
" =============================================================================
source ~/.vimrc
