#!/bin/bash

# feed namp a list of ports and IP/Hostnames for testing
# your port list should look like this U:123,U140-150,T:1,T:2-
# saved to a file to be concatinated into the script command

# help information
if [[ $1 == "-h" || $1 == "h" || $1 == "help" || $1 == "-help" || $1 == "--help" || $1 == "--h" || $1 == "-H" || $1 == "-HELP" || $1 == "--HELP" || $1 == "H" || $1 == "HELP" ]];then
  echo -e "\n[-] Cmd Usage:"
  echo -e "\t./nmap_me.sh ./your_port_list.txt ./your_host_list.txt\n"
  exit
fi

# check for proper parameters for application, only 2 required
if [[ ! -z $3 ]];then
  echo -e "\n[-] Cmd Usage:\n"
  echo -e "\t./nmap_me.sh ./your_port_list.txt ./your_host_list.txt\n"
  exit
fi

# check for portlist
if [[ -z $1 ]]; then
  echo -e "\n\t[*] Please supply your portlist to be used\n"
  exit
fi

# check for port and host list and continue if found, else kill yourself...
if [[ ! -z $1  &&  -z $2 ]]; then
  echo -e "\n\t[*] Please supply your hostlist to be used\n"
  exit
fi

# actual command to construct and execute
if [[ ! -z $1  &&  ! -z $2 ]]; then
  if [[ -f $1  &&  -f $2 ]]; then
    if [ ! -d ./nmap ];then
      mkdir ./nmap
    fi
    nmap -sCV --open -T5 -P0 -n -vvv -p `cat $1` -A -O -iL $2 -oA ./nmap/NMAP_UDP_TCP_`pwd | cut -d"/" -f3`
  fi
else
  echo -e "\t[-] Application terminated with unknown error\n"
  exit
fi
