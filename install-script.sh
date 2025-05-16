#!/bin/bash

install_config() {
echo "Copying files...";
cp -rfv ./config/* ~/.config/;
cp -rfv ./local/share/* ~/.local/share/;
cp -rfv .zsh/.zshrc ~/.zshrc;
mkdir -pv ~/.local/share/fonts;
cp -rfv ./usr/share/fonts/* ~/.local/share/fonts/;
sudo cp -rfv ./.moonflowers-folders/* /usr/share/Papirus;
echo "Setting Papirus folder icon colours"
papirus-folders -t Papirus-Dark -c moonflowers
echo "Adding border frame by modifying kdeglobals";
echo "frame=220,35,50
inactiveFrame=35,35,35" | tee -a ~/.config/kdeglobals;
echo "Running omz installation script"
./.zsh/installomz.sh &&
./.zsh/post-install.sh;
echo "Changing default user shell to zsh"
chsh -s /usr/bin/zsh;
echo "All done. Now, head over to the Plasma settings and apply the themed. Then, read the widget instructions and apply the theme there as well. Enjoy!"
}
# Start by backing up the current .config and .local/share directories, if they exist and the user wishes to do so
read -p "Do you want to back up your .config and .local/share files? (might take a minute, recommended) (y/n)? " choice
case "$choice" in
  y|Y|yes ) if [ -d ~/.config ] && [ -d ~/.local/share ]; then
        tar -czvf ~/moonflowers-backup.tar.gz ~/.config ~/.local/share
    elif
        [ -d ~/.config ] || [ -d ~/.local/share ]; then
        tar -czvf ~/moonflowers-backup.tar.gz ~/.config
    elif
        [ -d ~/.local/share ] || [ -d ~/.config ]; then
        tar -czvf ~/moonflowers-backup.tar.gz ~/.local/share
    elif
        [ ! -d ~/.local/share ] && [ ! -d ~/.config ]; then
        echo "No .config or .local/share found"
    else
        echo "Unknown error when backing up, exiting..."
        exit
    fi;
    install_config();;
  n|N|no ) install_config();;
  * ) echo "Please answer y or n";;
esac


