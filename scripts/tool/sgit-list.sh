#!/bin/bash

function tool_help() {
    echo "list command usage: sgit list [ARGUMENT VALUE]... [OPTION]"
    echo ""
    echo -e "Options:"
    echo -e "\t--tools\t\t\t\tlist all available shortcuts CLI tools"
    echo -e "\t--aliases\t\t\tlist all pre-defined aliases for git"
}

function tool_args() {
    local RETURN_VALUE=0
    case "${1}" in
      list)
      SHIFT_TIMES=1
      ;;
      --tools)
      SHIFT_TIMES=1
      _TOOLS_LIST="yes"
      ;;
      --aliases)
      SHIFT_TIMES=1
      _ALIASES_LIST="yes"
      ;;
      *)
      RETURN_VALUE=1
      ;;
    esac
    return ${RETURN_VALUE}
}

function tool_execute() {
    if [ "${_ALIASES_LIST}" == "yes" ]; then
      log_msg "Aliases..."
      log_msg "----------"
      while read -r line || [[ -n "$line" ]]; do
        echo "${line}" | grep --silent --regexp "^\s*$"
        if [ ! "$?" -eq 0 ]; then
          log_msg "${line}"
        fi
      done < "${SCRIPTPATH}/config/aliases.properties"
      log_msg ""
    fi
    
    if [ "${_TOOLS_LIST}" == "yes" ]; then
      log_msg "Commands..."
      log_msg "-----------"
      while read -r line || [[ -n "$line" ]]; do
        echo "${line}" | grep --silent --regexp "^\s*$"
        if [ ! "$?" -eq 0 ]; then
          name=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\2/")
          log_msg "${name}"
        fi
      done < "${SCRIPTPATH}/config/commands.properties"
      log_msg ""
      log_msg "Execute 'sgit <command> --help' for details"
    fi
}
