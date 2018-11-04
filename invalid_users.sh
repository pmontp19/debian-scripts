#!/bin/bash
p=0
t=0
temps=0
usage=”Usage: invalid_user.sh [-p] [-t temps]”

if [ $# -ne 0 ]; then
    if  [ $# -eq 1 ]; then
        if [ $1 == "-p" ]; then
            p=1
        else
            echo $usage; exit 1
        fi
    if [ $# -eq 2 ]; then
      if [ $1 == "-t" ]; then
        t=1
        if [ ${2: -1} -eq "d" ] || [ ${2: -1} -eq "m" ] || [ ${2: -1} -eq "a" ]; then
          unitat = "${2: -1}"
        else
          echo $usage; exit 1
        fi
        temps = $(echo $2 | grep -o -E '[0-9]+')
      fi
    else
        echo $usage; exit 1
    fi
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

		user_proc=`ps -u $user -U $user --no-headers | wc -l`
            if [ $user_proc -eq 0 ]; then
                echo "$user"
            fi
        if [ $t -eq 1 ]; then
          #statements
        fi
        else
            echo "$user"
        fi
    fi
done
