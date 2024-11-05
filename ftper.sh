#!/bin/bash
# alternative as one liner:
# alias ftper='mkdir -p $HOME/ftp/ftpdir && echo "test file for ftp" > $HOME/ftp/ftpdir/testfileforftper && docker run --rm -d -p 2121-2130:2121-2130 -v $HOME/ftp/ftpdir:/tmp -v $HOME/ftp:/app --name ftper fclairamb/ftpserver && echo "username: test, password: test, address://$(hostname -I | awk 'NR > 0 {print $1}'):2121/ (from ifconfig)" && echo "docker stop ftper - to stop container" && echo "ftper directory: $HOME/ftp/ftpdir"'

sharedir="$HOME/ftp/ftpdir"
command=$1

# -h to print help page
helppage () {
    echo "Usage: $(basename "$0") ( {directory} )"
    echo "  --empty--       using default derectory $sharedir (will be created"
    echo "                  as well as file $sharedir/testfileforftper.txt)."
    echo "                  used for testing purposes."
    echo "                  "
    echo "  {directory}     shares this directory using FTP."
    echo "                  "
    echo "  -h              prints this"
}
if [ "$command" == '-h' ] || [ "$command" == 'h' ] || [ "$command" == 'help' ] || [ "$command" == '--help' ] || [ "$command" == 'man' ]; then
    helppage
    exit 0
fi

# check if docker is installed on linux
if [ -x "$(command -v docker)" ]; then
    echo "starting ftp in container..."
else
    echo "Docker not found. Aborted."
    exit 1
fi

# if parameter (directory) set?
if [ -z "$1" ]; then
    echo "parameter not found. Expected: # ftper /my/directory/to/share"
    echo "continue with ftper directory to be created: $sharedir"
    mkdir -p $sharedir
    echo "test file for ftp" > $sharedir/testfileforftper.txt 
else 
    sharedir=$1
fi

# starting ftp container
docker run --rm -d -p 2121-2130:2121-2130 -v $sharedir:/tmp -v $HOME:/app --name ftper fclairamb/ftpserver 

# check exit code
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Failed by Docker"
   exit $retVal
fi

# get local IP
IP=$(hostname -I | awk 'NR > 0 {print $1}')

# print results
echo "ftper directory: $sharedir"
echo "username: test"
echo "password: test"
echo "address://$IP:2121/"
echo "config file created here: $HOME/ftpserver.json"
echo "To stop container: # docker stop ftper" 
