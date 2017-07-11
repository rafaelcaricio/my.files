export PATH="/usr/local/opt/go@1.7/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"
export PS1='$PWD$ '

ulimit -n 2048

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# do not create .pyc files
export PYTHONDONTWRITEBYTECODE=x

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source ~/.pyenv/versions/3.6.1/bin/virtualenvwrapper.sh
export VIRTUALENV_DISTRIBUTE=1

# golang configuration
mkdir -p $DEV_HOME/go
export GOPATH=$DEV_HOME/go
export PATH="$GOPATH/bin:$PATH"

# dev env
PATH_TO_MONOREPO=$DEV_HOME/newstore
if [ -f "${PATH_TO_MONOREPO}/tools/environment.sh" ]; then
  cd $PATH_TO_MONOREPO && source "${PATH_TO_MONOREPO}/tools/environment.sh"
fi

alias ll='ls -lah --color'

