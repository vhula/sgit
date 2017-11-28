#!/bin/bash

LOG_LEVEL_OFF=6
LOG_LEVEL_ERR=5
LOG_LEVEL_WARN=4
LOG_LEVEL_INFO=3

LOG_LEVEL="${LOG_LEVEL_WARN}"

function log_msg0() {
    local ALLOWED_LOG_LEVEL="${1}"
    local MSG="${2}"
    local PREFIX="${3}"
    if [ "${LOG_LEVEL}" -le "${ALLOWED_LOG_LEVEL}" ]; then
      echo -e "${PREFIX}${MSG}"
    fi
}

function log_error() {
    log_msg0 "${LOG_LEVEL_ERR}" "${1}" "Error: "
}

function log_warn() {
    log_msg0 "${LOG_LEVEL_WARN}" "${1}" "Warn: "
}

function log_info() {
    log_msg0 "${LOG_LEVEL_INFO}" "${1}" "Info: "
}

function log_msg() {
    log_msg0 "${LOG_LEVEL_ERR}" "${1}" ""
}