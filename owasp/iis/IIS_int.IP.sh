
#
# Written by William SubINacls Coppola
# quickly test for IIS internal IP leak
# example usage: read the code below ...
#
# bash -e $0 ./websites.txt 2>&1 | tee -a w00t.txt # this will log all output to file w00t.txt
#
# Your milage may vary - like it or hate it, it simply works
#

if [ -z $1 ]; then
echo -e "\n[*] - { Read the source luke... }"
 echo -e "[*] - example: ./iss_int-IP.sh ./websites.txt # its that simple"
 echo -e "[*]\n"
 exit
else
 for t in $(cat $1);do
  echo -e "HEAD / HTTP/1.0\n\n\n" | ncat -i 1 --ssl $1 443 2> /dev/null | grep -i -E "(Content-Loc)" | xargs echo $1 - | grep -E -v "(((([0-9]){1,3}\.){3}[0-9]{1,3}))$"
 done
fi