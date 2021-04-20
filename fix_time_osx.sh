#!/bin/sh
#Script auto fix time on hackintosh
#Version 1.1: Apr 11, 2021
#OSX: 11 and above

echo "This script required to run as root"

sudo curl -o "/tmp/localtime-toggle" "https://raw.githubusercontent.com/maxlike/localtime-toggle/main/localtime-toggle"
sudo curl -o "/tmp/org.osx86.localtime-toggle.plist" "https://raw.githubusercontent.com/maxlike/localtime-toggle/main/org.osx86.localtime-toggle.plist"

echo "Downloading required file"

# exit if error
if [ "$?" != "0" ]; then
echo "Error: Download failure, verify network"
exit 1
fi

echo "Copy file to destination place..."

sudo cp -R "/tmp/localtime-toggle" "/usr/local/"
sudo cp -R "/tmp/org.osx86.localtime-toggle.plist" "/Library/LaunchDaemons/"

sudo rm /tmp/localtime-toggle
sudo rm /tmp/org.osx86.localtime-toggle.plist

echo "Chmod localtime-toggle..."

sudo chmod +x /usr/local/localtime-toggle

echo "Chmod org.osx86.localtime-toggle.plist..."

sudo chown root /Library/LaunchDaemons/org.osx86.localtime-toggle.plist
sudo chmod 644 /Library/LaunchDaemons/org.osx86.localtime-toggle.plist

echo "Load LaunchDaemons..."

sudo launchctl load -w /Library/LaunchDaemons/org.osx86.localtime-toggle.plist

echo "Done!"
