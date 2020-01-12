#!/bin/sh

killall -q -e compton

compton --config ~/.config/compton/compton.conf > /dev/null 2>&1 &
