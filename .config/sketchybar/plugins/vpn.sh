#!/bin/bash

VPN=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')

if [[ $VPN != "" ]]; then
  sketchybar --set vpn icon= \
                          label="$VPN" \
                          drawing=on
else
  sketchybar --set vpn drawing=off
fi
