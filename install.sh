#!/bin/bash

for dotfile in _*
do
    source="${PWD}/$dotfile"
    target="$HOME/${dotfile/_/.}"

    if [ -e $target ]
    then
        if [ -L $target ]
        then
            rm -fv $target
        else
            mv -v $target $target.bk
        fi
    fi

    # make the symlink
    ln -sfv $source $target
done
