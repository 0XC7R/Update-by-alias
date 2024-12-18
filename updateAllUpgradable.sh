#!/bin/bash

echo "#####################################################################################"
echo "#   All options will default to non-yes options if \"yes\"/\"y\" is not parsed.         #"
echo "#   Parse any input (including empty) if you do not want to do \"yes\"/\"y\" options.   #"
echo "#####################################################################################"

echo "Update apt sources? (yes/y): "
read update

# update sources first since we will want to make sure we are able to upgrade them first

if [ "$update" == "yes" ] || [ "$update" == "y" ]; then
   sudo apt update && clear # change to your systems clear command if clear does not exist which it should :/
else
   echo "Not updating list of upgradable packages."
fi

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
