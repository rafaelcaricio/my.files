#!/usr/bin/env bash

OK=`printf "\033[1;32m✓\033[0m"`
WARNING=`printf "\033[1;33m⚠\033[0m"`
ERROR=`printf "\033[1;31m✖\033[0m"`
OSX=$(test "`uname`" == "Darwin" && echo "x")
LINUX=$(test "`uname`" == "Linux" && echo "x")

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
    create_ln_for ".gitignore" "$pwd/.gitignore"
    create_ln_for ".zshrc" "$pwd/.zshrc"
    create_ln_for ".tmux.conf" "$pwd/.tmux.conf"
    if [ -e ".emacs.d/" ]; then
        echo "${OK} Prelude installed! Creating links to personal configurations..."
        # remove current prelude modules to be replaced
        rm .emacs.d/prelude-modules.el
        create_ln_for ".emacs.d/prelude-modules.el" "$pwd/emacs.d/prelude-modules.el"
        create_ln_for ".emacs.d/personal/emacs_config.el" "$pwd/emacs.d/personal/emacs_config.el"
    else
        echo "${WARNING} Please install Emacs Prelude: https://github.com/bbatsov/prelude#installation"
    fi

    mkdir -p "$pwd/.vim/autoload"
    curl -fLo "$pwd/.vim/autoload/plug.vim" --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

popd &> /dev/null

if [ $OSX ]; then
    echo "Executing some OSX specific changes..."
    if ! command_exists brew; then
      echo "Installing brew..."
      ruby -e "`curl -fsSkL raw.github.com/mxcl/homebrew/go`"
    fi
    brew install macvim --with-lua  --env-std --override-system-vim
    brew install emacs --with-cocoa
    brew install git bash-completion ack python ruby leiningen \
         tmux reattach-to-user-namespace pyenv tree wget gnupg gpg-agent \
         openssl pinentry pkg-config bash-completion json-c
    # decreases the delay repetition on keyboard
    defaults write NSGlobalDomain KeyRepeat -int 0
fi

if [ $LINUX ]; then
    if command_exists dnf; then
        sudo dnf install -y xclip wget
    fi
fi

if command_exists pyenv; then
    echo "3.6.1 3.5.3 2.7.13" | xargs -n 1 sudo pyenv install
    pyenv rehash
    sudo pyenv global 3.6.1
    # install basic python libraries
    sudo $HOME/.pyenv/shims/pip install -U -r python_tools.txt
fi

echo "Setting rebase to be the default for the master branch on this repo..."
git config branch.master.rebase true

echo "${OK} Done! 🤘"
