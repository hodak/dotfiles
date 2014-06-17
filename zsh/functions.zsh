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

function remove-backups() {
  ls -d ~/* | grep '.*bak' | xargs -I {} rm -rf {}
}
