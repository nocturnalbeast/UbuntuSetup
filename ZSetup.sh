#!/bin/bash

#Helper script to setup the Z Shell and install ZIM framework on top!
#Currently under testing...cause noob ;)

chsh -s /bin/zsh
touch ~/.zshrc
zsh -c 'git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim'
zsh -c 'setopt EXTENDED_GLOB
    for template_file in ${ZDOTDIR:-${HOME}}/.zim/templates/*; do
    user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
    touch ${user_file}
    ( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
    done'
zsh -c 'source ${ZDOTDIR:-${HOME}}/.zlogin'
sed -i 's/zprompt_theme=.*/zprompt_theme='pure'/g' ~/.zimrc