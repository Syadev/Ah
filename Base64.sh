#!/bin/bash
#Dependent on some OS X stuff; should be pretty easy to make compatible on different Unicies
#Make sure you run 'chmod +x Base64.sh' to be able to run it
#Run in Terminal and pass the file as an argument, or pass the file in during the prompt

if [ -z "$1" ]; then
  read -p "What file do you want to encode? " file
else
  file=$1
fi
  
encode=$(echo "data:")+$(file --mime-type -b "$file")+";base64,"+$(base64 -i "$file")
echo $encode | pbcopy
echo "
$encode
Copied to clipboard!"

