#!/bin/bash
#

PSW=$(cat $HOME/.git_token)
echo "https://cdelcastillo21:$PSW@example.com" > ~/.git-credentials
git config credential.helper store
cd $HOME
mkdir -p repos
git clone https://github.com/cdelcastillo21/utils.git
