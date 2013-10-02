echo "+ zsh"
ln -sf ~/dotfiles/zshrc ~/.zshrc

echo "+ ruby"
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/irbrc ~/.irbrc
ln -sf ~/dotfiles/powconfig ~/.powconfig

echo "+ tmux"
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf

echo "+ git"
printf "Github token: "
read token
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore-global ~/.gitignore-global
sed -i -e "s/GITHUB_TOKEN/$token/g" ~/.gitconfig

# from yoursachet.com
echo "+ vim"
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim ~/.vim
