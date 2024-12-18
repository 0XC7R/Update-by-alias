#!/bin/bash

echo "########################################################"
echo "All options will default to \"n\"/\"no\" type options if \"yes\"/\"y\" is not parsed."
echo "########################################################\n"

echo "Grep Phrase (e.g python): "
read Phrase

echo "Delete upgradable text file? (yes/y): "
read delOnF

echo "Auto Install? (yes/y): "
read autoI

# get all upgradables from x phrase > loop through each row (pkg1 \n pkg2 etc) from "upgradable.txt"
sudo apt list --upgradable | grep "$Phrase" | awk -F/ '{print $1}' > upgradable.txt

# give choice because we might not want to just blindly install

if [ "$autoI" = "yes" ] || [ "$autoI" = "y" ]; then
   sudo apt install -y $(cat upgradable.txt)
else
   sudo apt install $(cat upgradable.txt)
fi

# if we want to delete it we will then do so
if [ "$delOnF" = "yes" ] || [ "$delOnF" = "y" ]; then
   sudo rm -rf "upgradable.txt" # run as sudo because we might not have perms 
else 
   echo "Did not remove \"upgradable.txt\". Can be found in the directory the script was ran in. example: ~/upgradable.txt"
fi
