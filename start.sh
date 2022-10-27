#!/bin/bash

set -e

Cyan='\033[0;36m'
Yellow='\033[1;33m'
Red='\033[0;31m'
Green='\033[0;32m'
NC='\033[0;0m'
EOL='\n'
BOLD='\033[1m'
HAIR='\033[0m'

# change volume ownerships
echo "Docker!" | sudo -S /bin/bash -c "chown solr:solr -R /var/solr"

# copy all local core data to solr data directory
printf "${Green}Loading local cores${NC}${EOL}"
cp -R /var/solr/local_data/* /var/solr/data

# change volume ownerships
printf "${Green}Setting volume ownership${NC}${EOL}"
echo "Docker!" | sudo -S /bin/bash -c "chown solr:solr -R /var/solr"
echo "Docker!" | sudo -S /bin/bash -c "mkdir -p /home/solr && chown solr:solr -R /home/solr"

# init script for handling an empty /var/solr
/opt/docker-solr/scripts/init-var-solr
. /opt/docker-solr/scripts/run-initdb
exec solr-fg "$@"