#!/bin/bash

if [ "$(tty)" = "/dev/tty1" ]; then
  startx

  echo "Enter to continue"
  read

  logout
fi
