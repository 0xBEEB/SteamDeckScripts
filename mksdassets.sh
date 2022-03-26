#!/usr/bin/bash

# This script will download flatpak image logos and create assets sized for the Steam Deck.
#
# Simply, go to flathub.org or beta.flathub.org. Look up the app, then note the url.
# It will be something like:
#
#     https://beta.flathub.org/apps/details/com.test.App
#
# Copy the com.test.App part for your app, and paste it as shown below.
#
# Usage:
# 
#     mksdasset.sh com.test.App
#


NAME=$1
COLOR="black"

mkasset() {
    w=$1
    h=$2
    ow=($w/2)-128
    oh=($h/2)-128
    ffmpeg -i "$NAME.jpg" -qscale:v 0 -vf "scale=256:256,pad=$w:$h:$ow:$oh:color=$COLOR" "${w}x${h}-$NAME.png" 
}

mkdir $NAME
cd $NAME

curl "https://dl.flathub.org/repo/appstream/x86_64/icons/128x128/$NAME.png" > "$NAME.png"
ffmpeg -i "$NAME.png" -qscale:v 2 "$NAME.jpg"

mkasset 600 900
mkasset 3840 1240
mkasset 1280 720
mkasset 2108 460
rm "$NAME.png"
