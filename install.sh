#!/bin/sh

#install dependencies
sudo apt-get install build-essential cmake

# install powerline fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Ubuntu Mono for Powerline Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20derivative%20Powerline%20Nerd%20Font%20Complete.ttf

BASEDIR="$(cd "$( dirname "$0")" && pwd)"
ln -sf $BASEDIR/vim ~/.vim
ln -sf $BASEDIR/vimrc ~/.vimrc
sudo vim +PlugInstall +qall

