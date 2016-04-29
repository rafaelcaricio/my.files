#!/usr/bin/env bash

OK=`printf "\033[1;32m✓\033[0m"`
WARNING=`printf "\033[1;33m⚠\033[0m"`
ERROR=`printf "\033[1;31m✖\033[0m"`
OSX=$(test "`uname`" == "Darwin" && echo "x")

# highlights values
hl() {
    printf "\033[1;37m$1\033[0m"
}

create_ln_for() {
    if [ ! -e "$1" ]; then
        ln -s "$2" "$1"
        echo "${OK} Symlink for `hl $1` created."
    elif [ -L "$1" ]; then
        echo "${OK} Symlink for `hl $1` was already created."
    else
        if [ -f "$1" ]; then
            echo "${WARNING} There is already a `hl $1` file inside your home folder."
        elif [ -d "$1" ]; then
            echo "${WARNING} There is already a `hl $1` folder inside your home folder."
        else
            echo "${ERROR} `hl $1` isn't a symlink nor a folder nor a file. Do something!"
            exit 1
        fi
    fi
}

command_exists() {
  hash $1 2> /dev/null
}

pwd=$PWD

pushd $HOME &> /dev/null
    create_ln_for ".gitconfig" "$pwd/.gitconfig"
    create_ln_for ".zshrc" "$pwd/.zshrc"
    create_ln_for ".tmux.conf" "$pwd/.tmux.conf"
    # remove current prelude modules to be replaced
    rm .emacs.d/prelude-modules.el
    create_ln_for ".emacs.d/prelude-modules.el" "$pwd/emacs.d/prelude-modules.el"
    create_ln_for ".emacs.d/personal/emacs_config.el" "$pwd/emacs.d/personal/emacs_config.el"
popd &> /dev/null

if [ $OSX ]; then
    echo "Executing some OSX specific changes..."
    if ! command_exists brew; then
      echo "Installing brew..."
      ruby -e "`curl -fsSkL raw.github.com/mxcl/homebrew/go`"
    fi
  ##brew install macvim --with-lua  --env-std --override-system-vim
    brew install emacs --with-cocoa
    brew install git bash-completion ack python ruby leiningen \
      tmux reattach-to-user-namespace pyenv tree
    # decreases the delay repetition on keyboard
    defaults write NSGlobalDomain KeyRepeat -int 0
fi

echo "Setting rebase to be the default for the master branch on this repo..."
git config branch.master.rebase true

