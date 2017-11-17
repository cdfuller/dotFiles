#!/usr/bin/env bash

function mkcd() {
  mkdir "$1"
  cd "$1"
}
function ne do { (PATH=$(npm bin):$PATH; eval $@;) }

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

# # export PYENV_ROOT=/usr/local/opt/pyenv 
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

cowsay $(fortune -a)
