#!/bin/bash

# Add softlinks
ln -s $(pwd)/bashrc.d ~/.bashrc.d
ln -s $(pwd)/bash_profile ~/.bash_profile
ln -s $(pwd)/bashrc ~/.bashrc
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/nvimrc ~/.nvimrc
ln -s $(pwd)/Xresources ~/.Xresources

# Install Vundle plugins for Vim and NeoVim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.Vundle/Vundle.vim
vim +PluginInstall +qall
nvim +PluginInstall +qall

