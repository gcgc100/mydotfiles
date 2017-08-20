#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import argparse
import shutil


def create_symlinks(force=False):
    """Create symlinks for dotfiles """
    dotfiles = [".bashrc", ".gitconfig", ".screenrc", ".tmux.conf", ".vimrc"]
    home = os.path.expanduser("~")
    workDir = os.getcwd()
    os.chdir(home)
    backupDir = "confFilesbackup"
    if force and os.path.isdir(backupDir):
        shutil.rmtree(backupDir)
    if not os.path.isdir(backupDir):
        os.mkdir(backupDir)
    elif not force:
        print "backup dir not available"
        sys.exit()
    for df in dotfiles:
        if os.path.isfile(df):
            shutil.move(df, os.path.join(backupDir, df))
        os.symlink(os.path.join(workDir, df), df)

    dotDirs = [".vim"]
    for dd in dotDirs:
        if os.path.isdir(dd):
            shutil.move(dd, os.path.join(backupDir, dd))
        os.symlink(os.path.join(workDir, dd), dd)

    os.chdir(workDir)


def installVundle():
    """Install vundle for vim """
    pass


def main():
    parser = argparse.ArgumentParser("Install my dotfiles, config my linux os")
    parser.add_argument("-f", "--force", action="store_true", default=False,
                        help="Force replace dotfiles")

    try:
        args = parser.parse_args()
    except Exception as e:
        print e
        sys.exit()
    create_symlinks(args.force)


if __name__ == "__main__":
    main()
