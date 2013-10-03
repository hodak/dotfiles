command_oriented_history=1
HISTCONTROL=ignoreboth

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=8192
export SAVEHIST=8192

setopt share_history
setopt appendhistory
setopt automenu
setopt autopushd
setopt autoresume
setopt complete_in_word
setopt extended_glob
setopt hist_ignoredups
setopt hist_ignorespace
setopt list_types
setopt mailwarning
setopt no_flowcontrol
setopt no_hup
setopt no_notify
setopt printexitvalue
setopt pushd_ignoredups
setopt pushd_silent
