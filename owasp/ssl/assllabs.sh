#!/bin/bash
#
# (;,.Got tired of checking websites ssl certs by hand and made a tool.,;)
#
test=`uname`
#echo $test # diagnostics
if [ "$test" == "Darwin" ];then
 sed="sed -E "
else
 sed="sed -r "
fi

if [ -z $1 ]; then
 echo -e "\n:-> System Error ID: 10T \"Alert\"\n\n\t:-> End User variable not supplied %%\n\n\n[-] Welcome to the help menu, you ... guy .. you ...\n\n\t\t [*] Issues request to SSLLABS to check supplied domains for faults.\n\t\t [*] One domain per line in this format: {sub-domain}{domain}{tld}\n\t\t [*] Will make files inside the directory where run.\n\t\t [*] File: assllabs.csv will be overwritten if not archived\n\n     [!] Example: bash -e $0 ./your-dnsnames.txt\n"
 exit 0
fi
echo -e "\n[+] assllabs.sh - get your validation on like an 'ass'essor..."
echo -e "[+] Written by: William SubINacls Coppola"
echo -e "[+] Reason: Simply because I hate reports\n"
echo "" > assllabs.csv
echo "Tracking number,IP,Commonnames,Alternativenames,Prefixhandling,Validfrom,Validuntil,Key,Signaturealgorithm,ServerGatedCryptography,Weakkey(Debian),Issuer,NextIssuer,NextIssuer,Chainlength(size),Chainissues,ExtendedValidation,Revocationinformation,Revocationstatus,Trusted,,InsecureRenegotiation,,Compression,NextProtocolNegotiation,Sessionresumption,Sessiontickets,OCSPstapling,StrictTransportSecurity,RequiresclientRIsupport,Longhandshakeintolerance,TLSextensionintolerance,TLSversionintolerance,Testdate,Testduration,Serversignature,Serverhostname,PCIcompliant,FIPS-ready" >> assllabs.csv
for site in $(cat $1 | $sed's/(^"(.*)|(.*)"$)/\2\3/g' | sort -u); do
 #echo $site # diagnostics
 if [ ! -f $site.assllabs.html ];then
  nappy="Yes"
  echo -e "\t[<] Sending $site to SSLLABS to be checked from cache...."
  if [ "$test" != "Darwin" ];then
   #echo "wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on "
   wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on 
  else
   curl -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on 2>/dev/null
  fi
 fi
 #echo $nappy #diagnostics
done
#echo $Server  # diagnostics
if [ "$nappy" == "Yes"  ];then 
 #ntime=$( echo "`cat $ntime\.tmp\.tmp | wc -l` * 10 " | bc)
 ntime=150
 echo -e "\t\t[!] Sleeping a total time of: $ntime"
 sleep $ntime
 #echo $Server  # diagnostics
fi
head -n1 < /dev/null
for site in $(cat $1 |  $sed's/(^"(.*)|(.*)"$)/\2\3/g' | sort -u); do
 #echo $site # diagnostics
 if [ ! -f $site.assllabs.html ];then
 echo -e "\t[>] Gathering data from SSLLABS on: $site"
  if [ "$test" != "Darwin" ];then
   #echo "wget -i 1 -w 1 -O $site.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on "
   wget -i 1 -w 1 -O $site.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on 
  else
   curl -o $site.assllabs.html https://www.ssllabs.com/ssltest/analyze.html?d\=$site\&ignoreMismatch\=on 2>/dev/null 
  fi
 else
  continue
 fi
 sone=0
done

#
# start the download of IP addresses associated to domain 
#

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
  # echo $ipa # diagnostics
  head -n1 < /dev/null
 else
  if [ "$rsipa" != "" ];then
   nappy="Yes"
   #echo $rsipa # diagnostics
   echo $nsite > $ntime.tmp.tmp
   for nsite in $rsipa; do
    #echo $nsite # diagnostics
    echo -e "\t[<] Sending $nsite to SSLLABS to be checked ...."
    if [ "$test" != "Darwin" ];then
     #echo "wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on"
     wget -i 1 -w 1 -O /dev/null -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on
    else
     curl-o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on 2>/dev/null
    fi
    echo $nsite >> $ntime.tmp.tmp
   done
   #ntime=3
  fi
 fi
 let sone=sone+1
 if [ "$sone" == "1" ];then
  if [ "$nappy" == "Yes"  ];then 
   #ntime=$( echo "`cat $ntime\.tmp\.tmp | wc -l` * 10 " | bc)
   ntime=150
   echo -e "\t\t[!] Sleeping a total time of: $ntime"
   sleep $ntime
   #echo $Server  # diagnostics
  fi
 fi
