#!/bin/bash

# Configuration
RESOLUTION_WIDTH=2560
RESOLUTION_HEIGHT=1440
FRAME_RATE=165

# Find the first available TTY
for tty in {8..12}; do
    if ! pgrep -t tty$tty > /dev/null; then
        available_tty=$tty
        break
    fi
done

if [ -z "$available_tty" ]; then
    echo "No available TTY found"
    exit 1
fi

# Create a temporary Xorg configuration file
cat << EOF > /tmp/xorg.conf
Section "Device"
    Identifier "GPU"
    Driver "modesetting"
    Option "AccelMethod" "glamor"
EndSection

Section "Screen"
    Identifier "Screen"
    Device "GPU"
    DefaultDepth 24
    SubSection "Display"
        Depth 24
        Modes "${RESOLUTION_WIDTH}x${RESOLUTION_HEIGHT}"
    EndSubSection
EndSection
EOF

# Switch to the available TTY and launch Gamescope with Steam
sudo chvt $available_tty
sudo -u $USER startx /usr/bin/gamescope \
    -W $RESOLUTION_WIDTH \
    -H $RESOLUTION_HEIGHT \
    -r $FRAME_RATE \
    -f \
    --xorg-config /tmp/xorg.conf \
    -- steam -bigpicture \
    -- :1 vt$available_tty
