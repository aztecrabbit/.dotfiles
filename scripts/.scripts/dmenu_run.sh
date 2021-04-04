#!/bin/sh

if [ -z "$(command -v dmenu)" ]; then
	exit 1
fi

dmenu_run -fn "DejaVu Sans-8" -h 22 -nb "#101216" -sb "#3f3f3f"
