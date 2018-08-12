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
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

export PYTHONPATH=$PYTHONPATH:/usr/bin/

export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

fpath=(/usr/local/share/zsh-completions $fpath)

eval "$(rbenv init -)"

bindkey -e

# export NVM_DIR="$HOME/.nvm"
# . "$(brew --prefix nvm)/nvm.sh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export ERL_AFLAGS="-kernel shell_history enabled"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hodak/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/hodak/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hodak/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/hodak/google-cloud-sdk/completion.zsh.inc'; fi
