#!/bin/bash

CONFIG_COMMAND="git config"
GLOBAL_CONFIG=""
CONFIGURE_GIT_ALIASES="no"
CONFIGURE_ALIASES="no"
SHORTCUTS_DIR="${SCRIPTPATH}"
GIT_ALIAS_UNSET=""
SHORTCUT_UNSET="no"

function tool_help() {
    echo "config command usage: sgit config [ARGUMENT VALUE]... [OPTION]"
    echo ""
    echo "Arguments:"
    echo -e "\t-u, --username\t\t\tname of the user for git env"
    echo -e "\t-e, --email\t\t\temail of the user for git env"
    echo -e "\t--editor\t\t\tgit editor"
    echo "Options:"
    echo -e "\t--global\t\t\tapply git configuration globaly"
    echo -e "\t--git-alias\t\t\tconfigure git aliases"
    echo -e "\t--alias\t\t\t\tconfigure aliases"
    echo -e "\t--unset\t\t\t\tremove configuration"
}

function tool_args() {
    local RETURN_VALUE=0
    case "${1}" in
      config)
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
      --global)
      SHIFT_TIMES=1
      GLOBAL_CONFIG="--global"
      ;;
      --git-alias)
      SHIFT_TIMES=1
      CONFIGURE_GIT_ALIASES="yes"
      ;;
      --alias)
      SHIFT_TIMES=1
      CONFIGURE_ALIASES="yes"
      ;;
      --unset)
      SHIFT_TIMES=1
      UNSET_CONFIG="yes"
      GIT_ALIAS_UNSET="--unset"
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
      CMD="${CONFIG_COMMAND} ${GLOBAL_CONFIG} ${GIT_ALIAS_UNSET} ${CONFIG_NAME} \"${CONFIG_VALUE}\""
      eval "${CMD}"
      if [ "${UNSET_CONFIG}" == "yes" ]; then
        log_info "\t${CONFIG_NAME} is unset"
      else
        log_info "\t'${CONFIG_NAME}' is set to \"${CONFIG_VALUE}\""
      fi
    fi
}

function tool_execute() {
    configure_if_not_empty "user.name" "${USERNAME_ARG}"
    configure_if_not_empty "user.email" "${EMAIL_ARG}"
    configure_if_not_empty "core.editor" "${EDITOR_ARG}"
    
    if [ "${CONFIGURE_GIT_ALIASES}" = "yes" ]; then
      log_info "git aliases configuration..."
      while read -r line || [[ -n "$line" ]]; do
        echo "${line}" | grep --silent --regexp "^\s*$"
        if [ ! "$?" -eq 0 ]; then
          name=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\2/")
          value=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\3/")
          configure_if_not_empty "alias.${name}" "${value}"
        fi
      done < "${SCRIPTPATH}/config/aliases.properties"
      log_msg ""
    fi
    
    if [ "${CONFIGURE_ALIASES}" = "yes" ]; then
      log_info "aliases configuration..."
      while read -r line || [[ -n "$line" ]]; do
        echo "${line}" | grep --silent --regexp "^\s*$"
        if [ ! "$?" -eq 0 ]; then
          name=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\2/")
          value=$(echo "$line" | sed --regexp-extended "s/(([^=]+)=(.*))/\3/")
          if [ ! -z "${value}" ]; then
            SHORTCUT_SCRIPT="${SHORTCUTS_DIR}/git${name}"
            if [ "${UNSET_CONFIG}" == "yes" ]; then
              rm "${SHORTCUT_SCRIPT}"
            else
              touch "${SHORTCUT_SCRIPT}"
              chmod a+x "${SHORTCUT_SCRIPT}"
              echo "#!/bin/bash" >> "${SHORTCUT_SCRIPT}"
              echo "git ${value}" >> "${SHORTCUT_SCRIPT}"
              log_info "\t'${name}' is set to \"${value}\""
            fi
          fi
        fi
      done < "${SCRIPTPATH}/config/aliases.properties"
    fi
}
