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
    program_exists $1 || error  "You must have '$1' installed to continue."
}

HOME=${HOME}
PWD=`pwd`
OH_MY_ZSH=${HOME}"/.oh-my-zsh"
VUNDLE=${HOME}"/.vim/bundle/Vundle.vim"
TMUXPLUGINMANAGER=${HOME}"/.tmux/plugins/tpm"

create_symlinks() {
    dotfiles=(".bashrc" ".gitconfig" ".screenrc" ".tmux.conf" ".zshrc" 
    ".vimrc" ".lynxrc")
    for dotfile in "${dotfiles[@]}"; do
        ln -sf ${PWD}/${dotfile} ${HOME}/${dotfile} || error "Create symlink ${dotfile} failed."
        echo "Create symlink ${HOME}/${dotfile}"
    done
    dotDirs=(".vim" ".tmux")
    for dotdir in "${dotDirs[@]}"; do
        ln -sfn ${PWD}/${dotdir} ${HOME}/${dotdir} || error "Create symlink to dir (${dotdir}) failed."
    done
    ret=0
    success "Create symlink success"
    echo 'export DOTFILEDIR='${PWD} > ~/.gc
}

install_brew(){
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &>/dev/null || error "Install brew failed"
    success "Install brew successfully"
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
        success "Brew packages installed"
    else
        warn "brew cmd not found"
    fi
}

install_pip(){
    python get-pip.py --prefix=/usr/local/ &>/dev/null || error "Install pip failed"
    success "Install pip successfully"
    easy_install nose &>/dev/null || error "Install nosetests failed"
    success "Install nosetests successfully"
}

install_oh_my_zsh(){
	if [ -d "${OH_MY_ZSH}"  ]; then
		cd "${OH_MY_ZSH}"
		msg "Change directory to `pwd`"
		msg "${OH_MY_ZSH} exists. Git pull to update..."
		git pull &>/dev/null || error "Update oh-my-zsh failed"
		cd - > /dev/null 2>&1
		msg "Change directory back to `pwd`"
        success "Update oh-my-zsh successfully"
	else
		msg "${OH_MY_ZSH} not exists. Install..."
		#git clone git@github.com:robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
		#wget --no-check-certificate http://install.ohmyz.sh -O - | sh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &>/dev/null || "Install oh-my-zsh failed"
        success "Install oh-my-zsh successfully"
		#git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
	fi
}

# Vim install `Vundle` and plugins
install_vundle(){
	if [ -d "${VUNDLE}" ]; then
		cd "${VUNDLE}"
		echo "Change directory to `pwd`"
		echo "${VUNDLE} exists. Git pull to update..."
        git checkout master &>/dev/null
		git pull &>/dev/null
		cd - > /dev/null 2>&1
		echo "Change directory back to `pwd`"
        success "Update vundle successfully"
	else
		echo "${VUNDLE} not exists. Git clone to create..."
		git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLE} &>/dev/null
		vim +PluginInstall +qall
        success "Install vundle successfully"
	fi
}

# Tmux install `TPM`
install_tpm(){
	if [ -d "${TMUXPLUGINMANAGER}" ]; then
		cd "${TMUXPLUGINMANAGER}"
		msg "Change directory to `pwd`"
		msg "${TMUXPLUGINMANAGER} exists. Git pull to update..."
		git pull &>/dev/null
		cd - > /dev/null 2>&1
		msg "Change directory back to `pwd`"
        success "Update tmux plugin tpm successfully"
	else
		msg "${TMUXPLUGINMANAGER} not exists. Git clone to create..."
		git clone https://github.com/tmux-plugins/tpm ${TMUXPLUGINMANAGER} &>/dev/null
        success "Install tmux plugin tpm successfully"
	fi
}

main() {
    program_must_exist "python"
    program_must_exist "vim"
    program_must_exist "git"
    create_symlinks
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_brew
        install_with_brew
    fi
    install_pip
    install_oh_my_zsh
    install_vundle
    install_tpm
}

main
