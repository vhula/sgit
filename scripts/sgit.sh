#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

source "${SCRIPTPATH}/internal/logs.sh"

if [ $# -eq 0 ]; then
  log_error "no arguments are specified"
  exit 1
fi

ARGS_SIZE=$#

TOOL_NAME="${1}"

function help() {
    echo "Usage: sgit <command> [ARGUMENT VALUE]... [OPTION]..."
    echo ""
    echo "Global options:"
    echo -e "\t-h, --help\t\t\tprint usage"
    echo -e "\t-v, --verbose\t\t\tverbose mode"
    echo -e "\t-q, --quiet\t\t\tonly errors are printed"
    echo -e "\t--silent\t\t\tall messages are disabled"
    echo ""
    echo -e "Available commands:"
    echo -e "\tlist\t\t\t\tprints lists of different objects(tools, git aliases)"
    echo -e "\tconfigure\t\t\tconfigures git aliases, username, email, etc."
    echo -e "\tExecute 'sgit <command> --help' for more information about a command"
}

function source_tool() {
  TOOL_NAME="${1}"
  SOURCED="no"
  while read -r line || [[ -n "$line" ]]; do
    echo "${line}" | grep --silent --regexp "^\s*$"
    if [ ! "$?" -eq 0 ]; then
      name=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\2/")
      value=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\3/")
      if [ "${name}" == "${TOOL_NAME}" ]; then
        source "${SCRIPTPATH}/tool/${value}"
        SOURCED="yes"
        break
      fi
    fi
  done < "${SCRIPTPATH}/config/commands.properties"
  if [ "${SOURCED}" == "yes" ]; then
    return 0
  else
    return 1
  fi
}

source_tool "${TOOL_NAME}"

while [[ $# -gt 0 ]]
do
key="${1}"
case $key in
    -h|--help)
    PRINT_HELP="yes"
    shift
    ;;
    -v|--verbose)
    VERBOSE_MODE="yes"
    shift
    ;;
    -q|--quiet)
    LOG_LEVEL="${LOG_LEVEL_ERR}"
    shift
    ;;
    --silent)
    LOG_LEVEL="${LOG_LEVEL_OFF}"
    shift
    ;;
    *)
    if [ $SOURCED == "yes" ]; then
      tool_args "${1}" "${2}"
      if [ ! $? -eq 0 ]; then
        log_warn "unrecognized option ${1}"
        shift
      else
        while [ "${SHIFT_TIMES}" -gt 0 ]; do
          shift
          SHIFT_TIMES=$[$SHIFT_TIMES-1]
        done
      fi
    else
      if [ "${ARGS_SIZE}" -eq "$#" ]; then
        log_error "command ${TOOL_NAME} is not recongnized"
        help
        exit 1
      fi
      log_warn "unrecognized option ${1}"
    fi
    ;;
esac
done

if [ "${VERBOSE_MODE}" == "yes" ]; then
  LOG_LEVEL="${LOG_LEVEL_INFO}"
fi

if [[ "${PRINT_HELP}" == "yes" && "${SOURCED}" != "yes" ]]; then
  help
  exit 0
fi

if [[ "${PRINT_HELP}" == "yes" && "${SOURCED}" == "yes" ]]; then
  tool_help
  exit 0
fi

if [ ${SOURCED} == "no" ]; then
  log_error "command ${TOOL_NAME} is not recongnized"
  exit 1
fi

tool_execute
