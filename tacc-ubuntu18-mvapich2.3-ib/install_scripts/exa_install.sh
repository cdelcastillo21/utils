#!/bin/bash
# Installation script for exa on ubuntu images < 19.0 (greater than use apt-get)

mkdir exa && cd exa && \
	wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip && \
	unzip exa-linux-x86_64-v0.10.0.zip
cp bin/exa /usr/local/bin
cp man/exa.1  /usr/share/man/man1/
DIR1=/etc/bash_completion.d
DIR2=/usr/share/bash-completion/completions
DIR3=/usr/share/fish/vendor_completions.d
if [ -d "$DIR1" ]; then
  cp completions/exa.bash /etc/bash_completion.d/
  echo "$DIRECTORY does exist."
fi
if [ -d "$DIR2" ]; then
  cp completions/exa.bash /usr/share/bash-completion/completions/
fi
if [ -d "$DIR3" ]; then
  echo "here"
  cp completions/exa.fish /usr/share/fish/vendor_completions.d/
fi
cd .. && rm -rf exa

