#!/usr/bin/env bash

function mkcd() {
  mkdir "$1"
  cd "$1"
}
function ne do { (PATH=$(npm bin):$PATH; eval $@;) }

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
alias d="python ~/Code/separate.py"
alias dbreset="rails db:drop && rails db:create && rails db:migrate && rails db:seed"
alias gst="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias gd="git diff --word-diff"
alias l="exa -alhmF --git --group-directories-first"
alias open-docker="socat -d TCP-LISTEN:2375,reuseaddr,fork UNIX:/var/run/docker.sock"
alias server="python -m http.server"
alias t="exa -l --git --group-directories-first -T"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

PATH="$(pyenv root)/shims:/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
PATH="$(pyenv root)/shims:${PATH}"
export PATH

# # PATH="$(pyenv root)/shims:/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
PATH="$(pyenv root)/shims:${PATH}"
export PATH

PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"
export PATH

# # export PYENV_ROOT=/usr/local/opt/pyenv 
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

cowsay $(fortune -a)
