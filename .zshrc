# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
#alias zshconfig="$EDITOR ~/.zshrc"
#alias ohmyzsh="$EDITOR $ZSH"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew django github pip python npm node rvm)

source $ZSH/oh-my-zsh.sh


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Make sure development dir exists
mkdir -p ~/development
export DEV_HOME=~/development

ulimit -n 2048

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# do not create .pyc files
export PYTHONDONTWRITEBYTECODE=x

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export VIRTUALENV_DISTRIBUTE=1

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"

# golang configuration
mkdir -p $DEV_HOME/go
export GOPATH=$DEV_HOME/go
export PATH="$GOPATH/bin:$PATH"

# Java configuration
export JAVA_HOME=`/usr/libexec/java_home`

# GPG agent configuration
gpgconf --launch gpg-agent

# Ensure that GPG Agent is used as the SSH agent
export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh

# General aliases

# push new branch in remote
alias pushpr='git push 2>&1 | grep git | sed -e "$!d" | xargs -ICMD bash -c "CMD"'
