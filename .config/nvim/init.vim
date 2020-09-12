" Init: {{{
augroup MyAutoCmd
    autocmd!
augroup END

let mapleader = ';'

if &compatible
    set nocompatible
endif
" }}}

" Plug: {{{
call plug#begin('~/.config/nvim/plugged')
" NVIM-LSP: {{{
    Plug 'neovim/nvim-lspconfig'
" }}}
" ALE: {{{
    Plug 'dense-analysis/ale'

    let g:ale_lint_on_text_changed = 1
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = '⚠'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_fix_on_save = 1
    " let g:ale_completion_enabled = 1
    let g:ale_linters = {
          \ 'python': ['flake8', 'pylint', 'pydocstyle'],
          \ }
    let g:ale_fixers = {
          \ 'python': ['autopep8', 'black', 'isort', 'trim_whitespace', 'yapf'],
          \ }

    let g:ale_go_langserver_executable = 'gopls'

    nmap [ale] <Nop>
    map <Leader>a [ale]
    nmap [ale]x <Plug>(ale_fix)
    nmap [ale]p <Plug>(ale_previous)
    nmap [ale]n <Plug>(ale_next)
" }}}
" Deoplete: {{{
    Plug 'Shougo/deoplete.nvim'
    Plug 'Shougo/deoplete-lsp'
    let g:deoplete#enable_at_startup = 1
    set completeopt-=preview
" }}}
" Lightline: {{{
    Plug 'itchyny/lightline.vim'
    let g:lightline = {
                \ 'active': {
                \ 'left': [ ['mode', 'paste'],
                \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                \ },
                \ 'component_function': {
                \   'gitbranch': 'gitbranch#name'
                \ },
                \ }
" }}}
" Easy-Align: {{{
    Plug 'junegunn/vim-easy-align'
    vmap <Enter> <Nop>
    vmap <Enter> <Plug>(EasyAlign)
" }}}
" NERDTREE: {{{
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
    map <C-n> :<C-u>NERDTreeToggle<CR>
" }}}
" ColorScheme: {{{
    " Plug 'NLKNguyen/papercolor-theme'
    " augroup MyAutoCmd
    "     autocmd VimEnter * nested colorscheme PaperColor
    "     autocmd ColorScheme * highlight Normal ctermbg=none
    "     autocmd ColorScheme * highlight Folded ctermbg=none
    "     autocmd ColorScheme * highlight NonText ctermbg=none
    "     autocmd ColorScheme * highlight FoldColumn ctermbg=none
    " augroup END
    Plug 'gryf/wombat256grf'
    augroup MyAutoCmd
        autocmd VimEnter * nested colorscheme wombat256grf
        autocmd ColorScheme * highlight Normal ctermbg=none
        autocmd ColorScheme * highlight Folded ctermbg=none
        autocmd ColorScheme * highlight NonText ctermbg=none
        autocmd ColorScheme * highlight FoldColumn ctermbg=none
    augroup END
" }}}
" Easymotion: {{{
Plug 'easymotion/vim-easymotion'
    let g:EasyMotion_do_mapping = 0
    nmap [easymotion] <Nop>
    map <Leader>e [easymotion]
    nmap [easymotion]f <Plug>(easymotion-overwin-f2)
" }}}
" FZF: {{{
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    Plug 'junegunn/fzf.vim'
    nmap [fzf] <Nop>
    map <Leader>f [fzf]
    nmap <silent> [fzf]f :<C-u>Files<CR>
    nmap <silent> [fzf]b :<C-u>Buffers<CR>
    nmap <silent> [fzf]g :<C-u>Rg<CR>
    nmap <silent> [fzf]h :<C-u>History<CR>
" }}}
" Eskk: {{{
    Plug 'tyru/eskk.vim'
    let g:eskk#directory = '~/.eskk'
    let g:eskk#dictionary = {
       \ 'path': '~/.skk-jisyo',
       \ 'sorted': 0,
       \ 'encoding': 'utf-8',
       \ }
    let g:eskk#large_dictionary = {
       \ 'path': '/usr/share/skk/SKK-JISYO.L',
       \ 'sorted': 1,
       \ 'encoding': 'euc-jp',
       \ }
    let g:eskk#enable_completion = 1
" }}}
" AsyncRun: {{{
    Plug 'skywind3000/asyncrun.vim'
    nmap [asyncrun] <Nop>
    map <Leader>r [asyncrun]
    map [asyncrun]p :<C-u>%AsyncRun -raw python<CR>
    map [asyncrun]rc :<C-u>%AsyncRun -raw cargo check<CR>
    map [asyncrun]rr :<C-u>%AsyncRun -raw cargo run<CR>
    augroup MyAutoCmd
        autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8,1)
    augroup END
" }}}
" CAW: {{{
    Plug 'tyru/caw.vim'
" }}}
" Table Mode: {{{
    Plug 'dhruvasagar/vim-table-mode'
" }}}
" Snippet: {{{
    " Plug 'SirVer/ultisnips'
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    " Plug 'honza/vim-snippets'
    " Snippet: {{{
        " Plugin key-mappings.
        " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)

        " SuperTab like snippets behavior.
        " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
        "imap <expr><TAB>
        " \ pumvisible() ? "\<C-n>" :
        " \ neosnippet#expandable_or_jumpable() ?
        " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

        " For conceal markers.
        if has('conceal')
        set conceallevel=2 concealcursor=niv
        endif
    "" }}}
