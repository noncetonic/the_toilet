PS3=`echo -e "\n\t[+] Please enter your choice: \n"`
options=("Download_all" "Categories" "Libraries" "Quit")
echo -e "\n[*] Choose downloading options by numerical representation below\n"
select opt in "${options[@]}"
do
 case $opt in
  "Download_all")
   echo -e "\n[*] Downloading like a Boss\n"
   mkdir nmap
   cd nmap
   wget -q http://nmap.org/nsedoc/ 2>&1 /dev/null
   for x in $(cat index.html | grep '<td class\=\"name\"><a href\=\"' | sed -r 's/<td class\=\"name\"><a href\=\"//g' | cut -d '"' -f1 | tr -d "\t" | grep scripts | sed -r "s/(.*)/http\:\/\/nmap\.org\/nsedoc\/\1/"); do 
    wget -q $x 2>&1 /dev/null
   done
   for x in $(ls); do
    f=`echo $x | cut -d "." -f1`
    echo -e "\n-----------------------------------------------------\n"
    echo -e "\n[*] Script Name: $f\n"
    awk -vRS="</pre>" '/<pre>/{gsub(/.*<pre>/,"");print}' $x | sed -r "s/^(nmap(.*))$/\1\n/g" | sed -r "s/\&lt\;/</g" | sed -r "s/\&gt\;/>/g" &
   done > $1
   echo "1) Download_all"
   echo "2) Categories"
   echo "3) Libraries"
   echo "4) Quit"
   ;;
  "Categories")
   echo " "
   PS3=`echo -e "\n\t[+] Please enter your choice: \n"`
   options=("auth" "broadcast" "brute_force" "default" "discover" "dos" "exploit" "external" "fuzzer" "intrusive" "malware" "safe" "version" "vuln" "menu" "Quit")
   select opt in "${options[@]}"
   do
       case $opt in
           "auth")
               echo -e "\n[*] Downloading the auth category like a Boss\n"
               ;;
           "broadcast")
               echo -e "\n[*] Downloading the broadcast category like a Boss\n"
               ;;
           "brute_force")
               echo -e "\n[*] Downloading the brute_force category like a Boss\n"
               ;;
           "default")
               echo -e "\n[*] Downloading the default category like a Boss\n"
               ;;
           "discover")
               echo -e "\n[*] Downloading the discover category like a Boss\n"
               ;;
           "dos")
               echo -e "\n[*] Downloading the dos category like a Boss\n"
               ;;
           "exploit")
               echo -e "\n[*] Downloading the exploit category like a Boss\n"
               ;;
           "fuzzer")
               echo -e "\n[*] Downloading the fuzzer category like a Boss\n"
               ;;
           "intrusive")
               echo -e "\n[*] Downloading the intrusive category like a Boss\n"
               ;;
           "malware")
               echo -e "\n[*] Downloading the malware category like a Boss\n"
               ;;
           "safe")
               echo -e "\n[*] Downloading the safe category like a Boss\n"
               ;;
           "version")
               echo -e "\n[*] Downloading the version category like a Boss\n"
               ;;
           "vuln")
               echo -e "\n[*] Downloading the vuln category like a Boss\n"
               ;;
           "menu")
               echo -e "\n1) Download_all"
               echo "2) Categories"
               echo "3) Libraries"
               echo -e "4) Quit"
               break
               ;;
           "Quit")
               echo -e "\n[*] Quiting like a Boss\n"
               exit
               ;;
           *) echo invalid option;;
       esac
       echo "1) Download_all"
       echo "2) Categories"
       echo "3) Libraries"
       echo -e "4) Quit"
   done
   ;;
  "Libraries")
   echo -e "\n[*] Downloading the Libraries like a Boss\n"
   ;;
  "Quit")
   echo " "
   break
   ;;
  *) echo invalid option;;
 esac
done
