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

# project chytreg/dotfiles my/dotfiles
# project my/dotfiles

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

