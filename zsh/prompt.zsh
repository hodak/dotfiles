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
  PROMPT='${PR_BLUE}⚡ ${PR_BRIGHT_YELLOW}%$PR_PWDLEN<...<%~% ${PR_RESET}$(git_prompt_string) > '
fi
