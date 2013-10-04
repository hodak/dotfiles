#/bin/bash
echo "boxen setup ..."
sudo mkdir -p /opt/boxen
sudo chown ${USER}:staff /opt/boxen
git clone https://github.com/chytreg/our-boxen.git /opt/boxen/repo
cd /opt/boxen/repo
script/boxen --debug
