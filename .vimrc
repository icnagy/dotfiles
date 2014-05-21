set nocompatible              " be iMproved, required
filetype off                  " required

set shell=zsh
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set tags=./tags,tags

let g:rspec_runner = "os_x_iterm"
let g:rspec_clear = "on"

let g:quickfix_filename = ".git/quickfix.out"
let g:rspec_command = "silent !/Users/John/.vim/bundle/vim-rspec/bin/os_x_iterm 'clear && rspec -f RSpec::Core::Formatters::VimQuickfixFormatter -r /Users/John/.vim/bundle/vim-rspec/plugin/formatter/vim_quickfix_formatter.rb --out ".g:quickfix_filename." --format progress {spec}'"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 " 256 colors
:set background=dark
:color grb256

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'

call vundle#end()            " required
filetype plugin indent on    " required

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

function! LoadAndDisplayRSpecQuickfix()
  if filereadable(g:quickfix_filename) && getfsize(g:quickfix_filename) != 0
    silent execute ":cfile " . g:quickfix_filename
    botright cwindow
    cc
  else
    redraw!
    echohl WarningMsg | echo "Quickfix file " . g:quickfix_filename . " is missing or empty." | echohl None
  endif
endfunction

noremap <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

