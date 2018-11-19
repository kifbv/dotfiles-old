set nocompatible

" ================= PLUGINS
"
" To install vim-plug itself:
"
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Alignment, usually with ga<movement> or <visual>ga
" There's also godlygeek/tabular
Plug 'junegunn/vim-easy-align'
"
" Git wrapper, see http://vimcasts.org/blog/2011/05/the-fugitive-series/
Plug 'tpope/vim-fugitive'

" Comment stuff out, usually with gc<movement> or <visual>gc
Plug 'tpope/vim-commentary'

" Record session with :Obsess, delete it with :Obsess!, restart a session by
" sourcing it (:source Session.vim) or directly with vim -S
Plug 'tpope/vim-obsession'

" enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Helps to end certain structures automatically (e.g. Ruby: do..end)
Plug 'tpope/vim-endwise'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Sort a range of text, usually with gs<movement> or <visual>gs, works on
" single line too (comma separated sorting)
Plug 'christoomey/vim-sort-motion'

" Start screen with recent files and sessions
Plug 'mhinz/vim-startify'

" Better JSON highlighting
Plug 'elzr/vim-json'

" Display indentation with thin vertical lines (check the conceal setting)
Plug 'Yggdroot/indentLine'

" Show a git diff in the margin (see github for usage)
Plug 'airblade/vim-gitgutter'

" Lots of colorscheme in one plugin, use colorscheme <name> in vimrc or as a
" command
Plug 'flazz/vim-colorschemes'
Plug 'Reewr/vim-monokai-phoenix'
"Plug 'altercation/vim-colors-solarized'

" Go development plugin
Plug 'fatih/vim-go'

" HCL formating with :HclFmt (requires go get github.com/fatih/hclfmt)
"Plug 'fatih/vim-hclfmt'

" Keyword completion
Plug 'Shougo/neocomplete'

" Whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'

" Multiple selections, use *<C-n> for a starter
Plug 'terryma/vim-multiple-cursors'

" Fuzzy file, buffer etc finder
"Plug 'ctrlpvim/ctrlp.vim'

" Press F8 to change the colorscheme
"Plug 'felixhummel/setcolors.vim'

" Some colorscheme I might install at some point...
"Plug 'ayu-theme/ayu-vim'
"Plug 'dikiaap/minimalist'

" Status bar (see github for configuration)
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Show diff level of parentheses
Plug 'luochen1990/rainbow'

" Vim Ruby
Plug 'vim-ruby/vim-ruby'

" Initialize plugin system
call plug#end()

" ================= SETTINGS
"
" Some settings from tpope/vim-sensible
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set hlsearch

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Change mapleader from \ to <Space>
let mapleader=" "

" Use F2 to toggle between paste/nopaste
set pastetoggle=<F2>

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Steve Losh
set ttyfast
set undofile
"very magic pattern matching (more similar to Perl regex)
nnoremap / /\v
vnoremap / /\v
"go to matching sign with <tab> instead of %
nnoremap <tab> %
vnoremap <tab> %
"go up/down by screen line instead of file line
nnoremap j gj
nnoremap k gk

" Personal preferences
colorscheme monokai-phoenix
" yolo
set noswapfile
" set cursorline on active window
set cursorline
au WinLeave * set nocursorline
au WinEnter * set cursorline
" don't reach for escape, capslocks,... key to exit insert mode
inoremap jk <ESC>
" I don't use ;
nnoremap ; :
"nnoremap : ;
"modify and source .vimrc easily
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"re-open at same position
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" ================= PLUGIN SETTINGS
"
" ================= EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ================= NeoComplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ================= Vim-JSON
" Do not conceal json
let g:vim_json_syntax_conceal = 0

" ================= Vim-GitGutter
" Check github for more settings and usage
set updatetime=300
nmap gh <Plug>GitGutterNextHunk
nmap gp <Plug>GitGutterPrevHunk

" ================= rainbow
" Activate rainbow parentheses
let g:rainbow_active = 1

" Backups, undos, and swap files
"-----------------------------------------------------------------------------
" Save your backups to a less annoying place than the current directory.
set backupdir=~/.vim/backup//,/tmp/

" Save your swp files to a less annoying place than the current directory.
set directory=~/.vim/swp//,/tmp//

" viminfo stores the the state of your previous editing session
if exists('+undofile')
  set undodir=~/.vim/undo//,/tmp//
  set undolevels=1000         " maximum number of changes that can be undone
  set undoreload=10000        " maximum number lines to save for undo on a buffer reload
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
if has('autocmd')
  augroup MyLastCursor
    autocmd!
    autocmd BufReadPost * nested
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
  augroup END
endif
set nomodeline

function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nmap <Leader>j :call GotoJump()<CR>

