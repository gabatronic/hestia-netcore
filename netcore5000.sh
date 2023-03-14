#!/bin/bash
user=$1
domain=$2
ip=$3
home=$4
docroot=$5
prvdot=$(ps -f -u $user | grep dorun | cut -c 12-17)
mkdir "$home/$user/web/$domain/netcoreapp"
chown -R $user:$user "$home/$user/web/$domain/netcoreapp"
kill -9 $prvdot
#runuser -l $user -c "nohup /usr/bin/dorun $home $user $domain &" > /dev/null
