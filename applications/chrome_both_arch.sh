#!/bin/zsh

# make temp folder for downloads
mkdir "/tmp/googlechrome"

# change working directory
cd "/tmp/googlechrome"

# Download Correct Google Chrome based on Architecture
 
arch_name="$(uname -m)"
 
if [ "${arch_name}" = "x86_64" ]; 
then 
curl -L -o "/tmp/googlechrome/Googlechrome.dmg" "https://dl.google.com/chrome/mac/stable/GGRO/Googlechrome.dmg"
elif [ "${arch_name}" = "arm64" ]; 
then curl -L -o "/tmp/googlechrome/Googlechrome.dmg" "https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
fi

# Mount the DMG
hdiutil attach Googlechrome.dmg -nobrowse

# Install Google Chrome
cp -r /Volumes/Google\ Chrome/*app /Applications

#Tidy Up
hdiutil unmount "/Volumes/Google Chrome"
sleep 5
sudo rm -rf "/tmp/googlechrome"
sleep 5

#Bless Google Chrome app
xattr -rc "/Applications/Google Chrome.app"