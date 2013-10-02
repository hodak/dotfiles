#/bin/bash
curl -s https://github.com/boxen/puppet-$1/tags | grep tag-name | head -n 1 | grep -o  '\d\.\d\.\d'
