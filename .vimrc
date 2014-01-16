" Pathogen
" --------

call pathogen#infect()

" General
" -------

set nocompatible
set ruler

set backspace=indent,eol,start

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

autocmd BufRead,BufNewFile *.ronn set filetype=markdown
autocmd BufRead,BufNewFile Procfile set filetype=yaml

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
