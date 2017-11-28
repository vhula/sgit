#!/bin/bash

CONFIG_COMMAND="git config"
GLOBAL_CONFIG="--global"
CONFIGURE_ALIASES="yes"

function tool_help() {
    echo "configure command usage: sgit configure [ARGUMENT VALUE]... [OPTION]"
    echo ""
    echo "Arguments:"
    echo -e "\t-u, --username\t\t\tname of the user for git env"
    echo -e "\t-e, --email\t\t\temail of the user for git env"
    echo -e "\t--editor\t\t\tgit editor"
    echo "Options:"
    echo -e "\t--global-off\t\t\tapply configuration for the current user only"
    echo -e "\t--alias-off\t\t\tdo not configure git aliases"
}

function tool_args() {
    local RETURN_VALUE=0
    case "${1}" in
      configure)
      SHIFT_TIMES=1
      ;;
      -u|--username)
      SHIFT_TIMES=2
      USERNAME_ARG="${2}"
      ;;
      -e|--email)
      SHIFT_TIMES=2
      EMAIL_ARG="${2}"
      ;;
      --editor)
      SHIFT_TIMES=2
      EDITOR_ARG="${2}"
      ;;
      --global-off)
      SHIFT_TIMES=1
      GLOBAL_CONFIG=""
      ;;
      --alias-off)
      SHIFT_TIMES=1
      CONFIGURE_ALIASES="no"
      ;;
      *)
      RETURN_VALUE=1
      ;;
    esac
    return ${RETURN_VALUE}
}

function configure_if_not_empty() {
    CONFIG_NAME="${1}"
    CONFIG_VALUE="${2}"
    if [ ! -z "${CONFIG_VALUE}" ]; then
      CMD="${CONFIG_COMMAND} ${GLOBAL_CONFIG} ${CONFIG_NAME} \"${CONFIG_VALUE}\""
      eval "${CMD}"
      log_info "\t'${CONFIG_NAME}' is set to \"${CONFIG_VALUE}\""
    fi
}

function tool_execute() {
    configure_if_not_empty "user.name" "${USERNAME_ARG}"
    configure_if_not_empty "user.email" "${EMAIL_ARG}"
    configure_if_not_empty "core.editor" "${EDITOR_ARG}"
    
    if [ "${CONFIGURE_ALIASES}" = "yes" ]; then
      log_info "aliases configuration..."
      while read -r line || [[ -n "$line" ]]; do
        echo "${line}" | grep --silent --regexp "^\s*$"
        if [ ! "$?" -eq 0 ]; then
          name=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\2/")
          value=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\3/")
          configure_if_not_empty "alias.${name}" "${value}"
        fi
      done < "${SCRIPTPATH}/config/aliases.properties"
    fi
}
