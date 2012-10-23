#!/bin/bash
#
# (;,.Got tired of checking websites ssl certs by hand and made a tool.,;)
#
test=`uname`
if [ "$test" == "Darwin" ];then
 sed="sed -E "
else
 sed="sed -r " 
fi
echo -e "\n[+] assllabs.sh - get your validation on like an 'ass'essor..."
echo -e "[+] Written by: William SubINacls Coppola"
echo -e "[+] Reason: Simply because I hate reports\n"
echo "" > assllabs.csv
echo "Tracking number,IP,Commonnames,Alternativenames,Prefixhandling,Validfrom,Validuntil,Key,Signaturealgorithm,ServerGatedCryptography,Weakkey(Debian),Issuer,NextIssuer,NextIssuer,Chainlength(size),Chainissues,ExtendedValidation,Revocationinformation,Revocationstatus,Trusted,,InsecureRenegotiation,,Compression,NextProtocolNegotiation,Sessionresumption,Sessiontickets,OCSPstapling,StrictTransportSecurity,RequiresclientRIsupport,Longhandshakeintolerance,TLSextensionintolerance,TLSversionintolerance,Testdate,Testduration,Serversignature,Serverhostname,PCIcompliant,FIPS-ready" >> assllabs.csv
for site in $(cat $1 | $sed's/(^"(.*)|(.*)"$)/\2\3/g' | sort -u); do
 #echo $site # diagnostics
 if [ ! -f $site.assllabs.html ];then
  echo -e "\t[<] Sending $site to SSLLABS to be checked from cache...."
  #echo "wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on "
  wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on 
  nappy="Yes"
 fi
done
ttime=3
#ttime=$( echo "`echo $rsipa | wc -l` * 30" | bc)
echo -e "\t\t[!]Sleeping a total time of: $ttime"
sleep $ttime
head -n1 < /dev/null
for site in $(cat $1 |  $sed's/(^"(.*)|(.*)"$)/\2\3/g' | sort -u); do
 #echo $site # diagnostics
 if [ ! -f $site.assllabs.html ];then
  echo -e "\t[>] Gathering data from SSLLABS on: $site"
  #echo "wget -i 1 -w 1 -O $site.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on"
  wget -i 1 -w 1 -O $site.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on
 fi
done
for res in $(ls | grep html | sort -u);do 
 #echo $res # diagnostics
 Server=`echo $res | $sed's/((.*)(\.assllabs.html))/\2/g'`
 ipa=`cat $res | strings | tr -d "\t" | grep -E "class=ip" | cut -d "(" -f2 | cut -d ")" -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | cut -d " " -f1`
 sipa=`cat $res| strings | tr -d "\t" | grep -E "class=ip" | cut -d "(" -f2 | cut -d ")" -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | cut -d ">" -f4 | cut -d "<" -f1 | tr -s "\n" "," | $sed"s/,/ and /g" | $sed"s/ and $//g"`
 rsipa=`cat $res| strings | tr -d "\t" | grep -E "class=ip" | cut -d "(" -f2 | cut -d ")" -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | cut -d ">" -f4 | cut -d "<" -f1 | sort -u`
 #echo $ipa # diagnostics
 #echo $spa # diagnostics
 #echo $rsipa # diagnostics
 if [ "$ipa" != "" ];then
  #echo $ipa # diagnostics
  head -n1 < /dev/null
 else
  if [ "$rsipa" != "" ];then
   #echo $rsipa # diagnostics
   for nsite in $rsipa; do
    #echo $nsite # diagnostics
    echo -e "\t[<] Sending $nsite to SSLLABS to be checked ...."
    #echo "wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on"
    wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on
    nappy="Yes"
   done
   ttime=3
   #ttime=$( echo "`echo $rsipa | wc -l` * 30" | bc)
   echo -e "\t\t[!]Sleeping a total time of: $ttime"
   sleep $ttime
   #echo $Server  # diagnostics
   for nsite in $rsipa; do
    if [ ! -f $Server.$nsite.assllabs.html ];then
     #echo "$site.$nsite.assllabs.html "
     echo -e "\t[>] Gathering data from: $Server  node: $nsite"
     #echo "wget -i 1 -w 1 -O $Server.$nsite.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on"
     wget -i 1 -w 1 -O $Server.$nsite.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on
    fi
   done
  fi
 fi   
