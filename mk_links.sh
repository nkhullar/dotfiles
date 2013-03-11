#!/bin/bash 

for file in `ls -A`
do
    # ignore the scipt itself and .git directory
    test "$file" == `basename $0` && continue
    test "$file" == ".git" && continue

    # remove the original file/symlink 
    test -e $HOME/$file && rm -rfv $HOME/$file
    test -h $HOME/$file && rm -rfv $HOME/$file

    # make the symlink
    cd $HOME; ln -s $HOME/Dropbox/dotfiles/$file; cd -
done
