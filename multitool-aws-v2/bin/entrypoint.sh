#!/bin/bash

if [[ "${1}" == "" ]]; then
  /bin/bash
elif [[ -f "/usr/local/bin/${1}" ]] then
  "$@"
else
  /usr/local/bin/aws "$@"
fi
