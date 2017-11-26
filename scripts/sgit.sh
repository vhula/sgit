#!/bin/bash

function help() {
    echo "Usage: sgit [ARGUMENT VALUE]... [OPTION]..."
    echo "Sets up different aliases for git command"
    echo "All options are applied globaly by default (git config --global)"
    echo ""
    echo "Arguments:"
    echo -e "\t-u, --username\t\t\tname of the user for git env"
    echo -e "\t-e, --email\t\t\temail of the user for git env"
    echo -e "\t--editor\t\t\tgit editor"
    echo "Options"
    echo -e "\t-h, --help\t\t\tprint usage"
    echo -e "\t-c, --configure\t\t\tconfigure default aliases"
    echo -e "\t--global-off\t\t\tapply configuration for the current user only"
}

function aliases_list() {
  echo ""
  echo "Supported aliases list:"
  echo ""
  while read -r line || [[ -n "$line" ]]; do
    echo "${line}" | grep --silent --regexp "^\s*$"
    if [ ! "$?" -eq 0 ]; then
      echo -e "\t${line}"
    fi
  done < "${SCRIPTPATH}/config/aliases.properties"
  echo ""
}

if [ $# -eq 0 ]; then
  echo "no arguments are specified"
  echo ""
  help
  exit 1
fi

CONFIG_COMMAND="git config"
GLOBAL_CONFIG="--global"

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

function configure_if_not_empty() {
    CONFIG_NAME="${1}"
    CONFIG_VALUE="${2}"
    if [ ! -z "${CONFIG_VALUE}" ]; then
      CMD="${CONFIG_COMMAND} ${GLOBAL_CONFIG} ${CONFIG_NAME} \"${CONFIG_VALUE}\""
      eval "${CMD}"
      echo -e "\t'${CONFIG_NAME}' is set to \"${CONFIG_VALUE}\""
    fi
}

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -h|--help)
    help
    exit 0
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
    ;;
    --global-off)
    GLOBAL_CONFIG=""
    shift
    ;;
    --aliases-list)
    aliases_list
    exit 0
    ;;
    *)
    echo "unknown option or argument: ${1}"
    echo ""
    help
    exit 1
    ;;
esac
done
echo "configuration..."
configure_if_not_empty "user.name" "${CONFIG_USERNAME}"
configure_if_not_empty "user.email" "${CONFIG_EMAIL}"
configure_if_not_empty "core.editor" "${CORE_EDITOR}"

if [ "${CONFIGURE_ALIASES}" = "yes" ]; then
  echo ""
  echo "aliases configuration..."
  while read -r line || [[ -n "$line" ]]; do
    echo "${line}" | grep --silent --regexp "^\s*$"
    if [ ! "$?" -eq 0 ]; then
      name=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\2/")
      value=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\3/")
      configure_if_not_empty "alias.${name}" "${value}"
    fi
  done < "${SCRIPTPATH}/config/aliases.properties"
fi
