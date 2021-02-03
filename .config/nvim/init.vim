" Tomas's init.vim

" vim-plug
call plug#begin()
" Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-python/python-syntax'
call plug#end()

" Behaviour
let g:python3_host_prog = expand('~/.config/nvim/env/bin/python')
set wildmenu                        " Command-line completion
let mapleader=","                   " Set mapleader to comma -- IMPORTANT that this appears before mappings
set lazyredraw                      " Don't redraw screen e.g. in middle of macros
set scrolloff=5                     " Leave space between top/bottom of screen for zt/zb
set encoding=utf-8

" Spaces and tabs
set softtabstop=2                   " Set result of <TAB> to be 2 chars wide
set shiftwidth=2                    " Set >>, <<, ==, and autoindent to 2 chars
set expandtab                       " Turn tabs into spaces
set autoindent                      " Minimal automatic indenting

" UI layout
set ruler                           " Show line numbers at bottom-right
set number                          " Line numbering
set nowrap                          " Disable line wrapping
set termguicolors                   " Enable TrueColor support
set background=light                " Set background -- nvim can't detect it when running in tmux
colorscheme solarized8              " Set colorscheme

set laststatus=2                    " Always show statusline
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{fugitive#head()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\ 
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

" Searching
set incsearch                       " Incremental search
set hlsearch                        " Highlight search terms
set showmatch                       " Highlight matching braces when hovered over
set tags+=tags;/                    " Search up to the root dir for tags files

" Windows
"" Remap Ctrl+movement to move between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Syntax
filetype indent on                  " Enable indenting levels based on filetype
filetype plugin on                  " Enable filetype-specific plugins
syntax enable                       " Enable syntax processing
"" Unfold everything by default
autocmd BufRead * normal zR         

" Plugins & settings
runtime macros/matchit.vim          " Jump to matching if/else/brace/etc. with %

"" fzf.vim
set runtimepath+=/usr/local/opt/fzf             " Add fzf to runtimepath

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" Run fzf Files command from the git workspace root
command! ProjFiles execute 'Files' s:find_git_root()

" Leader commands
"" Misc
nnoremap <leader><space> :noh<CR>   

"" vim-fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>

"" fzf.vim
nnoremap <leader>/ :ProjFiles<CR>
nnoremap <leader>a :Ag<space>
"" Autocommands
" Jump to last position when opening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"" vimdiff
if &diff
    nnoremap <leader>1 :diffget LOCAL<CR>
    nnoremap <leader>2 :diffget BASE<CR>
    nnoremap <leader>3 :diffget REMOTE<CR>
endif

"" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1


"" ALE
let g:ale_fixers = {
\   'python': ['black'],
\   'cpp': ['clang-format'],
\   'go': ['gofmt'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'json': ['prettier'],
\   'html': ['prettier'],
\   'vue': ['prettier'],
\}

let g:ale_linters = {
\   'python': ['flake8'],
\   'cpp': ['cpplint'],
\   'javascript': ['eslint'],
\   'css': ['eslint'],
\   'json': ['eslint'],
\   'html': ['eslint'],
\   'vue': ['eslint'],
\}

nnoremap <leader>f :ALEFix<CR>

"" python-syntax
let g:python_highlight_all = 1

"" Deoplete
let g:deoplete#enable_at_startup = 1
