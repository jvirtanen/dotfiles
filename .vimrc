" General

set nocompatible
set ruler

set backspace=indent,eol,start

filetype plugin on

" Syntax

syntax on

set showmatch

" Indentation

set autoindent

" File Types

autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

" Search

set incsearch
set hlsearch

" Colors

let vimrc_colors = "$HOME/.vimrc.colors"

if filereadable(expand(vimrc_colors))
    exec "source ".vimrc_colors
endif

" External

let vimrc_host = "$HOME/.vimrc.host"

if filereadable(expand(vimrc_host))
    exec "source ".vimrc_host
endif

set exrc
set secure
