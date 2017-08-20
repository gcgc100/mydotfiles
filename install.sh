#!/bin/sh

HOME=${HOME}
PWD=`pwd`
OH_MY_ZSH=${HOME}"/.oh-my-zsh"
VUNDLE=${HOME}"/.vim/bundle/Vundle.vim"
TMUXPLUGINMANAGER=${HOME}"/.tmux/plugins/tpm"

create_symlinks() {
    dotfiles=(".bashrc" ".gitconfig" ".screenrc" ".tmux.conf" ".zshrc" 
    ".vimrc" ".vim" ".tmux")
    for dotfile in "${dotfiles[@]}"
    do
        ln -sf ${PWD}/${dotfile} ${HOME}/${dotfile}
        echo "Create symlink ${HOME}/${dotfile}"
    done
}

install_brew(){
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_with_brew(){
    brew install zsh
    brew install tree
    brew install tmux
    brew install ctags
    brew install macvim --with-override-system-vim
    brew install autojump
}

install_pip(){
    sudo python get-pip.py
    sudo easy_install nose
}

install_oh_my_zsh(){
	if [ -d "${OH_MY_ZSH}"  ]; then
		cd "${OH_MY_ZSH}"
		echo "Change directory to `pwd`"
		echo "${OH_MY_ZSH} exists. Git pull to update..."
		git pull
		cd - > /dev/null 2>&1
		echo "Change directory back to `pwd`"
	else
		echo "${OH_MY_ZSH} not exists. Install..."
		#git clone git@github.com:robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
		#wget --no-check-certificate http://install.ohmyz.sh -O - | sh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		#git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
	fi
}

# Vim install `Vundle` and plugins
install_vundle(){
	if [ -d "${VUNDLE}" ]; then
		cd "${VUNDLE}"
		echo "Change directory to `pwd`"
		echo "${VUNDLE} exists. Git pull to update..."
		git pull
		cd - > /dev/null 2>&1
		echo "Change directory back to `pwd`"
	else
		echo "${VUNDLE} not exists. Git clone to create..."
		git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLE}
		vim +PluginInstall +qall
	fi
}

# Tmux install `TPM`
install_tpm(){
	if [ -d "${TMUXPLUGINMANAGER}" ]; then
		cd "${TMUXPLUGINMANAGER}"
		echo "Change directory to `pwd`"
		echo "${TMUXPLUGINMANAGER} exists. Git pull to update..."
		git pull
		cd - > /dev/null 2>&1
		echo "Change directory back to `pwd`"
	else
		echo "${TMUXPLUGINMANAGER} not exists. Git clone to create..."
		git clone https://github.com/tmux-plugins/tpm ${TMUXPLUGINMANAGER}
	fi
}

main() {
    create_symlinks
    install_brew
    install_with_brew
    install_pip
    install_oh_my_zsh
    install_vundle
    install_tpm
}

main
