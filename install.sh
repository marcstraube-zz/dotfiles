#!/bin/bash

dotdir=~/Code/dotfiles
dotfiles=( \
	"bashrc.d" \
	"bash_profile" \
	"bashrc" \
	"profile" \
	"profile.d" \
	"Xresources" \
	"gitmessage" \
	"gitignore_global" \
	"vim" \
	"vimrc" \
	"nvim" \
	"nvimrc" \
)
repositories=( \
	"junegunn/vim-plug.git" \
)
backupdir=~/dotbackup

getRepositories() {
	echo "Clone and update repositories:"	
	for repo in ${repositories[@]}; do
		if [[ -d ${dotdir}/Vendor/${repo} ]]; then
			echo "Updating ${repo}"
			cd ${dotdir}/Vendor/${repo}
			git pull 
		else
			echo "Cloning ${repo}"
			git clone https://github.com/${repo} Vendor/${repo}
		fi
	done
}

backup() {
	echo "Back up original dotfiles to ${backupdir}."

	for file in ${dotfiles[@]}; do
		if [[ -f ~/.${file} ]] && [[ ! -s ~/.${file} ]] && [[ ${dotdir}/${file} != $(realpath ~/.${file}) ]]; then
			if [[ ! -d ${backupdir} ]]; then
			mkdir -p ${backupdir}
		fi

			 mv ~/.${file} ${backupdir}/.${file}
		fi
	done
}

setupVim() {
	echo "Setup Vim and NeoVim."

    	mkdir -p ${dotdir}/vim/autoload
	
	ln -s ${dotdir}/Vendor/junegunn/vim-plug.git/plug.vim \
		${dotdir}/vim/autoload/plug.vim

	mkdir -p ${dotdir}/nvim/{after/ftplugin,autoload}

	ln -s ${dotdir}/vim/after/ftplugin/javascript.vim \
		${dotdir}/nvim/after/ftplugin/javascript.vim

	ln -s ${dotdir}/Vendor/junegunn/vim-plug.git/plug.vim \
		${dotdir}/nvim/autoload/plug.vim

        vim +PlugInstall +qall
        nvim +PlugInstall +qall
}

addSymlinks() {
	echo "Adding symlinks."

	for file in ${dotfiles[@]}; do
		ln -s ${dotdir}/${file} ~/.${file}
	done
}

install() {
	backup
	clean
	getRepositories
	setupVim
	addSymlinks
        cp ${dotdir}/fortunes ~/fortunes

	echo "Done."
}

clean() {
	for file in ${dotfiles[@]}; do
		rm -rf ~/.${file}
	done
	
	rm -rf ${dotdir}/vim/autoload
	rm -rf ${dotdir}/nvim
}

cleanAll() {
	echo "Cleaning up."
	clean

	rm -rf ${dotdir}/Vendor

	echo "Restoring backups."
	if [[ -d ${backupdir} ]]; then
		for file in ${dotfiles[@]}; do
			cp ${backupdir}/.${file} ~/.${file} > /dev/null 2>&1
		done
	fi
}

$1
