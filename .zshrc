#!/usr/bin/env zsh

# Keys

bindkey -e

# Prompt

export PS1="%1/ λ "

# Locale

export LC_ALL="en_US.UTF-8"
export LANG=$LC_ALL
export LANGUAGE=$LC_ALL

alias date="date +\"%Y-%m-%d %T\""

# Editor

EDITOR=$(command -v vim)
export EDITOR

# tmux

if command -v reattach-to-user-namespace >/dev/null; then
  reattach_to_user_namespace="reattach-to-user-namespace"
fi

# Aliases

alias bi="bundle install --path vendor/bundle"
alias df="df -h"
alias du="du -h"
alias edit="open -e"
alias ll="ls -Ghl"
alias open="$reattach_to_user_namespace open"
alias vi="vim"

# Ruby

chruby="/usr/local/opt/chruby/share/chruby/chruby.sh"

if [[ -r $chruby ]]; then
  source $chruby
fi

# Python

export VIRTUAL_ENV_DISABLE_PROMPT=1

# GPG

GPG_TTY=$(tty)
export GPG_TTY

# Homebrew

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Java

java_home="/usr/libexec/java_home"

if [[ -x "$java_home" ]]; then
  JAVA_HOME=$("$java_home" --version "1.8")
  export JAVA_HOME

  if "$java_home" --version "11" >/dev/null; then
    alias jshell="JAVA_HOME=$("$java_home" --version "11") jshell"
  fi
fi

# Path

export PATH="$HOME/bin:$PATH"

# External

zshenv_host="$HOME/.zshenv.host"

if [[ -r $zshenv_host ]]; then
  source $zshenv_host
fi