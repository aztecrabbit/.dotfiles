#!/bin/bash

declare -A radios

# radios["Alternative (BAGeL Radio - SomaFM)"]="http://somafm.com/bagel.pls"
# radios["American Roots (Boot Liquor - SomaFM)"]="http://somafm.com/bootliquor.pls"
# radios["Celtic (ThistleRadio - SomaFM)"]="http://somafm.com/thistle.pls"
# radios["Chillout (Groove Salad - SomaFM)"]="http://somafm.com/startstream=groovesalad.pls"
# radios["Commodore 64 Remixes (Slay Radio)"]="http://www.slayradio.org/tune_in.php/128kbps/listen.m3u"
# radios["Covers (SomaFM)"]="http://somafm.com/covers.pls"
# radios["Downtempo (Secret Agent - SomaFM)"]="http://somafm.com/secretagent.pls"
# radios["Dub Step (Dub Step Beyond - SomaFM)"]="http://somafm.com/dubstep.pls"
# radios["Folk (Folk Forward - SomaFM)"]="http://somafm.com/folkfwd.pls"
# radios["House (Beat Blender - SomaFM)"]="http://somafm.com/startstream=beatblender.pls"
# radios["Indie Pop (Indie Pop Rocks! - SomaFM)"]="http://somafm.com/indiepop130.pls"
# radios["Intelligent dance music (Cliq Hop - SomaFM)"]="http://somafm.com/startstream=cliqhop.pls"
# radios["Jazz (Sonic Universe - SomaFM)"]="http://somafm.com/startstream=sonicuniverse.pls"
# radios["Lounge (Illinois Street Lounge - SomaFM)"]="http://somafm.com/illstreet.pls"
# radios["Pop (PopTron! - SomaFM)"]="http://somafm.com/poptron.pls"
# radios["Progressive (Tags Trance Trip - SomaFM)"]="http://somafm.com/thetrip.pls"
# radios["Rock (Digitalis - SomaFM)"]="http://somafm.com/digitalis.pls"

# radios[""]=""

radios["Life Chill Music"]="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://aska.ru-hoster.com:8053/autodj.m3u&t=.pls"
radios["Chill Lounge Florida"]="http://us5.internet-radio.com:8283/listen.pls"
radios["Radio Play Emotions - Music for Work and Relax"]="http://5.39.82.157:8054/listen.pls?sid=1"
radios["Majestic Jukebox Radio"]="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk3.internet-radio.com:8405/live.m3u&t=.pls"
radios["Smooth Jazz CD 101.9 New York"]="http://us3.internet-radio.com:8485/listen.pls"
radios["Smooth Jazz Florida"]="http://us4.internet-radio.com:8266/listen.pls"
radios["Radio Estilo Leblon"]="http://us4.internet-radio.com:8193/listen.pls"
radios["EZ Hits South Florida"]="http://us4.internet-radio.com:8197/listen.pls"
radios["Merge 104.8"]="http://uk7.internet-radio.com:8040/listen.pls"
radios["Venice Classic Radio Italia"]="http://174.36.206.197:8000/listen.pls"


#
#

playlist_filepath="$HOME/.local/share/mpd/playlists/radio.m3u"

mkdir -p "$(dirname "$playlist_filepath")"

cat << EOF > "$playlist_filepath"
#EXTM3U

EOF

for k in "${!radios[@]}"; do
	notify-send -t 2500 "Updating Radio Playlist" "$k"

	stream_url="$(curl -s ${radios[$k]} | grep -m 1 -E 'https?://' | awk -F 'http' '{printf "http"$2"\n"}')"

	cat << EOF >> "$playlist_filepath"
#EXTINF:-1,${k}
${stream_url}

EOF

done

sleep 2.500

notify-send -t 3000 "Radio Playlist Updated" "Happy Listening :)"

mpc clear && mpc load radio && mpc random on && mpc play
