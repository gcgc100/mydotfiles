My vim files.

```diff
- Moved to root directory because install.sh can not handle it if vim files are in another seperate folder.
- TODO: improve install.sh
```

The plugin files are not included in the repository.
Install Vundle: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
And update the Plugins in vim with  :PluginInstall

Dependency: ctags.----Install OS X: brew install ctags,  Ubuntu: sudo apt-get install exuberant-ctags

Languagetool Plugin need Languagetool support. Add the jar file path to vimrc
