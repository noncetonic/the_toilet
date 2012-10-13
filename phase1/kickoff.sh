#
# Written by William SubINacls Coppola
# Takes user supplied list of IP addresses / DNS names and iterates them through nmap
## Generates list of assets and ports based on FULL out portscan TCP for all assets regardless of PING
### This script does not handle the parsing of the actual logs, this is preformed by other scripts
#
# bash -e kickoff.sh ~/somedir/target_ips.txt clients_name [1-5]:timing
#
### ie: bash -e ./kickoff.sh /home/userX/targets.txt ACME_PHARM 4
#
# Your milage may vary - like it or hate it, it simply works
#

if [ -z $1 ]; then
 echo -e "\n[*]  Cmd Structure: bash -e kickoff.sh ~/somedir/target_ips.txt clients_name [1-5]:timing"
 echo -e "[*]\tie: bash -e ./kickoff.sh /home/userX/targets.txt ACME_PHARM 4\n"
 exit
else
 if [ -z $2 ]; then
  echo -e "\n[*] - { Read the source luke... }"
  echo -e "[*]\tbash -e kickoff.sh ~/somedir/target_ips.txt clients_name [1-5]:timing"
  echo -e "[*]\tie: bash -e ./kickoff.sh /home/userX/targets.txt ACME_PHARM 4\n"
  exit
 else
  nmap -sTV -vvv -n -T `echo $3` -p- -P0 -A -oA `echo $2` -iL `echo $1`
 fi
fi

