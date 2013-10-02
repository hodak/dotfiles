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
printf "Github token: "
read token
sed -i -e "s/GITHUB_TOKEN/$token/g" ~/.gitconfig

# from yoursachet.com
echo "+ vim"
rm -rf ~/.vim ~/.vimrc
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim ~/.vim

echo "+ ssh"
rm -rf ~/.ssh
ln -sf ~/dotfiles/ssh ~/.ssh

echo "+ sublime settings from dropbox"
rm -rf ~/Library/Application\ Support/Sublime\ Text\ 2/Installed\ Packages \
  ~/Library/Application\ Support/Sublime\ Text\ 2/Pristine\ Packages \
  ~/Library/Application\ Support/Sublime\ Text\ 2/Packages
ln -sf ~/Dropbox/private/Sublime\ Text\ 2/* ~/Library/Application\ Support/Sublime\ Text\ 2/
