#!/bin/bash
 
clear
bgred='\e[41m'
bgreen='\e[42m'
bgyellow='\e[43m'
cbg='\e[0m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
B='\e[1m'
CC='\e[0m'
yellow='\e[1;33m'
CY='\e[36m'
clear
 
printf "${lightgreen}"
cat << MILKNIGHT
 
https://greez.my.id
======================================================================
  __  __   ___   _       _  __  _   _   ___    ____   _   _   _____ 
 |  \/  | |_ _| | |     | |/ / | \ | | |_ _|  / ___| | | | | |_   _|
 | |\/| |  | |  | |     | ' /  |  \| |  | |  | |  _  | |_| |   | |  
 | |  | |  | |  | |___  | . \  | |\  |  | |  | |_| | |  _  |   | |  
 |_|  |_| |___| |_____| |_|\_\ |_| \_| |___|  \____| |_| |_|   |_|  
                                                                    
                                                   
=========================[ NETFLIX VALIDATOR ]=========================                             
 
 
MILKNIGHT
function ngecek(){
  if [[ ! -d MILKNIGHT ]]; then
    mkdir MILKNIGHT
  fi
    local listsnya="${white}${1}|${2}${cbg}"
  local datentime0912930123="${yellow}[$(date +"%T")]"
    local result=$(curl -s "https://greez.my.id/Dit.php?net=${1}")
    if [[ $result =~ "EMAIL_VALID" ]]; then
       printf "${CC} [${3}/${4}] ${datentime0912930123} |${listsnya} => ${bgreen}${B}LIVE${CC} \n"
        echo "${1}|${2}" >> GREEZ/live.txt
    elif [[ $result =~ "EMAIL_UNREGISTERED" ]]; then
        printf "${CC} [${3}/${4}] ${datentime0912930123} |${listsnya} => ${bgred}${B}DEAD${CC}\n"
        echo "${1}|${2}" >> GREEZ/die.txt
    else
        printf "${CC} [${3}/${4}] ${datentime0912930123} |${listsnya} => ${CY}${B}UNKNW${CC}\n"
    fi
}
 
# CHECK SPECIAL VAR FOR MAILIST
if [[ -z $1 ]]; then
    printf "To Use $0 <mailist.txt> \n"
    exit 1
fi
 
totallines=$(wc -l < ${1});
itung=1
 
# RATIO
persend=100
setleep=3
 
printf "  ===============================\n"
printf "  [!] Filename: ${1}\n"
printf "  [!] Total Lines: ${totallines}\n"
printf "  [!] Ratio: ${persend} \ ${setleep} Seconds\n"
printf "  ===============================\n\n"
 
IFS=$'\r\n' GLOBIGNORE='*' command eval 'mailist=($(cat $1))'
 
for (( i = 0; i < ${#mailist[@]}; i++ )); do
  index=$((itung++))
    username="${mailist[$i]}"
    IFS='|' read -r -a array <<< "$username"
    email=${array[0]}
    password=${array[1]}
  if [[ $(expr ${i} % ${persend}) == 0 && $i > 0 ]]; then
    percentage=$((100*$i/$totallines))
    wait
    printf "   >> \e[1;33mSleep for ${setleep}s Total Checked: ${i}(${percentage}%%)\n"
    sleep $setleep
   fi
 
    ngecek "${email}" "${password}" "${index}" "${totallines}" &
done
