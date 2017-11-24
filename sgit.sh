#!/bin/bash

function help() {
    echo "Usage: sgit [ARGUMENT VALUE]... [OPTION]..."
    echo "Sets up different aliases for git command"
    
    echo "Arguments:"
    echo -e "\t-u, --username\t\t\tname of the user for git env"
    echo -e "\t-e, --email\t\t\temail of the user for git env"
    echo -e "\t--editor\t\t\tgit editor"
    echo "Options"
    echo -e "\t-h, --help\t\t\tprint usage"
    echo -e "\t-c, --configure\t\t\tconfigure default aliases"
    echo -e "\t--global\t\t\tglobal configuration"
}

CONFIG_COMMAND="git config"
GLOBAL_CONFIG=""

function configure_if_not_empty() {
    CONFIG_NAME="${1}"
    CONFIG_VALUE="${2}"
    if [ ! -z "${CONFIG_VALUE}" ]; then
      eval "${CONFIG_COMMAND} ${GLOBAL_CONFIG} ${CONFIG_NAME} \"${CONFIG_VALUE}\""
    fi
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
    -u|--username)
    CONFIG_USERNAME="$2"
    shift
    shift
    ;;
    -e|--email)
    CONFIG_EMAIL="$2"
    shift
    shift
    ;;
    --editor)
    CORE_EDITOR="$2"
    shift
    shift
    ;;
    -c|--configure)
    CONFIGURE_ALIASES="yes"
    shift
    shift
    ;;
    --global)
    GLOBAL_CONFIG="--global"
    shift
    shift
    ;;
esac
done

configure_if_not_empty "user.name" "${CONFIG_USERNAME}"
configure_if_not_empty "user.email" "${CONFIG_EMAIL}"
configure_if_not_empty "core.editor" "${CORE_EDITOR}"

if [ "${CONFIGURE_ALIASES}" = "yes" ]; then
  echo "Aliases configuration"
fi
