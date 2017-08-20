#!/bin/sh

dotfiles = (".bashrc", ".gitconfig", ".screenrc")
for dotfile in "${dotfiles[@]}"
do
	echo "Delete symlink ${HOME}/${dotfile}"
	rm -f ${HOME}/${dotfile}
done
