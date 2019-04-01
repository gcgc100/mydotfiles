# Usage
Clone prject:
git clone https://github.com/gcgc100/mydotfiles.git
Install:
bash install.sh

If on macOS and using iTerm2: import the profile
iTerm2->Preferences->Profiles->Other Actions...->Bulk Copy from Selected Profile(itermProfile)


# My Configuration Files and Software list

* .vim .vimrc: vim configuration files and plugins
* .bashrc: bash 
* .zshrc: zsh 
* .gitconfig: git 
* .tmux.: tmux 
* .lynxrc: lynx
* .sqliterc: sqlite3
* .screenrc: screen (No more maintenance)
* itermProfile: profile for iterm2. Import it manually.

## Software list:
* With GUI:
    * [xterm2](https://www.iterm2.com/): New terminal on OS X.
    * [mindnote](https://mindnode.com/mindnode/mac): Capture your thoughts.
    * [notibality](http://gingerlabs.com/): Note taking.
    * [alfred](https://www.alfredapp.com/): Quick access anything on Mac.
    * [typora](https://www.typora.io/): A lightweight markdown editor and previewer.
    * [skim](https://skim-app.sourceforge.io/): PDF reader on mac.
    * [Endnote](http://endnote.com/): Paper organize.
    * Chrome
* terminal cmd:
    * [brew](https://brew.sh/): Install software on macOS.
    * [tmux](https://github.com/tmux/tmux): tmux:terminal multiplexer.
    * [autojump](https://github.com/wting/autojump): Quick navigatio on terminal. Replace 'cd'.
    * [tree](http://www.computerhope.com/unix/tree.htm): List the contents of directories in a tree like format.
    * [pandoc](http://www.pandoc.org/): General markup convertor.
    * [lynx](http://lynx.browser.org): A text browser for the World Wide Web.
    * [zsh](http://zsh.sourceforge.net/): Zsh shell.
    * ~~[screen](https://www.gnu.org/software/screen/)(Using tmux now): Split screen in terminal. conf file:.screenrc [Another option: tmux](http://tmux.github.io/)).~~
* Program Language:
    * Python(pip package)
        * nosetests
        * selenium
        * lxml
    * R
        * ggplot
    * Latex
    * NodeJS(npm package)
        * tldr
* Try:
    ~~* [qutebrowser](https://www.qutebrowser.org/index.html): A keyboard-driven, vim-like browse.~~


## tmux plugin install
apt-get install xsel on Linux or brew install reattach-to-user-clipboard on OS-X
Inside tmux press **C-prefix I** to install plugins
Install.sh will install tmux plugin automatically.

Dependencies: xclip, xsel

# Features:
~~* Automatically check update on github. Run git command in .zshrc to pull latest update.~~

# Solved Problems:
Q: How to enable python3 in vim
A: Rebuild the vim. 
    * Mac: brew install vim --with-python3

# TODO
