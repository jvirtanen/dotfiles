#!/usr/bin/env bash

which curl >/dev/null
if [ $? -ne 0 ]; then
  echo "install.bash: curl: Command not found"
  exit 1
fi

which git >/dev/null
if [ $? -ne 0 ]; then
  echo "install.bash: git: Command not found"
  exit 1
fi

set -e

function usage {
  echo "Usage: install.bash [-f]"
  exit 2
}

force_flag=0

while getopts :f opt; do
  case $opt in
  f)
     force_flag=1
     ;;
  ?)
     usage
     ;;
  esac
done

function link_file {
  local name=$1

  local from="$HOME/$name"
  local to="$PWD/$name"

  if [ ! -e $from -o $force_flag -ne 0 ]; then
    ln -fns $to $from
  else
    echo "install.bash: $from: File exists"
  fi
}

function download_file {
  local from=$1
  local to=$2

  if [ ! -e $to -o $force_flag -ne 0 ]; then
    curl --silent --show-error --output $to $from
  else
    echo "install.bash: $to: File exists"
  fi
}

function clone_repository {
  local from=$1
  local to=$2

  if [ ! -e $to ]; then
    git clone --quiet $from $to
  else
    cd $to
    git fetch --quiet
    git reset --quiet --hard origin/master
    cd $OLDPWD
  fi
}

link_file ".bash_profile"
link_file ".bashrc"
link_file ".bashrc.darwin"
link_file ".bashrc.linux"
link_file ".ctags"
link_file ".gdbinit"
link_file ".gitconfig"
link_file ".gitignore"
link_file ".hushlogin"
link_file ".tmux.conf"
link_file ".vim"
link_file ".vimrc"

VIM_PATHOGEN_URL="https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"

download_file $VIM_PATHOGEN_URL ".vim/autoload/pathogen.vim"

HTML5_VIM_URL="git://github.com/othree/html5.vim.git"
VIM_FUGITIVE_URL="git://github.com/tpope/vim-fugitive.git"
VIM_GOLANG_URL="git://github.com/jnwhiteh/vim-golang.git"
VIM_LIQUID_URL="git://github.com/tpope/vim-liquid.git"
VIM_MARKDOWN_URL="git://github.com/tpope/vim-markdown.git"
VIM_OCTAVE_URL="git://github.com/jvirtanen/vim-octave.git"
VIM_RUBY_URL="git://github.com/vim-ruby/vim-ruby.git"
VIM_SCALA_URL="git://github.com/derekwyatt/vim-scala.git"
VIM_SLEUTH_URL="git://github.com/tpope/vim-sleuth.git"

clone_repository $HTML5_VIM_URL ".vim/bundle/html5.vim"
clone_repository $VIM_FUGITIVE_URL ".vim/bundle/vim-fugitive"
clone_repository $VIM_GOLANG_URL ".vim/bundle/vim-golang"
clone_repository $VIM_LIQUID_URL ".vim/bundle/vim-liquid"
clone_repository $VIM_MARKDOWN_URL ".vim/bundle/vim-markdown"
clone_repository $VIM_OCTAVE_URL ".vim/bundle/vim-octave"
clone_repository $VIM_RUBY_URL ".vim/bundle/vim-ruby"
clone_repository $VIM_SCALA_URL ".vim/bundle/vim-scala"
clone_repository $VIM_SLEUTH_URL ".vim/bundle/vim-sleuth"
