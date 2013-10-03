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
