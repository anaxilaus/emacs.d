#!/usr/bin/env bash

cd $(dirname $0)
if [[ ! -f $HOME/.emacs.d && ! -d $HOME/.emacs.d ]]; then
    echo "Copying files"
    cp -r $(dirname $0) $HOME/.emacs.d
else
    echo "Skipping copying (there's already a file or directory exists at $HOME/.emacs.d)"
fi

if [ -f $HOME/.emacs.d/install_libraries.el ]; then
    emacs -nw --load $HOME/.emacs.d/install_libraries.el
else
    echo "No suitable .el file found to install libraries"
fi

# install golang binaries
if [[ "$(which go)" != "" ]]; then # check path
    go get golang.org/x/tools/cmd/...
    go get github.com/rogpeppe/godef
    go get -u github.com/nsf/gocode # go-autocomplete binaries
else
    echo "Golang binary doesn't found in path"
fi


# use pandoc for markdown conversion
if [[ ! $(which pandoc) ]]; then
    if [[ ! $OS_TYPE == "darwin"* ]] || [[ ! $(which brew) ]]
                    || [[ ! $(brew install pandoc) ]]; then
        RED="\033[0;31m"
        echo "${RED}pandoc not installed, install pandoc for markdown support."
    fi
fi

echo "Done"
