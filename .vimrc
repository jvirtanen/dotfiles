" Pathogen
" --------

call pathogen#infect()

" General
" -------

set nocompatible
set ruler

filetype plugin on

" Syntax
" ------

syntax on

set showmatch

" Indentation
" -----------

set autoindent

" Filetypes
" ---------

autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.m set filetype=octave
autocmd BufRead,BufNewFile *.podspec set filetype=ruby
autocmd BufRead,BufNewFile *.ronn set filetype=markdown
autocmd BufRead,BufNewFile *.sbt set filetype=scala
autocmd BufRead,BufNewFile Gemfile set filetype=ruby
autocmd BufRead,BufNewFile Podfile set filetype=ruby
autocmd BufRead,BufNewFile Procfile set filetype=ruby
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" Search
" ------

set incsearch
set hlsearch

" External
" --------

let vimrc_host = "$HOME/.vimrc.host"

if filereadable(expand(vimrc_host))
    exec "source ".vimrc_host
endif

set exrc
set secure
