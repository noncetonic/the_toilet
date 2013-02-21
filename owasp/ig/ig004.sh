#!/usr/bin/env bash
if [ -z $1 ]; then
 echo -e "\n\t\t\x5b\x7b\x2d\x2e\x2d\x7d\x5d\x20\xE2\x98\xA0\x20\x43\x4c\x45\x41\x52\x20\x54\x65\x61\x6d\x20\x4d\x6f\x74\x68\x65\x72\x20\x46\x75\x63\x6b\x65\x72\xE2\x98\xA0\n\t"
 echo -e "Issues HEAD request to servers listed in file"
 echo -e "\n[-] bash -e ./ig004.sh ./file"
 echo -e "[-] bash -e ./ig004.sh ./file --ssl"
 echo -e "\n\t[*] File input should be in this format '{IP_ADDRESS}:{PORT}'\n"
fi
if [ ! -d ./ig004 ]; then
 mkdir ./ig004
fi
if [ -z $2 ]; then 
 for x in $(cat $1); do 
  if [ -f ./ig004/OWASP-IG-004_$x.txt ]; then
   echo "skipping ./ig004/OWASP-IG-004_`echo $x| cut -d":" -f1`.txt as it exist already..."			
  else			
   echo -e "HEAD / HTTP/1.0\n\n" | ncat -d3 -vv `echo $x | cut -d":" -f1` `echo $x | cut -d":" -f2` 2>&1 > ./ig004/OWASP-IG-004_$x.txt
  fi	
 done
else
 for x in $(cat $1); do 
  if [ -f ./ig004/OWASP-IG-004_ssl_$x.txt ]; then
   echo "skipping ./ig004/OWASP-IG-004_ssl_`echo $x| cut -d":" -f1`.txt as it exist already..."
  else			
   echo -e "HEAD / HTTP/1.0\n\n" | ncat $2 -d3 -vv `echo $x | cut -d":" -f1` `echo $x | cut -d":" -f2` 2>&1 > ./ig004/OWASP-IG-004_ssl_$x.txt		
  fi	
 done
fi

echo -e "\n\t\t\x5b\x7b\x2d\x2e\x2d\x7d\x5d\x20\xE2\x98\xA0\x20\x43\x4c\x45\x41\x52\x20\x54\x65\x61\x6d\x20\x4d\x6f\x74\x68\x65\x72\x20\x46\x75\x63\x6b\x65\x72\xE2\x98\xA0\n"
