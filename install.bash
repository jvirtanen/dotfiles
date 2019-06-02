#!/usr/bin/env bash

if ! command -v curl >/dev/null; then
  echo "curl: Command not found"
  exit 1
fi

if ! command -v git >/dev/null; then
  echo "git: Command not found"
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

  if [ ! -e "$to" ] || [ $force_flag -ne 0 ]; then
    cp -f "$from" "$to"

    echo "Copy \"$to\""
  else
    echo "Skip \"$to\": File exists"
  fi
}

link_file() {
  local name=$1

  local from="$HOME/$name"
  local to="$PWD/$name"

  if [ ! -e "$from" ] || [ $force_flag -ne 0 ]; then
    ln -fns "$to" "$from"

    echo "Link \"$from\""
  else
    echo "Skip \"$from\": File exists"
  fi
}

clone_repository() {
  local from=$1
  local to=$2

  if [ ! -e "$to" ]; then
    git clone --quiet "$from" "$to"

    echo "Clone \"$to\""
  else
    git -C "$to" fetch --quiet
    git -C "$to" reset --quiet --hard origin/master

    echo "Update \"$to\""
  fi
}

create_directory "bin"

link_file "bin/git-amend"

link_file ".bash_profile"
link_file ".bashrc"
link_file ".bashrc.darwin"
link_file ".bashrc.linux"
link_file ".gitconfig"
link_file ".gitignore"
link_file ".hushlogin"
link_file ".tmux.conf"
link_file ".vim"
link_file ".vimrc"

if [ $colors_flag -ne 0 ]; then
  copy_file ".vimrc.colors" ".vimrc.colors"
fi

HTML5_VIM_URL="https://github.com/othree/html5.vim.git"
SCSS_SYNTAX_VIM_URL="https://github.com/cakebaker/scss-syntax.vim.git"
VIM_ANSIBLE_YAML_URL="https://github.com/chase/vim-ansible-yaml.git"
VIM_CSS3_SYNTAX="https://github.com/hail2u/vim-css3-syntax.git"
VIM_FUGITIVE_URL="https://github.com/tpope/vim-fugitive.git"
VIM_HCL_URL="https://github.com/jvirtanen/vim-hcl.git"
VIM_JAVASCRIPT_URL="https://github.com/pangloss/vim-javascript.git"
VIM_JINJA_URL="https://github.com/lepture/vim-jinja.git"
VIM_JSON_URL="https://github.com/elzr/vim-json.git"
VIM_LIQUID_URL="https://github.com/tpope/vim-liquid.git"
VIM_MARKDOWN_URL="https://github.com/tpope/vim-markdown.git"
VIM_SLEUTH_URL="https://github.com/tpope/vim-sleuth.git"
VIM_VINEGAR_URL="https://github.com/tpope/vim-vinegar.git"

pack=".vim/pack/default/start"

clone_repository $HTML5_VIM_URL "$pack/html5.vim"
clone_repository $SCSS_SYNTAX_VIM_URL "$pack/scss-syntax.vim"
clone_repository $VIM_ANSIBLE_YAML_URL "$pack/vim-ansible-yaml"
clone_repository $VIM_CSS3_SYNTAX "$pack/vim-css3-syntax"
clone_repository $VIM_FUGITIVE_URL "$pack/vim-fugitive"
clone_repository $VIM_HCL_URL "$pack/vim-hcl"
clone_repository $VIM_JAVASCRIPT_URL "$pack/vim-javascript"
clone_repository $VIM_JINJA_URL "$pack/vim-jinja"
clone_repository $VIM_JSON_URL "$pack/vim-json"
clone_repository $VIM_LIQUID_URL "$pack/vim-liquid"
clone_repository $VIM_MARKDOWN_URL "$pack/vim-markdown"
clone_repository $VIM_SLEUTH_URL "$pack/vim-sleuth"
clone_repository $VIM_VINEGAR_URL "$pack/vim-vinegar"

if [ $colors_flag -ne 0 ]; then
  BASE16_VIM_URL="https://github.com/jvirtanen/base16-vim.git"

  clone_repository $BASE16_VIM_URL "$pack/base16-vim"
fi
