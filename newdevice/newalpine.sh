#!/bin/bash

echo 'alpine apk upload begins'

apk update && apk upgrade

apps=(curl wget wc tmux fzf neofetch rsync nano ncdu)

function defer() {
	tldr -u
	cmatrix -b -s -u 8
}

file='./updateResults'
> $file #trancate file

function checkAndInstall(){
	#write name to file	
	echo $1 >> $file

	var=$(command -v $1)
	address="/usr/bin/"$1
	if [[ "$var" == "$address" ]]; then
		echo $var >> $file
	else
		if [[ -z $var ]]; then
			apk add $1 -y #> /dev/null

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
