#!/bin/bash
#
# (;,.Got tired of checking websites ssl certs by hand and made a tool.,;)
#
echo -e "\n[+] assllabs.sh - get your validation on like an 'ass'essor..."
echo -e "[+] Written by: William SubINacls Coppola"
echo -e "[+] Reason: Simply because I hate reports\n"
for site in $(cat $1 |  sed -r 's/(^"(.*)|(.*)"$)/\2\3/g' | sort -u); do
 if [ ! -f $site.assllabs.html ];then
  echo -e "\t[-] Sending $site to SSLLABS to be checked from cache...."
  wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on 
  nappy="Yes"
 fi
done
if [ "$nappy" == "Yes" ];then
 echo -e "\n\t[-] Taking a big sleep" && sleep 30 # diagnostics
 #echo -e "\t\tGot 9m30 to go" && sleep 30 # diagnostics
 #echo -e "\t\t~Got like 2m30s left" && sleep 30 # diagnostics
 #echo -e "\t\t~Got like 2m left" && sleep 30 # diagnostics
 echo -e "\t\t~Got like 1m30 left" && sleep 30 
 echo -e "\t\t~Got like 1m left" && sleep 30 
 echo -e "\t\t~Almost, just another 30s left" && sleep 30 
fi
echo -e "\n\t[-] Grab and Parse results" # diagnostics
for site in $(cat $1 |  sed -r 's/(^"(.*)|(.*)"$)/\2\3/g' | sort -u); do
 if [ ! -f $site.assllabs.html ];then
  echo -e "\n\t[-] Gathering data from SSLLABS on: $site\n"
  wget -i 1 -w 1 -O $site.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on
 fi
