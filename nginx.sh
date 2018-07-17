#!/bin/bash

title "nginx";
do_you_want_continue;
if [ $do_you_want_continue_response = "n" ]
then
    return;
fi
if ! dpkg -s nginx > /dev/null; then
    sudo apt-get install nginx;
    sudo ufw allow 'Nginx HTTP';
    sudo ufw status;
    press_any_key_to_continue;
    sudo sed -i "s/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/g" /etc/nginx/nginx.conf;
    sudo sed -i "s/80 default_server/80/g" /etc/nginx/sites-available/default;
fi

sudo systemctl restart nginx;
sudo systemctl status nginx;
press_any_key_to_continue;

echo "create server block?[Y/n]";
read -r input;
if [ $input = "y" ]
then
    source server-block-for-nginx.sh;
else
    echo -e "${BGreen}Done!${NC}";
    press_any_key_to_continue;
fi;