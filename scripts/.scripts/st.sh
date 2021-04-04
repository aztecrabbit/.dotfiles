#!/bin/sh

if [ "$(command -v scroll)" ]; then
	st -e scroll
else
	st
fi
