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
  cd "$1"
  echo -e "\e$BGreen Created\e$Color_Off `realpath ..`/\e$BBlue`basename $(pwd)`\e$Color_Off"
}

# .oh-my-zsh/lib/directories.sh creates an alias for 'l' by default
# This disables it
unalias l
function l() {
  exa -alhmF --git --group-directories-first $1
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function p() {
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function chpwd() {
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function ne {
  (PATH=$(npm bin):$PATH; eval $@;)
}

# ------------------------------------
# Docker alias and function
# https://gist.github.com/jverdeyen/741d29a8e8d7a8e5d4dd4346fd1bd788
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

alias dc="docker-compose"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Execute command in Docker Compose service¬
dexec() { docker exec -it `docker-compose ps -q $1` $2; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

alias dps="docker ps -q | xargs docker inspect --format '{{ .Id }} - {{ .Name }} - {{ .NetworkSettings.IPAddress }}'"

# ------------------------------------
# ------------------------------------
# ------------------------------------

alias be="bundle exec"
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias c='code'
alias cd='HOME=~/Code cd'
alias d="python ~/Code/separate.py"
alias dbreset="rails db:drop && rails db:create && rails db:migrate && rails db:seed"
alias ga="git add"
alias gst="git status"
alias gc="git commit -m "
alias gd="git diff --word-diff"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias i="PYENV_VERSION=3.6.4 ipython"
alias open-docker="socat -d TCP-LISTEN:2375,reuseaddr,fork UNIX:/var/run/docker.sock"
alias server="python -m http.server"
alias s="server"
alias t="exa -l --git --group-directories-first -T"


export PYTHONSTARTUP="$HOME/.pythonrc"

export CDPATH=~/Code:~/Code/sandbox:~/.dotFiles/CDPATH

export GOPATH=~/.go

export HISTCONTROL=ignorespace

PATH="$HOME/.dotFiles/bin:$PATH"
export PATH

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

PATH="$(pyenv root)/shims:/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
PATH="$(pyenv root)/shims:${PATH}"
export PATH

# Use cli tools from Postgres.app
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"
export PATH

# export PYENV_ROOT=/usr/local/opt/pyenv 
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var repoDir $(basename $(git rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
}

