#!/bin/sh

# Install new fonts from this directory (expeting that we are in the ~/.fonts
# dir).

#Create fonts.scale
echo "> Creating fonts.scale"
mkfontscale

#Create fonts.dir
echo "> Creating fonts.dir"
mkfontdir

# rebuilds ~/.fontconfig/
echo "> rebuilding fonts"
fc-cache -fv ~/.fonts
