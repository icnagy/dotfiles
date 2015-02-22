set nocompatible              " be iMproved, required
filetype off                  " required

set shell=/usr/local/bin/zsh
runtime macros/matchit.vim

set nowrap
set autoread
set noswapfile
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set vb
set noerrorbells
set tags=./tags,tags
set hidden
set guifont=Monaco:h14
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set number

set lazyredraw
set background=dark
let base16colorspace=256
set t_Co=256
colorscheme slate
syntax enable

" Window Movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Rspec.vim
let g:quickfix_filename = ".git/quickfix.out"
let g:rspec_command = "silent !~/.vim/bundle/vim-rspec/bin/os_x_iterm 'clear && rspec  --out ".g:quickfix_filename." --format progress {spec}'"

" Remove highlighting
nnoremap <leader><space> :noh<cr>

" Save on focus lost
au focuslost * silent! :wa

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'johngallagher/vim-rspec'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'kana/vim-textobj-user'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdcommenter'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'vim-scripts/EasyGrep'
Plugin 'tpope/vim-abolish'
Plugin 'vim-scripts/csv.vim'
Plugin 'scrooloose/syntastic'
Plugin 'rizzatti/dash.vim'
Plugin 'krisajenkins/vim-pipe'
Plugin 'krisajenkins/vim-postgresql-syntax'
Plugin 'michaelavila/selecta.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

" HTML Tidy
vmap <Leader>x :!tidy -q -wrap 150 --indent yes --show-errors 0 -xml<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" For sql files connect to a local postgres database
let g:vimpipe_silent=1
autocmd FileType sql let b:vimpipe_command="psql -d lapsus_development -U root"
autocmd FileType sql let b:vimpipe_filetype="postgresql"

" Nice ruby playground
map <F4> <Plug>(xmpfilter-mark)
map <F5> <Plug>(xmpfilter-run)

" Ctrl P
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'undo']

" Vim Rspec
function! LoadAndDisplayRSpecQuickfix()
  let quickfix_filename = ".git/quickfix.out"
  if filereadable(quickfix_filename) && getfsize(quickfix_filename) != 0
    silent execute ":cfile " . quickfix_filename
    botright cwindow
    cc
  else
    redraw!
    echohl WarningMsg | echo "Quickfix file " . quickfix_filename . " is missing or empty." | echohl None
  endif
endfunction
 
noremap <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

" Dash
:nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = {
        \ 'ruby' : ['rails', 'ruby']
        \ }
