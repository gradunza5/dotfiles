" Plugins
call plug#begin(stdpath('data') . '/plugged')

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linting
"Plug 'dense-analysis/ale'

"fzf - installed with brew.
"Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" PlantUML
Plug 'aklt/plantuml-syntax' " syntax
Plug 'tyru/open-browser.vim' " opens previews in browser
Plug 'weirongxu/plantuml-previewer.vim' " PlantUML diagram previewing and generation support
"
" C# Support
Plug 'OmniSharp/omnisharp-vim'

" Godot
Plug 'habamax/vim-godot'

" Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

"colors
Plug 'altercation/vim-colors-solarized'
Plug 'phanviet/vim-monokai-pro'
Plug 'liuchengxu/space-vim-dark'
Plug 'lifepillar/vim-solarized8'

" Buffer Management
Plug 'qpkorr/vim-bufkill'
" Plug 'ap/vim-buftabline'

" Statusline
Plug 'itchyny/lightline.vim'

" Vimwiki
Plug 'vimwiki/vimwiki'

" File Tree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" Easymotion - https://github.com/easymotion/vim-easymotion
Plug 'easymotion/vim-easymotion'

"icons - KEEP ME AS THE LAST PLUGIN
Plug 'ryanoasis/vim-devicons'

" keep this in order for ale to play nice with coc
"let g:ale_disable_lsp = 1

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
" for tips on using CoC and ALE, https://github.com/dense-analysis/ale#5iii-how-can-i-use-ale-and-cocnvim-together

"nmap <silent> <C-K> <Plug>(ale_previous_wrap)
"nmap <silent> <C-J> <Plug>(ale_next_wrap)

"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1

"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '--'

" =============================================================================
" COC
" =============================================================================
" Let coc use omnisharp
let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-markdownlint' ]
"
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <S-space> coc#refresh()


" diagnostic navigation
nmap <silent> <Space>j <Plug>(coc-diagnostic-next)
nmap <silent> <Space>k <Plug>(coc-diagnostic-prev)

nmap <silent> <Space>J <Plug>(coc-diagnostic-next-error)
nmap <silent> <Space>K <Plug>(coc-diagnostic-prev-error)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gu <Plug>(coc-references-used)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" =============================================================================
" Solarized
" colors
set termguicolors
colorscheme solarized8

" =============================================================================
" Bufkill
" ============================================================================
" kill buffer
map <Leader>d :BD<cr>

" =============================================================================
" PlantUML
" ============================================================================
" use homebrew's plantUML
au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)

" =============================================================================
" ChadTree
" ============================================================================
" keybinds: https://github.com/ms-jpq/chadtree/blob/chad/docs/KEYBIND.md
nnoremap <leader>o <cmd>CHADopen<cr>
nnoremap <leader>e <cmd>CHADopen<cr>

" =============================================================================
" FZF
" ============================================================================
nnoremap <c-p> :FZF<CR>

" =============================================================================
" autoclose some things
" ============================================================================
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" =============================================================================
" EasyMotion
" ============================================================================
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" =============================================================================
" General
" =============================================================================
source ~/.vimrc
