#!/bin/bash
  if [ "$1" = "--list" ] ; then
      cat inventory.json
  elif [ $2 = "--host"]; then
      echo "[]"
  else
      echo "usage: --list"
  fi
