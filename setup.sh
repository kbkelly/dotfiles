#!/bin/bash
export DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export VIM_DIR="$HOME/.vim"

ln -s "$DIR/.vimrc" ~
mkdir -p $VIM_DIR/{tmp,plugins,bundle,backups}
git clone https://github.com/gmarik/vundle.git "$VIM_DIR/bundle/vundle"
vim +BundleInstall +qall
