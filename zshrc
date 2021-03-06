# == source-dependency ==
source ~/dotfiles/zsh/history.zsh
source ~/dotfiles/zsh/variables.zsh
source ~/dotfiles/zsh/aliases.zsh
source ~/dotfiles/zsh/functions.zsh
source ~/dotfiles/zsh/prompt.zsh
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/dotfiles/zsh/recruitee.zsh
source ~/dotfiles/zsh/ubots.zsh

export TERM="xterm-256color"

# == PATH ==
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export PYTHONPATH=$PYTHONPATH:/usr/bin/

fpath=(/usr/local/share/zsh-completions $fpath)

bindkey -e

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export NODE_OPTIONS=--max_old_space_size=8192

# Can't install erlang without it
# https://github.com/asdf-vm/asdf-erlang/issues/157
export CFLAGS="-O2 -g -fno-stack-check -Wno-error=implicit-function-declaration"
. $HOME/.asdf/asdf.sh

export ERL_AFLAGS="-kernel shell_history enabled"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/var/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/var/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/var/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/var/google-cloud-sdk/completion.zsh.inc'; fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
