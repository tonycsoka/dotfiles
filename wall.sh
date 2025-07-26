#!/bin/bash

cp $1 ~/.config/wallpaper.jpg
wal --contrast 1.0 --saturate 0.25 -n -e -q -i ~/.config/wallpaper.jpg

source ~/.cache/wal/colors.sh

sed -i "s/\( active-color\).*/\1 \"$color6\"/" ~/.config/niri/config.kdl
systemctl --user restart swaybg
