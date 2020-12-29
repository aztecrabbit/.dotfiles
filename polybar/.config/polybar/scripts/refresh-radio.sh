#!/bin/bash
set -e
playlistdir=$HOME/.local/share/mpd/playlists

notify-send -t 3000 "Updating Radio Playlist" "Please wait ..."

declare -A radios

radios["Alternative (BAGeL Radio - SomaFM)"]="http://somafm.com/bagel.pls"
# radios["Alternative (The Alternative Project)"]="http://c9.prod.playlists.ihrhls.com/4447/playlist.m3u8"
radios["American Roots (Boot Liquor - SomaFM)"]="http://somafm.com/bootliquor.pls"
radios["Celtic (ThistleRadio - SomaFM)"]="http://somafm.com/thistle.pls"
radios["Chillout (Groove Salad - SomaFM)"]="http://somafm.com/startstream=groovesalad.pls"
# radios["Commodore 64 Remixes (Slay Radio)"]="http://www.slayradio.org/tune_in.php/128kbps/listen.m3u"
radios["Covers (SomaFM)"]="http://somafm.com/covers.pls"
radios["Downtempo (Secret Agent - SomaFM)"]="http://somafm.com/secretagent.pls"
radios["Dub Step (Dub Step Beyond - SomaFM)"]="http://somafm.com/dubstep.pls"
radios["Electronic, Dance (Electronic Culture)"]="http://www.shouted.fm/tunein/electro-dsl.m3u"
radios["Folk (Folk Forward - SomaFM)"]="http://somafm.com/folkfwd.pls"
# radios["Hip Hop (Hot 97 NYC)"]="http://playerservices.streamtheworld.com/pls/WQHTAAC.pls"
# radios["Hip Hop (Power 1051 NYC)"]="http://c11.prod.playlists.ihrhls.com/1481/playlist.m3u8"
radios["House (Beat Blender - SomaFM)"]="http://somafm.com/startstream=beatblender.pls"
radios["Indie Pop (Indie Pop Rocks! - SomaFM)"]="http://somafm.com/indiepop130.pls"
radios["Intelligent dance music (Cliq Hop - SomaFM)"]="http://somafm.com/startstream=cliqhop.pls"
radios["Jazz (Sonic Universe - SomaFM)"]="http://somafm.com/startstream=sonicuniverse.pls"
radios["Lounge (Illinois Street Lounge - SomaFM)"]="http://somafm.com/illstreet.pls"
radios["Pop (PopTron! - SomaFM)"]="http://somafm.com/poptron.pls"
radios["Pop, Rock, Urban  (Frequence 3 - Paris) "]="http://streams.frequence3.net/hd-mp3.m3u"
radios["Progressive (Tags Trance Trip - SomaFM)"]="http://somafm.com/thetrip.pls"
# radios["Public Radio (WNYC - Public Radio from New York to the World)"]="http://whttp://SomaFM.com/thetrip.plsnyc-iheart.streamguys.com/wnycfm-iheart.aac"
radios["Reggae Dancehall (Ragga Kings)"]="http://www.raggakings.net/listen.m3u"
radios["Rock (Digitalis - SomaFM)"]="http://somafm.com/digitalis.pls"
# radios["Vox Noctem: Rock-Goth"]=" http://r2d2.voxnoctem.de:8000/voxnoctem.mp3"
# radios["Beyond Metal (Progressive - Symphonic)"]="http://streamingV2.shoutcast.cohttp://SomaFM.com/thetrip.plsm/BeyondMetal"

filepath="${playlistdir}/radio.m3u"
rm -f "$filepath"

printf "#EXTM3U\n\n" >> "$filepath"

for k in "${!radios[@]}"; do
	# echo "#EXTINF:-1,$k" >> "$filepath"
	curl -s ${radios[$k]} | grep -m 1 'https\?://' | awk -F http '{printf "http"$2"\n\n"}' >> "$filepath"
	notify-send -t 500 "Updating Radio Playlist" "$k"
done

notify-send -t 3000 "Radio Playlist Updated" "Happy Listening :)"
