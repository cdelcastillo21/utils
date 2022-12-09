curl -sL https://git.io/fisher | source
fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5
fisher install jethrokuan/z
fisher install jorgebucaran/nvm.fish

nvm install 17.0.0 --latest-npm
npm install --global figlet-cli
npm install --global cowsay
node -v > $HOME/.nvmrc
