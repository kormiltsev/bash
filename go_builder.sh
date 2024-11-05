#!/bin/bash

arg1=$1

# -h to print help page
helppage () {
    echo "go build for all sets: amd64-linux, arm64-linux, 386-linux, arm64-windows, amd64-windows, arm64-darwin, amd64-darwin"
    echo "Usage: $(basename "$0") {newAppName} {mainFileToCompile}"
    echo "                                      "
    echo "  {newAppName} {mainFileToCompile}    creates from mainFileToCompile:"
    echo "                                      bin/newAppName-amd64-linux"
    echo "                                      bin/newAppName-arm64-linux"
    echo "                                      bin/newAppName-386-linux"
    echo "                                      bin/newAppName-arm64.exe"
    echo "                                      bin/newAppName-amd64.exe"
    echo "                                      bin/newAppName-arm64-darwin"
    echo "                                      bin/newAppName-amd64-darwin"
    echo "                                      "
    echo "  --empty--                           appname will be equal to the directory name and source will be ./main.go"
    echo "                                      "
    echo "  -h                                  prints this"
}

if [ "$arg1" == '-h' ] || [ "$arg1" == 'h' ] || [ "$arg1" == 'help' ] || [ "$arg1" == '--help' ] || [ "$arg1" == 'man' ]; then
    helppage
    exit 0
fi

appname=${PWD##*/}
soursename=${PWD}/main.go

appname=${PWD##*/}

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "using default. Appname = $appname, sourse file is $soursename"
    mkdir -p bin
else 
    appname=$1
    soursename=$2
fi

GOOS=linux GOARCH=amd64 go build -o bin/$appname-amd64-linux $soursename 
GOOS=linux GOARCH=arm64 go build -o bin/$appname-arm64-linux $soursename
GOOS=linux GOARCH=386 go build -o bin/$appname-386-linux $soursename
GOOS=windows GOARCH=arm64 go build -o bin/$appname-arm64.exe $soursename
GOOS=windows GOARCH=amd64 go build -o bin/$appname-amd64.exe $soursename
GOOS=darwin GOARCH=arm64 go build -o bin/$appname-arm64-darwin $soursename
GOOS=darwin GOARCH=amd64 go build -o bin/$appname-amd64-darwin $soursename

echo "binaries are here: bin/$appname*"