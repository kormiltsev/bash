#!/bin/bash

echo 'ubuntu app upload begins'

#apt update && apt upgrade

apps=(curl wget openssh snap mc tldr tmux fzf bat feh neofetch rsync w3m tty-clock nano micro gdu cmatrix)

function defer() {
	tldr -u
    rc-update add sshd && service sshd start
    cmatrix -b -C blue
}

file='./updateResults'
> $file #make it empty

function checkAndInstall(){
	echo $1 >> $file

	var=$(command -v $1)
	address="/usr/bin/"$1
	if [[ "$var" == "$address" ]]; then
	#if [[ "$var" == "/usr/bin/nano" ]]; then
		echo $var >> $file
	else
		if [[ -z $var ]]; then
			apt-get install $1 -y> /dev/null

			if [ $? -ne 0 ]; then
				str='ERROR install '$1
				echo $str >> $file
			else
				command -v $1 >> $file
			fi
		else
			str='ERROR command already exists: '$var
			echo $str >> $file
		fi
	fi
}

for i in "${apps[@]}"
do
	checkAndInstall $i
done


defer
cat ./updateResults
rm ./updateResults
