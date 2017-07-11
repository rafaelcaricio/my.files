source $HOME/.rc_common.sh

# dev env
PATH_TO_MONOREPO=$DEV_HOME/newstore

# custom aliases
alias ll='ls -lah --color'

export PS1="\[$(tput bold)\]\[$(tput setaf 4)\]\u \[$(tput setaf 4)\]@\[$(tput setaf 2)\]\w\[$(tput setaf 4)\] \\$ \[$(tput sgr0)\]"