done
count="0"
for res in $(ls *.assllabs.html);do 
 Server=`echo $res | sed -r 's/((.*)\.assllabs\.html)/\2/g'`
 let count=count+1
 altn=`cat $res | strings | tr -d "\t" | grep -A1 -E "Alternative" | grep Cell | cut -d " " -f3| sed -r "s/(\&\#45\;)/-/g"| sed -r "s/(\&\#47\;)/\//g"| sed -r "s/\&\#46\;/./g" | sed -r "s/\&\#42\;/*/g" | sed -r "s/\&\#32\;/ ,/g" | sed -r "s/\&\#40\;/(/g" | sed -r "s/\&\#41\;/)/g" | sed -r "s/\&\#90\;/_/g" | sed -r "s/\&\#43\;/+/g"`
 hostn=$(cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Server hostname" | sed -r "s/(\&\#45\;)/-/g"| sed -r "s/(\&\#47\;)/\//g"| sed -r "s/\&\#46\;/./g" | sed -r "s/\&\#42\;/*/g" | sed -r "s/\&\#32\;/ ,/g" | sed -r "s/\&\#40\;/(/g" | sed -r "s/\&\#41\;/)/g" | sed -r "s/\&\#90\;/_/g" | sed -r "s/\&\#43\;/+/g"| cut -d ">" -f2 | sed -r "s/^ (.*)/\1/g"| sed -r "s/<(.*)/,,,/g" | tr -d "\n" | sed -r "s/([0-9A-Za-z.,]{1,}),,,(.*),,,/ `echo $Server` path origin: \2\n/g" | awk -F " " '{print "[-] "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8}' | sed -r "s/((Server )|hostnam)//g")
 sigin=$(cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Server signature" | sed -r "s/(\&\#45\;)/-/g"| sed -r "s/(\&\#47\;)/\//g"| sed -r "s/\&\#46\;/./g" | sed -r "s/\&\#42\;/*/g" | sed -r "s/\&\#32\;/ ,/g" | sed -r "s/\&\#40\;/(/g" | sed -r "s/\&\#41\;/)/g" | sed -r "s/\&\#90\;/_/g" | sed -r "s/\&\#43\;/+/g" | cut -d ">" -f2 | sed -r "s/^ (.*)/\1/g"| sed -r "s/<(.*)/,,,/g" | tr -d "\n" | sed -r "s/([0-9A-Za-z., ]{1,}),,,(.*),,,/ `echo $Server` Identified as: \2\n/g" | awk -F " "  '{print "[-] "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8}' | sed -r "s/((Server) |signatur)//g")
 echo ""
 echo -e "\n{$count} - Examining records from `echo $res| sed -r 's/((.*)\.assllabs\.html)/\2/g'`"
 echo ""
 rate=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep rating_ | cut -d ">" -f2  |cut -d"<" -f1`
 if [ "$rate" != "" ];then
  echo "[-] $Server is rated at: $rate"
 fi
 if [ "$hostn" != "" ];then
  echo -e "$hostn"
 fi
 if [ "$sigin" != "" ];then
  echo -e "$sigin"
 fi
 if [ "$altn" != "" ];then
  echo -e "[-] $Server alter name(s): $altn"
 fi
 ipa=`cat $res | strings | tr -d "\t" | grep -E "class=ip" | cut -d "(" -f2 | cut -d ")" -f1 | sed -r "s/(\&\#45\;)/-/g"| sed -r "s/(\&\#47\;)/\//g"| sed -r "s/\&\#46\;/./g" | sed -r "s/\&\#42\;/*/g" | sed -r "s/\&\#32\;/ ,/g" | sed -r "s/\&\#40\;/(/g" | sed -r "s/\&\#41\;/)/g" | sed -r "s/\&\#90\;/_/g" | sed -r "s/\&\#43\;/+/g" | cut -d " " -f1`
 sipa=`cat $res| strings | tr -d "\t" | grep -E "class=ip" | cut -d "(" -f2 | cut -d ")" -f1 | sed -r "s/(\&\#45\;)/-/g"| sed -r "s/(\&\#47\;)/\//g"| sed -r "s/\&\#46\;/./g" | sed -r "s/\&\#42\;/*/g" | sed -r "s/\&\#32\;/ ,/g" | sed -r "s/\&\#40\;/(/g" | sed -r "s/\&\#41\;/)/g" | sed -r "s/\&\#90\;/_/g" | sed -r "s/\&\#43\;/+/g" | cut -d ">" -f4 | cut -d "<" -f1 | tr -s "\n" "," | sed -r "s/,/ and /g" | sed -r "s/ and $//g"`
 if [ "$ipa" != "" ];then
  echo "[-] $Server has an IP of: $ipa"
 else
  echo "[-] $Server has an IP of: $sipa"
 fi
 cstr=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Common" | grep Cell | cut -d ">" -f4 | cut -d" " -f1 | sed -r "s/(\&\#45\;)/-/g"| sed -r "s/(\&\#47\;)/\//g"| sed -r "s/\&\#46\;/./g" | sed -r "s/\&\#42\;/*/g" | sed -r "s/\&\#32\;/ ,/g" | sed -r "s/\&\#40\;/(/g" | sed -r "s/\&\#41\;/)/g" | sed -r "s/\&\#90\;/_/g" | sed -r "s/\&\#43\;/+/g"`
 mstr=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Common" | grep Cell | cut -d ">" -f6 | cut -d"<" -f1 | sed -r "s/(\&\#45\;)/-/g"| sed -r "s/(\&\#47\;)/\//g"| sed -r "s/\&\#46\;/./g" | sed -r "s/\&\#42\;/*/g" | sed -r "s/\&\#32\;/ ,/g" | sed -r "s/\&\#40\;/(/g" | sed -r "s/\&\#41\;/)/g" | sed -r "s/\&\#90\;/_/g" | sed -r "s/\&\#43\;/+/g"`
 commn=$(echo "$Server common name: $cstr - $mstr") 
 if [ "$mstr" == "MISMATCH" ];then
  echo -e "\t[!] $commn"
 fi
 if [ "`cat $res | strings | tr -d "\t" | grep -E "class=" | grep "<font color\=red>Insecure Renegotiation" | cut -d ">" -f3 | cut -d " " -f1`" = "Insecure" ]; then 
  echo -e "\t[!] `echo $Server` has Insecure Renegotiation enabled "
 fi
 if  [ "`cat $res | strings | tr -d "\t" | grep -E "font color=red" | cut -d">" -f2 | cut -d" " -f1 | grep BEAST`" = "BEAST" ]; then
  echo -e "\t[!] `echo $Server` is victim to BEAST Attacks"
 fi
 CRIME=`cat $res | strings | tr -s "\t" " " | grep CRIME | cut -d">" -f3 | sed -r "s/(CRIME)/\1/g" | cut -d" " -f7`
 if [ "$CRIME" == "CRIME" ]; then
  echo -e "\t[!] `echo $Server` is victim to CRIME Attacks"
 fi
 ssll=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "SSL 2" | grep Right | cut -d ">" -f2 | cut -d"<" -f1`
 if [ "$ssll" == "Yes N" ]; then
  echo -e "\t[!] `echo $Server` Supports SSLv2, but provides NO ciphers"
 fi
 if [ "$ssll" == "Yes" ]; then
  echo -e "\t[!] `echo $Server` Supports SSLv2"
 fi
 expire=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep "expires in" | cut -d "(" -f2 | cut -d ")" -f1 | awk -F " " '{print "[-] Servers certification expiration in: { "$3" "$4" - "$6" "$7" }" }'` | sed -r "s/Server/`echo $Server`/g"
 if [ "$expire" != "" ];then
  echo $expire
 fi
 pci=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "PCI compliant" | grep Cell | cut -d " " -f3`
 if [ "$pci" != "" ];then
  if [ "$pci" != "Yes" ]; then 
   echo -e "\t[!] $Server is NOT compliant to PCI"
  fi
 fi
 echo ""
 # echo -e " \t[*] Finished $res\n\n" # diagnostics
done | sed -r "s/\[(.*)\] (.*)/\t\[\1\] \2/g"
echo -e "\nYEAH! It's  Mathmagical..\n"
