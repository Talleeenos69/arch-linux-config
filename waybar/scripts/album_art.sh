#!/bin/bash
# Check for album art using playerctl
album_art=$(playerctl metadata mpris:artUrl 2>/dev/null)
# Download the album art if it exists
if [[ -n "$album_art" ]]; then
   curl -s "${album_art}" --output "/tmp/cover.jpeg"
   echo "/tmp/cover.jpeg"
   exit 0
else
   exit 1
fi