" }}}
" Vim-go: {{{
    Plug 'fatih/vim-go',  " { 'do': ':GoUpdateBinaries' }
    let g:go_fmt_command = "goimports"
    " let g:go_debug = ['lsp']
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_types = 1
    " highlight variables and functions with same name
    let g:go_auto_sameids = 1
    let g:go_auto_type_info = 1
    let g:go_addtags_transform = 'camelcase'
    let g:go_gocode_unimported_packages = 1

    let g:go_def_mapping_enabled = 0
    let g:go_doc_keywordprg_enabled = 0

    nmap [vimgo] <Nop>
    map <Leader>g [vimgo]
    nmap [vimgo]g :<C-u>GoRun %<CR>
" }}}
" Markdown-Preview: {{{
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" }}}
" tagbar: {{{
    Plug 'liuchengxu/vista.vim'
    nmap [vista] <Nop>
    map <Leader>v [vista]
    nmap [vista]v :<C-U>Vista!!<CR>
    nmap [vista]f :<C-U>Vista finder<CR>

" }}}
" Git: {{{
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'itchyny/vim-gitbranch'
" }}}
" Rainbow: {{{
    Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1
" }}}
" Nim: {{{
    Plug 'zah/nim.vim'
" }}}
" AUtoPair: {{{
    Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsShortcutJump = "<c-c>"
" }}}
" Surround: {{{
    Plug 'tpope/vim-surround'
" }}}
" VimRepeat: {{{
    Plug 'tpope/vim-repeat'
" }}}
" Pydoc: {{{
    Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
    let g:pydocstring_formatter = 'numpy'  " sphinx, numpy, google
    let g:pydocstring_doq_path = '.venv/bin/doq'
"
" }}}
call plug#end()
" }}}

" LSP: {{{
" LuaFunc: {{{
lua << EOF
    function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
    end
    function tablelength(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    end
    function find_virtual_env()
        local path_element = vim.split(vim.call("expand", "%:p:h"), "/")
        for i=tablelength(path_element),2,-1 do
            check_path = table.concat(path_element, '/', 1, i) .. "/.venv/bin/pyls"
            if exists(check_path) then
                return check_path
            end
        end
        return 'pyls'
    end
EOF
" }}}

" lua require'nvim_lsp'.gopls.setup{}
lua require'nvim_lsp'.gopls.setup{capabilities={
            \ textDocument={completion={
            \   completionItem={snippetSupport=false}
            \   }}
            \ }}
" lua require'nvim_lsp'.pyls.setup{cmd={find_virtual_env()}}
lua require'nvim_lsp'.pyls.setup{}
lua require'nvim_lsp'.jsonls.setup{}
lua require'nvim_lsp'.rust_analyzer.setup{}

" https://www.reddit.com/r/neovim/comments/gtta9p/neovim_lsp_how_to_disable_diagnostics/
lua vim.lsp.callbacks["textDocument/publishDiagnostics"] = function () end

" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
" }}}

" Required: {{{
filetype plugin indent on
syntax enable
" }}}

" Search: {{{
set ignorecase
set smartcase
set incsearch
set nohlsearch
set wrapscan
" }}}

" Edit: {{{
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set modeline
set backspace=indent,eol,start
set showmatch
set cpoptions-=m
set matchtime=1
set matchpairs+=<:>
set hidden
set autoread
set infercase
set foldenable
set foldmethod=marker
set commentstring=%s
set grepprg=grep\ -nH
set splitbelow
set splitright
set noundofile
" 十進数としてインクリメントする
set nrformats=
" 八進数, 十六進数としてインクリメントする
" set nrformats=octal,hex
" }}}

" View: {{{
set title
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set laststatus=2
set cmdheight=1
set showcmd
set linebreak
set showbreak=>\
set breakat=\ \ ;:,!?
" Wrap conditions.
set whichwrap+=<,>,[,],b,s,~
if exists("+breakindent")
    set breakindent
    set breakindentopt=shift:4
    set wrap
else
    set nowrap
endif
set shortmess=aTI
set nowritebackup
set nobackup
set swapfile
set directory=/tmp
set t_vb=
set novisualbell
set history=200
set scrolloff=5
set viewdir=~/.vim/view viewoptions-=options viewoptions+=slash,unix
set ambiwidth=double

augroup MyAutoCmd
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
" }}}

" Syntax: {{{
set autoindent
set smartindent
" }}}

" Mapping: {{{
nnoremap j gj
nnoremap k gk
vnoremap v $h
nnoremap Y y$
cnoremap <C-P> <UP>
cnoremap <C-N> <DOWN>
imap jj <ESC>
nnoremap + <C-a>
nnoremap - <C-x>
nmap q: <Nop>
augroup MyAutoCmd
    autocmd FileType qf nnoremap <silent><buffer>q :<C-u>quit<CR>
augroup END
" tnoremap <C-[> <C-\><C-n>
" }}}

" Function: {{{
"}}}

" Other: {{{
set mouse=a
set secure
let t:cwd = getcwd()
" }}}
