#
#
# the lonely `sed -r "s/(st((o)n(er))/c\3d\4/g"` seems to free his mind @ night @@@NIGHT
#


listed = ["JUNK / HTTP/1.0", "JUNK / HTTP/1.1", "JUNK / HTTP/2.0", "JUNK / HTTP/3.0"
]

echo ""
for x in $(cat ./httsponly); do 
 for words in $listed; do 
  echo $words| ncat --ssl  -w 1 $x 443 -i 1 2> /dev/null |\ 
  grep -E "^HTTP(.*)OK" | \
  sed -r "s/(.*)/`echo $x` - \1/"g
 done
done
echo ""
