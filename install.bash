#!/usr/bin/env bash

command -v curl >/dev/null
if [ $? -ne 0 ]; then
  echo "install.bash: curl: Command not found"
  exit 1
fi

command -v git >/dev/null
if [ $? -ne 0 ]; then
  echo "install.bash: git: Command not found"
  exit 1
fi

set -e

usage() {
  echo "Usage: install.bash [-c] [-f]"
  exit 2
}

colors_flag=0
force_flag=0

while getopts :cf opt; do
  case $opt in
  c)
    colors_flag=1
    ;;
  f)
    force_flag=1
    ;;
  ?)
    usage
    ;;
  esac
done

create_directory() {
  local name=$1

  mkdir -p "$HOME/$name"
}

copy_file() {
  local from="$1"
  local to="$HOME/$2"

  if [ ! -e $to -o $force_flag -ne 0 ]; then
    cp -f $from $to
  else
    echo "install.bash: $to: File exists"
  fi
}

link_file() {
  local name=$1

  local from="$HOME/$name"
  local to="$PWD/$name"

  if [ ! -e $from -o $force_flag -ne 0 ]; then
    ln -fns $to $from
  else
    echo "install.bash: $from: File exists"
  fi
}

download_file() {
  local from=$1
  local to=$2

  if [ ! -e $to -o $force_flag -ne 0 ]; then
    curl --location --silent --show-error --output $to $from
  else
    echo "install.bash: $to: File exists"
  fi
}

clone_repository() {
  local from=$1
  local to=$2

  if [ ! -e $to ]; then
    git clone --quiet $from $to
  else
    git -C $to fetch --quiet
    git -C $to reset --quiet --hard origin/master
  fi
}

create_directory "bin"

link_file "bin/git-amend"

link_file ".bash_profile"
link_file ".bashrc"
link_file ".bashrc.darwin"
link_file ".bashrc.linux"
link_file ".ctags"
link_file ".gitconfig"
link_file ".gitignore"
link_file ".hushlogin"
link_file ".tmux.conf"
link_file ".vim"
link_file ".vimrc"

if [ $colors_flag -ne 0 ]; then
  copy_file ".vimrc.colors" ".vimrc.colors"
fi

VIM_PATHOGEN_URL="https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"

download_file $VIM_PATHOGEN_URL ".vim/autoload/pathogen.vim"

HTML5_VIM_URL="https://github.com/othree/html5.vim.git"
SCSS_SYNTAX_VIM_URL="https://github.com/cakebaker/scss-syntax.vim.git"
VIM_ANSIBLE_YAML_URL="https://github.com/chase/vim-ansible-yaml.git"
VIM_CSS3_SYNTAX="https://github.com/hail2u/vim-css3-syntax.git"
VIM_FUGITIVE_URL="https://github.com/tpope/vim-fugitive.git"
VIM_JAVASCRIPT_URL="https://github.com/pangloss/vim-javascript.git"
VIM_JINJA_URL="https://github.com/lepture/vim-jinja.git"
VIM_JSON_URL="https://github.com/elzr/vim-json.git"
VIM_LIQUID_URL="https://github.com/tpope/vim-liquid.git"
VIM_MARKDOWN_URL="https://github.com/tpope/vim-markdown.git"
VIM_RUBY_URL="https://github.com/vim-ruby/vim-ruby.git"
VIM_SCALA_URL="https://github.com/derekwyatt/vim-scala.git"
VIM_SLEUTH_URL="https://github.com/tpope/vim-sleuth.git"
VIM_VINEGAR_URL="https://github.com/tpope/vim-vinegar.git"

clone_repository $HTML5_VIM_URL ".vim/bundle/html5.vim"
clone_repository $SCSS_SYNTAX_VIM_URL ".vim/bundle/scss-syntax.vim"
clone_repository $VIM_ANSIBLE_YAML_URL ".vim/bundle/vim-ansible-yaml"
clone_repository $VIM_CSS3_SYNTAX ".vim/bundle/vim-css3-syntax"
clone_repository $VIM_FUGITIVE_URL ".vim/bundle/vim-fugitive"
clone_repository $VIM_JAVASCRIPT_URL ".vim/bundle/vim-javascript"
clone_repository $VIM_JINJA_URL ".vim/bundle/vim-jinja"
clone_repository $VIM_JSON_URL ".vim/bundle/vim-json"
clone_repository $VIM_LIQUID_URL ".vim/bundle/vim-liquid"
clone_repository $VIM_MARKDOWN_URL ".vim/bundle/vim-markdown"
clone_repository $VIM_RUBY_URL ".vim/bundle/vim-ruby"
clone_repository $VIM_SCALA_URL ".vim/bundle/vim-scala"
clone_repository $VIM_SLEUTH_URL ".vim/bundle/vim-sleuth"
clone_repository $VIM_VINEGAR_URL ".vim/bundle/vim-vinegar"

if [ $colors_flag -ne 0 ]; then
  BASE16_VIM_URL="https://github.com/chriskempson/base16-vim.git"

  clone_repository $BASE16_VIM_URL ".vim/bundle/base16-vim"
fi
