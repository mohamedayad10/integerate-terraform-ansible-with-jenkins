#!/bin/bash

### This script is for creating 3 users (devo, testo, prodo) & add them to a group named (deployG) ###
group_name=deployG

function add_group() {
    if [[ $group_name = `grep -o $group_name /etc/group | uniq` ]]
    then
        echo "group exists"
        exit 1
    else
        sudo groupadd $group_name
    fi
}

function add_user() {

    for users in Devo Testo Prodo
    do
        pass=$(openssl rand -base64 8)
        if [[ $users = `grep -o $users /etc/passwd | uniq` ]]
        then
            echo "user exists"
            exit 1
        else
            echo "$users : $pass" >> user-password.txt
            sudo useradd -s /bin/bash  -md /home/$users $users
            echo "$pass" | sudo passwd --stdin $users
            echo " user $users is created"
            sudo usermod -aG $group_name $users
            echo "user $users is assigned to group $group_name"
        fi
    done
}


# create deployG group
add_group
# create users
add_user

sudo cat user-password.txt