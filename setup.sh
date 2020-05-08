#!/usr/bin/env bash
RED="\033[0;31m"

cd $(dirname $0)
if [[ ! -f $HOME/.emacs.d && ! -d $HOME/.emacs.d ]]; then
    echo "Copying files"
    cp -r $(dirname $0) $HOME/.emacs.d
else
    echo "Skipping copying (there's already a file or directory exists at $HOME/.emacs.d)"
fi

# install python lsp
if [[ "$(which pip3)" != "" ]]; then
    pip3 install 'python-language-server[all]'
else
    echo "${RED}pip3 not found in path"
fi

# install golang lsp
if [[ "$(which go)" != "" ]]; then # check path
   go get -u golang.org/x/tools/gopls
else
    echo "${RED}Golang binary not found in path"
fi

# use pandoc for markdown conversion
if [[ ! $(which pandoc) ]]; then
    if [[ ! $OS_TYPE == "darwin"* ]] || [[ ! $(which brew) ]] \
           || [[ ! $(brew install pandoc) ]]; then
        echo "${RED}pandoc not installed, install for markdown support"
    fi
fi

# initial launch to install packages
emacs -nw --eval "(save-buffers-kill-emacs)"

echo "Done"