done
#echo $count # diagnostics
count="0"
#echo $count  # diagnostics
#echo "testme" # diagnostics
for res in $(ls | grep html | sort -u);do 
 #echo $res # diagnostics
 Server=`echo $res | $sed's/((.*)(\.assllabs.html))/\2/g'`
 #echo $Server # diagnostics
 Server=`echo $res | $sed's/((.*)(\.assllabs.html))/\2/g'`
 let count=count+1
 rate=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep rating_ | cut -d ">" -f2  |cut -d"<" -f1`
 #echo $count # diagnostics
 altn=`cat $res | strings | tr -d "\t" | grep -A1 -E "Alternative" | grep Cell | cut -d " " -f3| $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g"`
 #echo $altn # diagnostics
 hostn=$(cat $res | tr -d "\t" | grep -E "class=" | grep -A1 "Server hostname" | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g"| cut -d ">" -f2 | $sed"s/^ (.*)/\1/g"| $sed"s/<(.*)/,,,/g" | tr -d "\n" | $sed"s/([0-9A-Za-z.,]{1,}),,,(.*),,,/ `echo $Server` path origin: \2\n/g" | awk -F " " '{print "[-] "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8}' | $sed"s/((Server )|hostnam)//g")
 #echo $hostn # diagnostics
 sigin=$(cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Server signature" | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | cut -d ">" -f2 | $sed"s/^ (.*)/\1/g"| $sed"s/<(.*)/,,,/g" | tr -d "\n" | $sed"s/([0-9A-Za-z., ]{1,}),,,(.*),,,/ `echo $Server` Identified as: \2\n/g" | awk -F " "  '{print "[-] "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8}' | $sed"s/((Server) |signatur)//g")
 #echo $sigin # diagnostics
 #echo $rate # diagnostics 
 echo -e "\n{$count} - Examining records from `echo $res| $sed's/((.*)\.assllabs\.html)/\2/g'`"
 echo ""
 if [ "$rate" != "" ];then
  echo "[-] $Server is rated at: $rate"
 else
  head -n1 < /dev/null
 fi
 if [ "$hostn" != "" ];then
  echo -e "$hostn"
 else 
  head -n1 < /dev/null
 fi
 if [ "$sigin" != "" ];then
  echo -e "$sigin"
 else 
  head -n1 < /dev/null
 fi
 if [ "$altn" != "" ];then
  if [ "$altn" != "-" ];then
   echo -e "[-] $Server alter name(s): $altn"
 else 
  head -n1 < /dev/null
 fi
 fi
 if [ "$ipa" != "" ];then
  echo "[-] $Server has an IP of: $ipa"
 else
  echo "[-] $Server has an IP of: $sipa"
 fi
 cstr=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Common" | grep Cell | cut -d ">" -f4 | cut -d" " -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g"`
 #echo $cstr # diagnostics
 mstr=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Common" | grep Cell | cut -d ">" -f6 | cut -d"<" -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g"`
 commn=$(echo "$Server common name: $cstr - $mstr") 
 if [ "$mstr" == "MISMATCH" ];then
  echo -e "\t[!] $commn"
 else 
  head -n1 < /dev/null
 fi
 if [ "`cat $res | strings | tr -d "\t" | grep -E "class=" | grep "<font color\=red>Insecure Renegotiation" | cut -d ">" -f3 | cut -d " " -f1`" = "Insecure" ]; then 
  echo -e "\t[!] `echo $Server` has Insecure Renegotiation enabled "
 else 
  head -n1 < /dev/null
 fi
 if  [ "`cat $res | strings | tr -d "\t" | grep -E "font color=red" | cut -d">" -f2 | cut -d" " -f1 | grep BEAST`" = "BEAST" ]; then
  echo -e "\t[!] `echo $Server` is victim to BEAST Attacks"
 else 
  head -n1 < /dev/null
 fi
 CRIME=`cat $res | strings | tr -s "\t" " " | grep CRIME | cut -d">" -f3 | $sed"s/(CRIME)/\1/g" | cut -d" " -f7`
 if [ "$CRIME" == "CRIME" ]; then
  echo -e "\t[!] `echo $Server` is victim to CRIME Attacks"
 else 
  head -n1 < /dev/null
 fi
 ssll=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "SSL 2" | grep Right | cut -d ">" -f2 | cut -d"<" -f1`
 if [ "$ssll" == "Yes N" ]; then
  echo -e "\t[!] `echo $Server` Supports SSLv2, but provides NO ciphers"
 else 
  head -n1 < /dev/null
 fi
 if [ "$ssll" == "Yes" ]; then
  echo -e "\t[!] `echo $Server` Supports SSLv2"
 else 
  head -n1 < /dev/null
 fi
 expire=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep "expires in" | cut -d "(" -f2 | cut -d ")" -f1 | awk -F " " '{print "[-] Servers certification expiration in: { "$3" "$4" - "$6" "$7" }" }'` | $sed"s/Server/`echo $Server`/g"
 if [ "$expire" != "" ];then
  echo $expire
 else 
  head -n1 < /dev/null
 fi
 pci=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "PCI compliant" | grep Cell | cut -d " " -f3`
 if [ "$pci" != "" ];then
  if [ "$pci" != "Yes" ]; then 
   echo -e "\t[!] $Server is NOT compliant to PCI"
  else 
   head -n1 < /dev/null
  fi
 else 
  head -n1 < /dev/null
 fi
 echo ""
 cat $res | strings | grep "class=" | grep -B1 Cell | tr -d "\t" | grep Cell | cut -d">" -f2 | cut -d "<" -f1 | $sed"s/(.*)/\1,/g" | tr -d "\n" | $sed"s/(.*),/\1\n/g" | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | $sed"s/\&\#58\;/:/g" |  $sed"s/\&nbsp\;//g" | $sed"s/,(.*)/`echo $count`,`echo $ipa`,\1/g" >> assllabs.csv
 # echo -e "\t[*] Finished $res\n\n" # diagnostics
done | $sed"s/\[(.*)\] (.*)/\t\[\1\] \2/g"

echo -e "\nYEAH! It's  Mathmagical..\n"

