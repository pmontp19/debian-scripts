#!/bin/bash
usage=”Usage: ocupacio.sh \#midaM”
if [ $# -ne 1 ]; then
  echo $usage; exit 1
fi


for user in `cut -d: -f1 /etc/passwd`; do
    home=`cat /etc/passwd | grep "^$user\>" | cut -d: -f6`
    if [ -d $home ]; then
        num_fich=`find $home -type f -user $user | wc -l`
    else
        num_fich=0
    fi

    if [ $num_fich -eq 0 ] ; then
        if [ $p -eq 1 ]; then
		user_proc=”ps -u $user -U $user --no-headers | wc -l”
            if [ $user_proc -eq 0 ]; then
                echo "$user"
            fi
        else
            echo "$user"
        fi
    fi
done
