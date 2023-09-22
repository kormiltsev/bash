#!/bin/bash

bashAliases=~/.bash_aliases
newAliases=./new_aliases

#file with new aliases can be sat as Arg(1)
if [[ ! -z $1 ]];then
	newAliases=$1
fi

#check file with new aliases exists
if [[ ! -e $newAliases ]]; then
	echo 'no such file with aliases: ' $newAliases
	exit 1
fi

#check bash_aliases exist or create it
if [[ ! -e $bashAliases ]]; then
    #mkdir -p /Scripts
    touch $bashAliases
fi

#read aliases already presetted in bash_aliases
presetArray=()

#read line by line
while IFS= read -r line
do
c=${line%% *}

if [ ! -z $c ]; then 

	#if line begins from 'alias' save name of alias in array
	if [ $c == 'alias' ]; then
		b=${line%%=*}
  		presetArray+="${b:6}"
	fi
fi
done < "$bashAliases"

#read file with new aliases
while IFS= read -r line
do
c=${line%% *}

if [ ! -z $c ]; then 
	#if line starts from 'alias'...
	if [ $c == 'alias' ]; then
		b=${line%%=*}
		c=${b:6}

		#if name of alias exists...
		if [ ! -z c ]; then

			#if alias is already in array skip it
			#add new alias to file
			if [[ ! "${presetArray[*]}" =~ "$c" ]]; then
				echo $line >> $bashAliases				
			else
				echo "alias exists:"
				echo $(cat $bashAliases | grep $c)
				echo $line
				echo "============"
			fi
		fi
	fi
fi
done < "$newAliases"
