#/bin/bash

echo "+ submodules"
cd ~/dotfiles; git pull origin master; git submodule update --init

echo "+ zsh"
rm -rf ~/.zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc

echo "+ ruby"
rm -rf ~/.gemrc ~/.irbrc ~/.powconfig
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/irbrc ~/.irbrc
ln -sf ~/dotfiles/powconfig ~/.powconfig

echo "+ tmux"
rm -rf ~/.tmux.conf
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf

echo "+ git"
rm -rf ~/.gitconfig ~/.gitignore-global
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore-global ~/.gitignore-global
# printf "Github token: "
# read token
# sed -i -e "s/GITHUB_TOKEN/$token/g" ~/.gitconfig

# from yoursachet.com
echo "+ vim"
rm -rf ~/.vim ~/.vimrc
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim ~/.vim

echo "+ ssh"
rm -rf ~/.ssh
ln -sf ~/dotfiles/ssh ~/.ssh
# fix ssh-keys permission
chmod 600 ~/Dropbox/private/ssh-keys/*

echo "+ sublime settings from dropbox"
sublime_support_dir=~/Library/Application\ Support/Sublime\ Text\ 2
rm -rf "${sublime_support_dir}/Installed Packages" "${sublime_support_dir}/Pristine Packages" "${sublime_support_dir}/Packages"
ln -sf "~/Dropbox/private/Sublime Text 2/Installed Packages" "${sublime_support_dir}/"
ln -sf "~/Dropbox/private/Sublime Text 2/Pristine Packages" "${sublime_support_dir}/"
ln -sf "~/Dropbox/private/Sublime Text 2/Packages" "${sublime_support_dir}/"
