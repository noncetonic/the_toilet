# SubINacls - Accuvant Labs 2013 
# makes dir named nmap and stores all script related tutorials in said director
# iterates over the files and then produces a txt file designated by $1 from command line
#
# cmd example : bash -e ./nse_downloader.sh output.txt
# its that simple 
#
# Feb 3, 2013

echo -e "\n\t[*] Downloading like a boss\n"

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
done > ../$1

