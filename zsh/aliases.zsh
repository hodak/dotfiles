# == aliases ==
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

alias ghostscript="/usr/local/bin/gs"
alias gs="g st"
alias gr="g r"
alias g="git"
alias gd="g di"
alias gdc="gd --cached"
alias gdf="g df"
alias be="bundle exec"
alias rc="be rails c"
alias rt='echo "restarting"; touch tmp/restart.txt; spring stop'
alias grep="grep --color"
alias vi="vim" # lame, i know
alias vvim="vim -u NONE" # vanilla vim
alias c="clear"
alias rspec="clear; bundle exec rspec --color --format documentation"
alias bsp="./bin/rspec"
alias st="sky run tail -f log/staging.log"
alias dt="tail -F -n 0 log/development.log"

alias notes="cd ~/notes; vim"

# Phoenix
alias pserver="iex -S mix phx.server"
alias simpleserver="open http://localhost:8000; python -m SimpleHTTPServer"

alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed'

alias priex="iex --sname pry"

alias tree="tree -I 'node_modules'"

alias dokku='bash $HOME/.dokku/contrib/dokku_client.sh --rm'
