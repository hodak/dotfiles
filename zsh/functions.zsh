function ip {
  echo "Airport:  $(ifconfig en1 | grep netmask | awk '{print $2}')"
  echo "Ethernet: $(ifconfig en0 | grep netmask | awk '{print $2}')"
}

function git-remove-merged {
  (git branch --merged | grep -v "\*" | xargs -n 1 git branch -d) || echo 'Nothing to do'
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

function project {
: ${1?"Usage: project project_dir"}
  mkdir -p ~/src
  project_dir="${@: -1}"
  project_name=$1
  project_path=~/src/$project_dir
  echo $project_path
  if [ ! -d $project_path ]; then
    echo "~ Git clone..."
    git clone "git@github.com:$project_name.git" $project_path
  fi

  if [ -d $project_path ]; then
    cd $project_path
    if [ -d .git ]; then
      echo "~ Git pull.."
      git pull
    fi
    if [ -f Gemfile ]; then
      echo "~ Bundle install..."
      bundle install
    fi
  else
    echo "~ Can't find project: $project_name"
  fi
}

function services() {
  if [ -z $agent ]; then
    echo "Service: $1 not found"
  else
    case "$2" in
    "start")
      launchctl load -w $service_path/$agent
      ;;
    "stop")
      launchctl unload $service_path/$agent
      ;;
    "reload")
      launchctl unload $service_path/$agent
      launchctl load -w $service_path/$agent
      ;;
    *)
      echo "Usage: $0 $1 start|stop|reload"
      ;;
    esac
  fi
}

# agents name start|stop|reload|install

function agents(){
: ${1?"Usage: agents name start|stop|reload|install"}
  service_path=~/Library/LaunchAgents
  if [ $2 = 'install' ]; then
    if (brew --prefix $1 > /dev/null); then
      ln -sfv $(brew --prefix $1)/*.plist $service_path
      chmod 644 $(brew --prefix $1)/*.plist
      agent=$(ls -L $service_path | grep $1 | head -n 1)
      services $1 'start'
    fi
  else
    agent=$(ls -L $service_path | grep $1 | head -n 1)
    services $1 $2
  fi
}

function remove-backups() {
  ls -d ~/* | grep '.*bak' | xargs -I {} rm -rf {}
}

function fix-hipchat() {
  curl -fsSL http://bitly.com/10wDsM7 | bash
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

function gem-info() {
  curl https://rubygems.org/api/v1/gems/$1.json | python -m json.tool
}

# Recruitee

function staging_api_console() {
  kubectl exec -it $(kubectl get pods | grep api- | awk "{print \$1}" | head -n 1) /opt/app/bin/recruitee remote_console
}

function staging_api() {
  kubectl exec -it $(kubectl get pods | grep api- | awk "{print \$1}" | head -n 1) /bin/bash
}

function staging_pg_console() {
  kubectl exec -it $(kubectl get pods | grep payment-gateway- | awk "{print \$1}" | head -n 1) /opt/app/bin/pg remote_console
}

function staging_pg() {
  kubectl exec -it $(kubectl get pods | grep payment-gateway- | awk "{print \$1}" | head -n 1) /bin/bash
}

function staging_legacy() {
  kubectl exec -it $(kubectl get pods | grep legacy-web- | awk "{print \$1}" | head -n 1) /bin/bash
}
