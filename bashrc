#!/usr/bin/env bash

# Working with colors:
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
#
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

function mkcd() {
  mkdir "$1"
  cd "$1" > /dev/null
  echo -e "\e$BGreen Created\e$Color_Off `realpath ..`/\e$BBlue`basename $(pwd)`\e$Color_Off"
}

# .oh-my-zsh/lib/directories.sh creates an alias for 'l' by default
# This disables it
unalias l
function l() {
  exa -alhmF --git --group-directories-first  --color-scale $1
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function e() {
  code ${1:-.}
}

function p() {
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function cd() {
  HOME=~/Code builtin cd -P "$@" > /dev/null
  p
}

function chpwd() {
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function ne {
  (PATH=$(npm bin):$PATH; eval $@;)
}

function p5-start {
  git clone https://github.com/cdfuller/p5-skeleton "$1"
  cd "$1"
  rm -rf .git
}

# Create path and file
# https://stackoverflow.com/a/37567557
ptouch() {
    for p in "$@"; do
        _dir="$(dirname -- "$p")"
        [ -d "$_dir" ] || mkdir -p -- "$_dir"
    touch -- "$p"
    done
}

# Docker alias and function
# Removed, but link left for possible future use
# https://gist.github.com/jverdeyen/741d29a8e8d7a8e5d4dd4346fd1bd788


alias .="l"
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias d="python ~/.dotFiles/separate.py"
alias dbreset="rails db:drop && rails db:create && rails db:migrate && rails db:seed"
alias g="git"
alias ga="git add"
alias gst="git status"
alias gc="git commit -m "
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias m="mix"
alias i="iex"
alias im="iex -S mix"
alias ip="ipython"
alias mp="mix phx.server"
alias mt="mix test --slowest 25 --seed 0"
alias python="python3"
alias pip="pip3"
alias server="python3 -m http.server"
alias s="server"
alias t="exa -l --git --group-directories-first -T"

export PYTHONSTARTUP="$HOME/.pythonrc"

export CDPATH=~/Code:~/Code/sandbox:~/.dotFiles/CDPATH

export GOPATH=~/.go

export HISTCONTROL=ignorespace

# Enable shell history in IEx
export ERL_AFLAGS="-kernel shell_history enabled"

# Homebrew ruby
PATH="/usr/local/opt/ruby/bin:$PATH"

# Add bin directory for git subcommands
PATH="$HOME/.dotFiles/bin:$PATH"

# Transport tech dev-tools
PATH="$HOME/Code/dev-tools/bin:$PATH"

# make
PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export TT_DEV_BACKUP_DIR="$HOME/Code/DB_BACKUPS"

# elixir
PATH="$HOME/.mix:$PATH"
export PATH

export TT_DEV_BACKUP_DIR="$HOME/Code/DB_BACKUPS"

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var repoDir $(basename $(git rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
