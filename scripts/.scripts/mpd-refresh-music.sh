#!/bin/bash

notify-send -t 3000 "Updating Music Playlist" "Please wait ..."

music_dir="$HOME/Music"

playlist="$(cd $music_dir; find . -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.loss' -o -name '*.aiff' -o -name '*.aif' \) -exec ls -d {} \; | awk '{ print "'$music_dir/'"$0}' | sort)"
playlist_filepath="$HOME/.local/share/mpd/playlists/music.m3u"

mkdir -p "$(dirname "$playlist_filepath")"

cat << EOF > "$playlist_filepath"
#EXTM3U

$playlist
EOF

notify-send -t 3000 "Music Playlist Updated" "Happy Listening :)"

mpc clear && mpc load music && mpc random on && mpc play
