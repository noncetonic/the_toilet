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

EXPECTED_ARGS=3
E_BADARGS=66

if [ $# -ne $EXPECTED_ARGS ]
then
clear
  echo -e "\n`basename $0`: Written by William SubINacls Coppola\n"
  echo "This tool requires 3 arugments:"
  echo -e "\t1) Target ip list"
  echo -e "\t2) Clients Name"
  echo -e "\t3) Timing for the port scanning\n"
  echo -e "Usage: bash -e `basename $0` ~/somedir/target_ips.txt clients_name [1-5]:timing"
  echo -e "Example: bash -e `basename $0` /home/userX/targets.txt ACME_PHARM 4"
Example: bash -e `basename $0` /home/userX/targets.txt ACME_PHARM 4\n\n"
  exit $E_BADARGS
else
 nmap -sTV -vvv -n -T `echo $3` -p- -P0 -A -oA `echo $2` -iL `echo $1`
fi

