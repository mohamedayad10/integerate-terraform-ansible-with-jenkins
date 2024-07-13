#!/bin/bash

function not_group_member() {
    users_names=`awk -F : '{print $1}' /etc/passwd`
    for users in $users_names
    do
        groups_names=$(groups $users)
        echo "$groups_names" | grep -i -o deployG > /dev/null
        if [[ $? -eq 0 ]]
        then
            echo "This user $users is in deployG group" > /dev/null
        else
            echo "$users"
        fi
    done
}

not_group_member