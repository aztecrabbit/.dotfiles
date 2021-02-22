#!/bin/bash

notify-send -t 3000 "Updating Playlist" "Please wait ..."

music_directory="$(cd $HOME/Music; pwd -P)"

music_playlist="$(find "$music_directory" -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.loss' -o -name '*.aiff' -o -name '*.aif' \) -exec ls -d {} \; | sort)"
music_playlist_filename="$HOME/.local/share/mpd/playlists/music.m3u"

cat << EOF > "$music_playlist_filename"
#EXTM3U

$music_playlist
EOF
