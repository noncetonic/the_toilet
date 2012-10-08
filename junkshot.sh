echo ""; for x in $(cat ./httsponly); do echo -e "GET / JUNK/1.1\n\n\n" | ncat --ssl  -w 1 $x 443 -i 1 2> /dev/null| grep -E "^HTTP(.*)OK" | sed -r "s/(.*)/`echo $x` - \1/"g; done; echo ""
