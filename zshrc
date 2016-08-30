# == source-dependency ==
source ~/dotfiles/zsh/history.zsh
source ~/dotfiles/zsh/variables.zsh
source ~/dotfiles/zsh/aliases.zsh
source ~/dotfiles/zsh/functions.zsh
source ~/dotfiles/zsh/prompt.zsh
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh-history-substring-search/zsh-history-substring-search.zsh

# == ssh-keys ==
ssh-add ~/Dropbox/private/ssh/id_rsa 2> /dev/null
ssh-add ~/Dropbox/private/ssh/id_rsa_monterail 2> /dev/null

export TERM="xterm-256color"

# == PATH ==
export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH=/usr/local/sbin:$PATH
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.node/bin:$PATH"

fpath=(/usr/local/share/zsh-completions $fpath)

eval "$(rbenv init -)"

bindkey -e

export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
