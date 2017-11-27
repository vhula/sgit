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
    echo "TBD"
}
