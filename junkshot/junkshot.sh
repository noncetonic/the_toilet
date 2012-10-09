#
# Junkshot - Sends bad request to server to test for verb tampering
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=#
#
# echo -e "the lonely stoner seems to free his mind at night" |\
# sed -r "s/(st(o)n(er)(.*)(at )(.*))/c\2d\3\4@\6 @@@\6/g"
#
# Use your own list of https web targets and it will test some vaerbs for http protocol to include junk
# Which will reply to verbs which have no meaning in the protocol which could indicate verb tampering
#

if [ -z $1 ];then
 echo -e "[*] Basic instruction would be to include a file of https targets on $var1"
fi

if [ ! -f verbage.txt ]; then # edit me to include more methods to test against
 cat << EOF > verbage.txt 
GET / HTTP/1.0     # should work fine
JUNK / HTTP/1.0    # should break something, but will return true on some web server
JUNK / HTTP/1.1    # ""
JUNK / HTTP/3.0    # ""
HEAD / HTTP/1.0    # should work fine
HEAD / HTTP/1.1    # should work fine
HEAD / HTTP/2.0    # potential to pass as true
HEAD / HTTP/3.0    # should break something
OPTIONS / HTTP/1.0 # should work fine
EOF
fi

echo ""
for x in $(cat ./httpsonly); do 
 echo -e $x # diagnostics
 for verbs in $(cat verbage.txt); do 
  echo -e $verbs # diagnostics
  request=$(echo -e `echo $verbs | tr -s "\n" "," | sed -r "s/((.*)\.[0-9]),/\1\n/g" | tr -s "," " "` | ncat --ssl  -w 1 $x 443 -i 1 &)
 case 
# BROKEN FOR NOW - MORE TO COME  
#  sed -r "s/(.*)/"`echo $x && echo  && echo $verbs`" - \1/g" & 
# fix it rather then bitch about it ...
 done
done
echo ""

# Use your own list of https web targets and it will test some verbs for http protocol 
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
