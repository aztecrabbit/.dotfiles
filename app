#!/bin/bash

currentpath="$(pwd)"
dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

cd $dotfiles

mkdir -p "${HOME}/.config/mps-youtube"

ln -sf "${dotfiles}/mpv/.config/mpv/input.conf" "${HOME}/.config/mps-youtube/mpv-input.conf"

cd $currentpath
