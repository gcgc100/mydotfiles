# Usage
Clone prject:
git clone https://github.com/gcgc100/mydotfiles.git --recursive
or
git clone https://github.com/gcgc100/mydotfiles.git
git submodule init
git submodule update

Install:
bash install.sh

# My Configuration Files and Software list

* .vim .vimrc: vim configuration files and plugins
* .bashrc: bash 
* .zshrc: zsh 
* .gitig: git 
* .tmux.: tmux 
* .screenrc: screen 
* .lynxrc: lynx

## Software list:
* [xterm2](https://www.iterm2.com/): New terminal on OS X.
* [tmux](https://github.com/tmux/tmux): tmux:terminal multiplexer.
* [autojump](https://github.com/wting/autojump): Quick navigatio on terminal. Replace 'cd'.
* [brew](https://brew.sh/): Install software on macOS.
* [lynx](http://lynx.browser.org): A text browser for the World Wide Web.
* [screen](https://www.gnu.org/software/screen/)(Using tmux now): Split screen in terminal. conf file:.screenrc [Another option: tmux](http://tmux.github.io/)).
* [tree](http://www.computerhope.com/unix/tree.htm): List the contents of directories in a tree like format.


## tmux plugin install
apt-get install xsel on Linux or brew install reattach-to-user-clipboard on OS-X
Inside tmux press **C-prefix I** to install plugins

Dependencies: xclip, xsel

# Features:
* Automatically check update on github. Run git command in .zshrc to pull latest update.

#TODO
* Use git submodule to manage vim plugins. So the vim plugins will not in master branch when init. Not sure whether vundle can handle this scenario.
