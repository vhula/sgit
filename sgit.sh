#!/bin/bash

function help() {
    echo "Usage: sgit [ARGUMENT VALUE]... [OPTION]..."
    echo "Sets up different aliases for git command"
    
    echo "Arguments:"
    echo -e "\t-u, --username\t\t\tname of the user for git env"
    echo -e "\t-e, --email\t\t\temail of the user for git env"
    echo "Options"
    echo -e "\t-h, --help\t\t\tprint usage"
}

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -h|--help)
    help
    exit 0
    shift
    shift
    ;;
esac
done


git config --global alias.s 'status'
