#!/bin/bash
arg1=$1
arg2=$2
arg3=$3

sshConfig=$HOME/.ssh/config
certHost=$HOME/.ssh/id_rsa.pub

# -h to print help page
helppage () {
    echo "Usage: $(basename "$0") {newVmName} {username} {IP} | rm {VmName} | -ls | -la | -h"
    echo "                      "
    echo "  {newVmName} {username} {IP}    	new VM will be added to ssh config file with {newVmName} name. Certificate will be sent to new VM from host."
    echo "                      "
    echo "  rm {VmName}         			{VmName} will be removed from $sshConfig."
    echo "                      "
    echo "  -ls                 			prints list of names of VM registered $HOME/.ssh/config"
    echo "  -la                 			prints $HOME/.ssh/config"
    echo "  -h                  			prints this"
}

if [ "$arg1" == '-h' ] || [ "$arg1" == 'h' ] || [ "$arg1" == 'help' ] || [ "$arg1" == '--help' ] || [ "$arg1" == 'man' ]; then
    helppage
    exit 0
fi

# list of VM registered
if [ "$arg1" == 'ls' ] || [ "$arg1" == '-ls' ]|| [ "$arg1" == '-l' ]|| [ "$arg1" == 'l' ]; then
    grep "^Host " ~/.ssh/config | awk '{print $2}'
    exit 0
fi

# list of VM registered, full file
if [ "$arg1" == 'la' ] || [ "$arg1" == '-la' ] ; then
    cat ~/.ssh/config
    exit 0
fi

# rm to remove VM from ssh/config file
removeVmFromConfig () {
    awk -v vm="$arg2" '
    BEGIN { p = 1 }
    /^Host / { p = ($2 == vm) ? 0 : 1 }
    p' "$sshConfig" > "${sshConfig}.tmp" && mv "${sshConfig}.tmp" "$sshConfig"
}

if [ "$arg1" == 'rm' ] ; then

    if [ -z "$arg2" ]; then
        helppage   
        exit 1
    fi

    if ! grep -q "^Host $arg2" "$sshConfig"; then
        echo "VM $arg2 not found in SSH config:"
        grep "^Host " ~/.ssh/config | awk '{print $2}'
        exit 1
    fi

    if removeVmFromConfig ; then
        echo "removed"
        exit 0
    else 
        echo "modify file $sshConfig to remove VM from ssh config. Aborting."
        exit 1
    fi
fi

# default action is to add new VM
if [ -z "$arg1" ]; then
    helppage
    exit 1
fi

if ! grep -q "Host $arg1" $sshConfig; then
    echo -e "Host $arg1\n    HostName $arg3\n    User $arg2" >> $sshConfig
fi

if cat $certHost | ssh $arg1 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"; then
        echo "Success! $arg1 added, sertificate was sent"
    else 
        echo "$arg1 sertificate was not sent"
fi
