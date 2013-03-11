# .bashrc

export PS1="[\u@\h:\w]$ "

export LANG=en_US

export PATH=$PATH:$HOME/bin:.

if [ `hostname -s` == "palm" ]
then
    ANDROID_SDK_ROOT=/opt/android-sdk-linux
    OS161_ROOT=$HOME/Dropbox/os161

    export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools

    export PATH=$PATH:$OS161_ROOT/tools/bin
fi

if [ `hostname` == "zion" ]
then
    export PATH=$PATH:$HOME/os161/tools/bin
fi

if [ -f $HOME/Dropbox/.alias ]
then
    . $HOME/Dropbox/.alias
fi
