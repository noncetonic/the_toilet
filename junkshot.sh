#

# Use your own list of https web targets and it will test some verbs for http protocol to include junk
# Which will reply to verbs which have no meaning in the protocol which could indicate verb tampering
#
#
#



if [ ! -f verbage.txt ]; then
 cat << EOF > verbage.txt 
GET / HTTP/1.0
JUNK / HTTP/1.0
JUNK / HTTP/1.1
JUNK / HTTP/3.0
HEAD / HTTP/1.0
HEAD / HTTP/1.1
HEAD / HTTP/2.0
HEAD / HTTP/3.0
OPTIONS / HTTP/1.0
EOF
fi
echo ""
for x in $(cat ./httpsonly); do 
 #echo $x
 for verbs in $(cat verbage.txt); do 
  #echo -e $verbs
  request=$(echo -e `echo $verbs | tr -s "\n" "," | sed -r "s/((.*)\.[0-9]),/\1\n/g" | tr -s "," " "` | ncat --ssl  -w 1 $x 443 -i 1 &)
 case 

  #|  sed -r "s/(.*)/"`echo $x && echo  && echo $verbs`" - \1/g" & 
 done
done
echo ""
