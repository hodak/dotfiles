# == aliases ==
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

alias gs="g st"
alias gr="g r"
alias g="git"
alias be="bundle exec"
alias rc="be rails c"
alias rt='echo "restarting"; touch tmp/restart.txt; spring stop'
alias grep="grep --color"
alias vi="vim" # lame, i know
alias c="clear"
alias rspec="clear; bundle exec rspec --color --format documentation"
alias bsp="./bin/rspec"
alias st="sky run tail -f log/staging.log"
alias dt="tail -F -n 0 log/development.log"

