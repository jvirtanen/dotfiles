#!/usr/bin/env bash

# Path
# ----

export PATH="$HOME/bin:$PATH"

# Prompt
# ------

export PS1="\W λ "

# Locale
# ------

export LC_ALL="en_US.UTF-8"
export LANG=$LC_ALL
export LANGUAGE=$LC_ALL

alias date="date +\"%Y-%m-%d %T\""

# Editor
# ------

export EDITOR="/usr/bin/vim"

# Aliases
# -------

alias du="du -h"
alias ll="ls -hl"
alias tags="ctags -R"

# Operating System
# ----------------

export OS="`uname -s`"

if [ $OS = "Darwin" ]; then
  source "$HOME/.bashrc.darwin"
fi

if [ $OS = "Linux" ]; then
  source "$HOME/.bashrc.linux"
fi

# Git
# ---

if [ ! -z $GIT_COMPLETION -a -r $GIT_COMPLETION ]; then
  source $GIT_COMPLETION
fi

if [ ! -z $GIT_PROMPT -a -r $GIT_PROMPT ]; then
  source $GIT_PROMPT
  export PS1="\W \$(__git_ps1 '(%s) ')λ "
fi

# rbenv
# -----

RBENV="$HOME/.rbenv/bin/rbenv"

if [ -x $RBENV ]; then
  export PATH="`dirname $RBENV`:$PATH"
  eval "$(rbenv init -)"
fi

# External
# --------

export BASHRC_HOST="$HOME/.bashrc.host"

if [ -r $BASHRC_HOST ]; then
  source $BASHRC_HOST
fi
