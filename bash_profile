
# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="$(pyenv root)/shims:/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi