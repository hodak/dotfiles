# this mode sux
# set -o vi

export PATH=/usr/local/bin:$PATH
eval "$(rbenv init -)"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
export PS1="\u\w$ "

# had problem with this one
# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias be="bundle exec"
alias rsi="ssh 156.17.130.39 -l 192192"
alias shtest="clear;./scripts/test.sh"
alias vi="vim" # lame, i know
alias simpleserver="python -m SimpleHTTPServer"
alias gs="g st"
alias gr="g r"
alias rc="be rails c"

alias lampp="sudo /opt/lampp/lampp"
alias migrate="bundle exec rake db:migrate; bundle exec rake db:migrate RAILS_ENV=test"
alias rspec="clear; bundle exec rspec --color"
alias binspec="clear; ./bin/rspec --color"
alias rspec_doc="rspec --format documentation"

rails_log() {
	# if no parameter we assume we're in root of our project
	if [ -z "$1" ]
	then
		logfile="log/development.log"
	else
		logfile=$1
	fi

	tail -f $logfile | grep -v -e ^$ -e 'Started GET'
}

function color_my_prompt {
  local __user_and_host="\[\033[01;32m\]\u@\h"
  local __cur_location="\[\033[01;34m\]\w"
  local __git_branch_color="\[\033[31m\]"
  #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
  local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
  local __prompt_tail="\[\033[35m\]$"
  local __last_color="\[\033[00m\]"
  export PS1="$__user_and_host$__cur_location$__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

export TERM="xterm-256color"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

alias tmux="TERM=screen-256color-bce tmux"
alias full_terminal='xfce4-terminal --fullscreen --hide-menubar --hide-toolbar --hide-borders'
alias tmux_full="full_terminal -e 'tmux -2'"
export EDITOR='vim'

alias g="git"
alias dt="tail -f log/development.log"
alias st="sky run tail -f log/staging.log"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PATH=/usr/local/sbin:$PATH

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PATH=/Users/hodak/Applications/arcanist/arcanist/bin/:$PATH
source /Users/hodak/Applications/arcanist/arcanist/resources/shell/bash-completion


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
