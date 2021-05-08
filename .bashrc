#!/usr/bin/env bash

# Prompt

export PS1="\W λ "

# Locale

export LC_ALL="en_US.UTF-8"
export LANG=$LC_ALL
export LANGUAGE=$LC_ALL

alias date="date +\"%Y-%m-%d %T\""

# Editor

EDITOR=$(command -v vim)
export EDITOR

# Aliases

alias bi="bundle install --path vendor/bundle"
alias df="df -h"
alias du="du -h"
alias ll="ls -hl"
alias vi="vim"

# Operating System

os=$(uname -s)

if [[ "$os" = "Darwin" ]]; then
  source "$HOME/.bashrc.darwin"
fi

if [[ "$os" = "Linux" ]]; then
  source "$HOME/.bashrc.linux"
fi

# Ruby

if [[ -n "$CHRUBY" ]] && [[ -r "$CHRUBY" ]]; then
  source "$CHRUBY"
fi

unset CHRUBY

# Git

if [[ -n "$GIT_COMPLETION" ]] && [[ -r "$GIT_COMPLETION" ]]; then
  source "$GIT_COMPLETION"
fi

unset GIT_COMPLETION

if [[ -n "$GIT_PROMPT" ]] && [[ -r "$GIT_PROMPT" ]]; then
  source "$GIT_PROMPT"
  export PS1="\W \$(__git_ps1 '(%s) ')λ "
fi

unset GIT_PROMPT

# Python

export VIRTUAL_ENV_DISABLE_PROMPT=1

# GPG

GPG_TTY=$(tty)
export GPG_TTY

# Path

export PATH="$HOME/bin:$PATH"

# External

bashrc_host="$HOME/.bashrc.host"

if [[ -r "$bashrc_host" ]]; then
  source "$bashrc_host"
fi
