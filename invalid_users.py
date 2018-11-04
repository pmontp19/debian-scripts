#!/bin/python
import getopt, sys
import subprocess
 
usage = 'python3 invalid_users.sh [-p] [-t temps]'

try:
    opts, args = getopt.getopt(sys.argv[1:],"pt:")
except getopt.GetoptError:
    print (usage)
    sys.exit(2)
 
for opt,args in opts:
    if opt == '-p':
        print ("no implantat")
        sys.exit(2)
    elif opt == "-t":
        inactive_users = list()
        if args.strip()[-1] == "d":
            dies = int(args[:-1])
        elif args.strip()[-1] == "m":
            dies = int(args[:-1])*30
        elif args.strip()[-1] == "a":
            dies = int(args[:-1])*365
        dies = str(dies)

        lastlog = subprocess.Popen(['lastlog','-b',dies],stdout=subprocess.PIPE)
        users = subprocess.check_output(['awk','{print $1}'],stdin=lastlog.stdout)
        lastlog.wait()
 
        ps = subprocess.Popen(['ps','haeo','user'],stdout=subprocess.PIPE)
        sort = subprocess.Popen('sort',stdin=ps.stdout,stdout=subprocess.PIPE)
        active_users = subprocess.check_output('uniq',stdin=sort.stdout)
 
        inactive_users = [user for user in users.splitlines() if user not in active_users.splitlines()]
        for user in inactive_users:
            print(user.decode('ascii'))
 
sys.exit(0)
