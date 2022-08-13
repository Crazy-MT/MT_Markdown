#!/bin/sh
if [[ $1 = "--help" ]] || [[ $1 = "-h" ]]
then
    echo "you can use this shell like this:\n\t"
    # echo "\033[33m yggdrasill <create> (service | page):<name> [on <targetDirName>] \033[0m\n"
    echo "\033[33m yggdrasill <create> page:<name> [on <targetDirName>] \033[0m\n"
    exit 0
fi
mypath=$(dirname "$0")
cd $mypath
dart ./page_gen/main.dart $*
cd -