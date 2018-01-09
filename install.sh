#!/bin/sh

############################  BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

warn() {
    msg "WARNING: ${1}"
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

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
    command -v brew
    if [ "$?" -eq 0 ]; then
        brew install zsh
        brew install tree
        brew install tmux
        brew install ctags
        brew install macvim --with-override-system-vim
        brew install autojump
    else
        echo "WARNING"
    fi
}

install_pip(){
    python get-pip.py --prefix=/usr/local/
    easy_install nose
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
    program_must_exist "python"
    program_must_exist "vim"
    program_must_exist "git"
    create_symlinks
    install_brew
    install_with_brew
    install_pip
    install_oh_my_zsh
    install_vundle
    install_tpm
}

main
