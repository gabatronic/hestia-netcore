#!/bin/bash
user=$1
domain=$2
ip=$3
home=$4
docroot=$5
prvdot=$(ps -fu $user | grep "$domain" | cut -c 12-17)
echo $prvdot
mkdir "$home/$user/web/$domain/netcoreapp"
chown -R $user:$user "$home/$user/web/$domain/netcoreapp"
rm $home/$user/web/$domain/netcoreapp/app.sock
kill -9 $prvdot
runuser -l $user -c "cd $home/$user/web/$domain/netcoreapp && nohup /usr/bin/dotnet $home/$user/web/$domain/netcoreapp/app.dll &" > /dev/null
sleep 5
chmod 777 $home/$user/web/$domain/netcoreapp/app.sock
