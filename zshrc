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

function ip {
  echo "Airport:  $(ifconfig en1 | grep netmask | awk '{print $2}')"
  echo "Ethernet: $(ifconfig en0 | grep netmask | awk '{print $2}')"
}

function new-scratch {
  date=$(date +'%Y-%m-%d-%H%M%S')
  cur_dir="$HOME/scratch"
  new_dir="$HOME/tmp/scratch-$date"
  mkdir -p "$new_dir"
  ln -nfs "$new_dir" "$cur_dir"
  cd $cur_dir
  echo "New scratch dir ready for grinding ;>"
}

function fm {
  if [ -f Procfile.dev ];
  then
    foreman start -f Procfile.dev
  else
    foreman start
  fi
}
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin"
# == boxen ==
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
# == rbenv ==
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export JAVA_OPTS="-Xms256m -Xmx512m -Dfile.encoding=UTF-8 -noverify"

# == aliases ==
alias s="subl ."
alias ls="ls -GF"
alias l="ls -GFalh"
alias dt="tail -F -n 0 log/development.log"
alias rt="touch tmp/restart.txt"
alias grep="grep --color"
alias jsonp="ruby -r json -e 'puts JSON.pretty_generate(JSON.parse(readlines.join))'"
alias g="git"

# == browser ==
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# == editors ==
export EDITOR='subl'
export VISUAL='subl'
export PAGER='less'

# == language ==
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# == less ==
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# == prompt ==
setopt prompt_subst
autoload -U colors zsh/terminfo compinit promptinit
colors
compinit -i
promptinit

for COLOR in RED GREEN YELLOW WHITE BLACK GREY CYAN BLUE MAGENTA; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

PR_RESET="%{$reset_color%}"


local TERMWIDTH
(( TERMWIDTH = ${COLUMNS} - 1 ))

local PROMPTSIZE=${#${(%):--- %D{%R.%S %a %b %d %Y}\! ---}}
local PWDSIZE=${#${(%):-%~}}

if [[ "$PROMPTSIZE + $PWDSIZE" -gt $TERMWIDTH ]]; then
 (( PR_PWDLEN = $TERMWIDTH - $PROMPTSIZE ))
fi

parse_git_branch() {
  (test -d .git) && (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

parse_git_state() {
  local COLOR=$PR_GREEN

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    COLOR=$PR_YELLOW
  elif ! git diff --quiet 2> /dev/null; then
    COLOR=$PR_RED
  elif ! git diff --cached --quiet 2> /dev/null; then
    COLOR=$PR_BLUE
  fi

  echo $COLOR
}

git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo " [$(parse_git_state)${git_where#(refs/heads/|tags/)}${PR_RESET}]"
}


# Finally, let's set the prompt
if [ `id -u` -eq "0" ]; then
  PROMPT='[${PR_RED}%n${PR_WHITE}:${PR_YELLOW}%$PR_PWDLEN<...<%~% ${PR_RED}${GITBRANCH}${PR_RESET}] # '
else
  # local DIR=$(pwd)
  # if [ $DIR = ]
  PROMPT='${PR_BLUE}⌘ ${PR_BRIGHT_YELLOW}%$PR_PWDLEN<...<%~% ${PR_RESET}$(git_prompt_string) > '
fi

source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh-history-substring-search/zsh-history-substring-search.zsh

# == ssh-keys ==
ssh-add ~/Dropbox/private/ssh-keys/id_rsa 2> /dev/null
ssh-add ~/Dropbox/private/ssh-keys/id_rsa_monterail 2> /dev/null
