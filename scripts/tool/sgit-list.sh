#!/bin/bash

function tool_help() {
    echo "list command usage: sgit list [ARGUMENT VALUE]... [OPTION]"
    echo ""
    echo -e "Options:"
    echo -e "\t--commands\t\t\tlist all available shortcuts CLI tools"
    echo -e "\t--aliases\t\t\tlist all pre-defined aliases for git"
}

SGIT_LIST_ARGS_PRESENT="no"

function tool_args() {
    local RETURN_VALUE=0
    case "${1}" in
      list)
      SHIFT_TIMES=1
      ;;
      --commands)
      SHIFT_TIMES=1
      _TOOLS_LIST="yes"
      _SGIT_LIST_ARGS_PRESENT="yes"
      ;;
      --aliases)
      SHIFT_TIMES=1
      _ALIASES_LIST="yes"
      _SGIT_LIST_ARGS_PRESENT="yes"
      ;;
      *)
      RETURN_VALUE=1
      ;;
    esac
    return ${RETURN_VALUE}
}

function tool_execute() {
  
    if [ "${SGIT_LIST_ARGS_PRESENT}" == "no" ]; then
      log_warn "specify at least one list to print"
      tool_help
    fi
    
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
