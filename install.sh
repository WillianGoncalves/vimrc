#!/bin/sh

BASEDIR=$(pwd)

#install dependencies
sudo apt-get install build-essential cmake

# install powerline fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Fira Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20for%20Powerline%20Nerd%20Font%20Complete.otf?raw=true

#ln -sf $BASEDIR/vim ~/.vim
echo Creating symlink for $BASEDIR/vim/vimrc
ln -sf $BASEDIR/vim/vimrc ~/.vimrc
ln -sf $BASEDIR/vim/rcplugins ~/.vim/rcplugins
sudo vim +PlugInstall +qall

ln -sf $BASEDIR/tmux/.tmux.conf ~/.tmux.conf
