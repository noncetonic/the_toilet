#
#


EXPECTED_ARGS=4
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  clear
  echo " "
  echo "Written by Rob Dixon a.k.a. 304Geek"
  echo " "
  echo "Shout out to Mubix for the sweet listener @yo.letmeoutofyour.net!!"
  echo " "
  echo " "
  echo "This tool requires 4 arugments:"
  echo "1) Client"
  echo "2) Zone - (This is the logical name for the network segment that you are sitting on)"
  echo "3) IP   - (Your IP Address - 192.168.1.2)"
  echo "4) Input File - (Port list)"
  echo " "
  echo "Usage: `basename $0` CLIENTNAME ZONE IPADDRESS INPUTFILE"
  echo " "
  echo "Example: ./bottleopener.sh ACME DMZ1 192.168.1.2 top-ports.list"
  echo " "
  echo " "
exit $E_BADARGS
fi

#ext=$(wget -o /dev/null -O- icanhazip.com 2>&1 /dev/null &)
ext=$(curl --silent --connect-timeout 1 icanhazip.com 2>&1 /dev/null &)
for i in $(cat ports);do
 #response=$(wget -q -O- -t 1 --timeout=1 yo.letmeoutofyour.net:$i 2>&1 /dev/null &)
 response=$(curl --silent --connect-timeout 1 http://yo.letmeoutofyour.net:$i 2>&1 /dev/null &)
 case "$response" in 
  w00tw00t)echo -e "Port: $i   \tOPEN" && echo "$1, $2, $3, $ext, $i, OPEN, PASSED, " >> $1_$2_$3_EGRESS_TEST.csv ;;
  *)echo -e "Port: $i   \tCLOSED" && echo "$1, $2, $3, $ext, $i, CLOSED, FAILED, " >> $1_$2_$3_EGRESS_TEST.csv ;; 
 esac
done
