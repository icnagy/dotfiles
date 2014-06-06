set nocompatible              " be iMproved, required
filetype off                  " required

set shell=zsh
runtime macros/matchit.vim

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set tags=./tags,tags

colorscheme slate

set hidden
set guifont=monaco:h14

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

let g:quickfix_filename = ".git/quickfix.out"
let g:rspec_command = "silent !~/.vim/bundle/vim-rspec/bin/os_x_iterm 'clear && rspec -f rspec::core::formatters::vimquickfixformatter -r ~/.vim/bundle/vim-rspec/plugin/formatter/vim_quickfix_formatter.rb --out ".g:quickfix_filename." --format progress {spec}'"

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
au focuslost * :wa

set relativenumber
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
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()            " required
filetype plugin indent on    " required

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

