#!/bin/bash

# Add softlinks
ln -s $(pwd)/bashrc.d ~/.bashrc.d
ln -s $(pwd)/bash_profile ~/.bash_profile
ln -s $(pwd)/bashrc ~/.bashrc
ln -s $(pwd)/profile ~/.profile
ln -s $(pwd)/profile.d ~/.profile.d
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/nvimrc ~/.nvimrc
mkdir -p ~/.vim/after
mkdir -p ~/.nvim/after
ln -s $(pwd)/vim/after/ftplugin ~/.vim/after/ftplugin
ln -s $(pwd)/vim/after/ftplugin ~/.nvim/after/ftplugin
ln -s $(pwd)/Xresources ~/.Xresources

# Install Vundle plugins for Vim and NeoVim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.Vundle/Vundle.vim
vim +PluginInstall +qall
nvim +PluginInstall +qall

