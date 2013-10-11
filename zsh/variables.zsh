# == PATH ==
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin"

# == boxen ==
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# == rbenv ==
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# == java-opts ==
export JAVA_OPTS="-Xms256m -Xmx512m -Dfile.encoding=UTF-8 -noverify"

# == browser ==
if [[ "$OSTYPE" == darwin* ]]; then export BROWSER='open'; fi

# == language ==
if [[ -z "$LANG" ]]; then export LANG='en_US.UTF-8'; fi

# == editors ==
export EDITOR='subl -w'
export VISUAL='subl -w'
export PAGER='less'

# == java home ==
export JAVA_HOME=$(/usr/libexec/java_home)

# == library path ==
export LD_LIBRARY_PATH=/opt/boxen/homebrew/lib

# == less ==
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'
