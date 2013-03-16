#!/bin/bash

for dotfile in _*
do
    # make the symlink
    ln -sf ${PWD}/$dotfile $HOME/${dotfile/_/.}
done
