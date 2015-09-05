set nocompatible              " be iMproved, required
filetype off                  " required

set lines=999 columns=999

set shell=$SHELL
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
set laststatus=2

set lazyredraw
set background=dark
let base16colorspace=256
set t_Co=256
colorscheme grb256
syntax enable

" Window Movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Rspec.vim
let g:quickfix_filename = ".git/quickfix.out"
let g:rspec_command = "silent !~/.vim/bundle/vim-rspec/bin/os_x_iterm 'clear && be rspec  --require /Users/johngallagher/.vim/bundle/vim-rspec/plugin/formatter/vim_quickfix_formatter.rb  --format VimQuickfixFormatter --no-color --out ".g:quickfix_filename."  --format progress --color {spec}'"

" Remove highlighting
nnoremap <leader><space> :noh<cr>

" Save on focus lost
au focuslost * silent! :wa

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'johngallagher/vim-rspec'
Plugin 'godlygeek/tabular'
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
Plugin 'vim-scripts/CSApprox'
Plugin 'vim-scripts/SQLUtilities'
Plugin 'mkitt/browser-refresh.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="context"
set runtimepath+=~/.vim/UltiSnips


call vundle#end()            " required
filetype plugin indent on    " required

" Nice ruby playground
map <Leader>d <Plug>(xmpfilter-mark)
map <Leader>f <Plug>(xmpfilter-run)

" HTML Tidy
vmap <Leader>x :!tidy -q -wrap 150 --indent yes --show-errors 0 -xml<CR>

" Ctrl P
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'undo']

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --ignore=vcr_cassettes'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" For sql files connect to a local postgres database
let g:vimpipe_silent=1
let g:vimpipe_invoke_map="<Leader>w"
autocmd FileType sql let b:vimpipe_command="mysql -D arnoldclark__co__uk -ujohn -h dev.arnoldclark.com -p"
autocmd FileType sql let b:vimpipe_filetype="mysql"

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
    copen
  else
    :redraw!
    :echo "This test file is passing."
  endif
endfunction
function! RunAllMacBaconTests() 
  :wall
  :silent !clear; rake spec
  if v:shell_error > 0
    :!echo "Errors in test shown above."
  else
    :redraw!
    :echo "All tests are passing."
  endif
endfunction
 
noremap <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

map <Leader>aa :wall<CR>:Rake test<CR>
map <Leader>at :wall<CR>:Rake<CR>
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

map <Leader>b :wall<CR>:!clear; bacon -a -q<CR>
noremap <Leader>q :wall<CR>:!clear; echo 'Running reek...' && reek app && echo 'Running flog...' && flog app && echo 'Running rubocop...' && rubocop -a<CR>

vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

" Custom experimental functions
function! Grabber()
  :r !echo $(osascript -e 'tell application "Google Chrome"' -e 'tell window 1' -e 'tell active tab' -e 'execute javascript "new XMLSerializer().serializeToString(document);"' -e 'end tell' -e 'end tell' -e 'end tell' | nokogiri -e 'puts $_.css("code,pre").map {|c| c.text.gsub("\n", "\\n") }' | selecta)
endfunction

map <Leader>gb :call Grabber()<CR>