done
for nsite in $rsipa; do
  if [ ! -f $Server.$nsite.assllabs.html ];then
  #echo "$site.$nsite.assllabs.html "
 if [ "$test" != "Darwin" ];then
  echo -e "\t[>] Gathering data from: $Server  node: $nsite"
   #echo "wget -i 1 -w 1 -O $Server.$nsite.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on"
   wget -i 1 -w 1 -O $Server.$nsite.assllabs.html -o /dev/null https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on
  else
   curl -o $Server.$nsite.assllabs.html https://www.ssllabs.com/ssltest/analyze.html?d\=$Server\&s\=$nsite\&ignoreMismatch\=on  2>/dev/null
  fi
 fi
done

 #echo $count # diagnostics
 count="0"
 #echo $count  # diagnostics
 #echo "testme" # diagnostics
for res in $(ls | grep html | sort -u);do 
 #echo $res # diagnostics
 ipa=`cat $res | strings | tr -d "\t" | grep -E "class=ip" | cut -d "(" -f2 | cut -d ")" -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | cut -d " " -f1` 
 Server=$(echo $res | $sed's/((.*)(\.(([0-9]{1,3}\.){3}([0-9]{1,3})|assllabs.html)))/\2/g' | $sed"s/((.*)(\.([0-9]{1,3}\.){3}([0-9]{1,3})))/\2/g")
 #echo $Server # diagnostics
 rserver=`echo $res | $sed's/((.*)\.(([0-9]{1,3}\.){3}([0-9]{1,3}))\.(.*))/\3/g'| grep -v -E "([0-9]{1,3}\.){3}\.([0-9])"`
 let count=count+1
 rate=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep rating_ | cut -d ">" -f2  |cut -d"<" -f1`
 #echo $count # diagnostics
 altn=`cat $res | strings | tr -d "\t" | grep -A1 -E "Alternative" | grep Cell | cut -d " " -f3| $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g"`
 #echo $altn # diagnostics
 hostn=$(cat $res | tr -d "\t" | grep -E "class=" | grep -A1 "Server hostname" | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g"| cut -d ">" -f2 | $sed"s/^ (.*)/\1/g"| $sed"s/<(.*)/,,,/g" | tr -d "\n" | $sed"s/([0-9A-Za-z.,]{1,}),,,(.*),,,/ `echo $Server` path origin: \2\n/g" | awk -F " " '{print "[-] "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8}' | $sed"s/((Server )|hostnam)//g")
 #echo $hostn # diagnostics
 sigin=$(cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Server signature" | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | cut -d ">" -f2 | $sed"s/^ (.*)/\1/g"| $sed"s/<(.*)/,,,/g" | tr -d "\n" | $sed"s/([0-9A-Za-z., ]{1,}),,,(.*),,,/ `echo $Server` Identified as: \2\n/g" | awk -F " "  '{print "[-] "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8}' | $sed"s/((Server) |signatur)//g")
 ipa=`cat $res | strings | tr -d "\t" | grep -E "class=ip" | cut -d "(" -f2 | cut -d ")" -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | cut -d " " -f1`


 afail=$(cat $res | tr -s " " | $sed"s/( (.*))/\2/g"| grep "Assessment failed\:" | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g" | $sed"s/\&\#58;( ,(\&lt\;\&\#33\;[a-zA-Z]))//g" | $sed"s/ ,/ /g" | $sed"s/(.*)/ `echo "$Server"` : `echo "$nsite"` \1/g")


 sesres=`cat $res | tr -s " " | $sed"s/( (.*))/\2/g"| grep -A1 "Session resumption" | grep red | tr -d "\t" | $sed"s/((.*)red\>(.*)\>(.*))/\3/g" | $sed"s/(>|<(\/|)[a-zA-Z]{1,}(|>))//g" | tr -s "\n" "^" | $sed"s/\^/ - /g" | cut -d"-" -f-2;`
 
 #echo $sigin # diagnostics
 #echo $rate # diagnostics

 if [ "$afail" != "" ];then
  echo -e "\t{$count} - ERROR:\t`echo $afail`"
  continue
 fi

 if [ "$rserver" == "" ];then
  echo -e "\n{$count} - Examining records from $Server"
 else
  echo -e "\n{$count} - Examining records from $Server node $ipa"
 fi
 if [ "$rate" != "" ];then
  echo "[-] $Server is rated at: $rate"
 else
  head -n1 < /dev/null
 fi
 expire=$(cat $res | strings | tr -d "\t" | grep -E "class=" | grep "expires in" | cut -d "(" -f2 | cut -d ")" -f1 | awk -F " " '{print "[-] Servers certification expiration in: { "$3" "$4" - "$6" "$7" }" }' | $sed"s/Server/`echo $Server`/g")
 if [ "$expire" != "" ];then
  echo $expire
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
  fi
 else 
  head -n1 < /dev/null
 fi
 #echo $rserver
 #echo $Server
 if [ "`echo $rserver | $sed's/(.*)\.assllabs\.html/\1/g'`" != "" ];then
  if [ "`echo $rserver | $sed's/(.*)\.assllabs\.html/\1/g'`" != " " ];then
    if [ "`echo $rserver | $sed's/(.*)\.assllabs\.html/\1/g'`" != "$Server" ];then
   #echo "[-] $Server has an Dns of: $rserver"
    echo "[-] $Server has an IP of: $ipa"
   fi
  fi
 fi
 cstr=$(cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Common" | grep Cell | cut -d ">" -f4 | cut -d" " -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g")
 #echo $cstr # diagnostics
 mstr=`cat $res | strings | tr -d "\t" | grep -E "class=" | grep -A1 "Common" | grep Cell | cut -d ">" -f6 | cut -d"<" -f1 | $sed"s/(\&\#45\;)/-/g"| $sed"s/(\&\#47\;)/\//g"| $sed"s/\&\#46\;/./g" | $sed"s/\&\#42\;/*/g" | $sed"s/\&\#32\;/ ,/g" | $sed"s/\&\#40\;/(/g" | $sed"s/\&\#41\;/)/g" | $sed"s/\&\#90\;/_/g" | $sed"s/\&\#43\;/+/g"`
 commn=$(echo "$Server common name: $cstr - $mstr") 
 if [ "$mstr" == "MISMATCH" ];then
  echo -e "\t[!] $commn"
 else 
  head -n1 < /dev/null
 fi
 if [ "`cat $res | strings | tr -d "\t" | grep -E "class=" | grep "<font color\=red>Insecure Renegotiation" | cut -d ">" -f3 | cut -d " " -f1`" == "Insecure" ]; then 
  echo -e "\t[!] `echo $Server` supports Insecure Renegotiation - MITM Vulnerable "
 else 
  head -n1 < /dev/null
 fi
 if [ "`cat $res | strings | tr -d "\t" | grep "This server is easier to attack via DoS "| cut -d ">" -f3  | cut -d" " -f1`" == "This" ]; then 
  echo -e "\t[!] `echo $Server` supports Client-Initiated Renegotiation - DoS Vulnerable "
 else 
  head -n1 < /dev/null
 fi

 if [ "$sesres" != "" ]; then 
  echo -e "\t[!] `echo $Server` supports $sesres "
 else 
  head -n1 < /dev/null
 fi

 if  [ "`cat $res | strings | tr -d "\t" | grep -E "font color=red" | cut -d">" -f2 | cut -d" " -f1 | grep BEAST`" == "BEAST" ]; then
  echo -e "\t[!] `echo $Server` is vulnerable to BEAST Attacks"
 else 
  head -n1 < /dev/null
 fi
 CRIME=`cat $res | strings | tr -s "\t" " " | grep CRIME | cut -d">" -f3 | $sed"s/(CRIME)/\1/g" | cut -d" " -f7`
 if [ "$CRIME" == "CRIME" ]; then
  echo -e "\t[!] `echo $Server` is vulnerable to CRIME Attacks"
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

done | $sed"s/\[(.*)\] (.*)/\t\[\1\] \2/g"


echo -e "\nYEAH! It's  Mathmagical..\n"

