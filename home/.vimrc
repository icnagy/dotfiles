set nocompatible              " be iMproved, required
filetype off                  " required

set shell=/usr/local/bin/zsh
runtime macros/matchit.vim

set autoread
set noswapfile
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set vb
set noerrorbells

set tags=./tags,tags

colorscheme slate

set hidden
set guifont=Monaco:h14

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

let g:quickfix_filename = ".git/quickfix.out"
let g:rspec_command = "silent !~/.vim/bundle/vim-rspec/bin/os_x_iterm 'clear && rspec -f RSpec::Core::Formatters::VimQuickfixFormatter -r ~/.vim/bundle/vim-rspec/plugin/formatter/vim_quickfix_formatter.rb --out ".g:quickfix_filename." --format progress {spec}'"

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
au focuslost * :wa

set number
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
Plugin 'scrooloose/nerdtree'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'vim-scripts/EasyGrep'
Plugin 'tpope/vim-abolish'

call vundle#end()            " required
filetype plugin indent on    " required

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

map <F4> <Plug>(xmpfilter-mark)
map <F5> <Plug>(xmpfilter-run)

let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'

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
