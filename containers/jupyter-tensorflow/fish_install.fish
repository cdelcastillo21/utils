curl -sL https://git.io/fisher | source
fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5
fisher install jethrokuan/z
fisher install jorgebucaran/nvm.fish

echo "alias mm=\"micromamba\"" >> $HOME/.config/fish/config.fish
echo "mm activate dev" >> $HOME/.config/fish/config.fish
echo "fish_add_path $HOME/go/bin/" >> $HOME/.config/fish/config.fish
echo "fish_add_path $HOME/.cargo/bin/" >> $HOME/.config/fish/config.fish
