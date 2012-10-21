#!/bin/bash
low_count=0
max_count=$(cat $1 | wc -l)
echo $max_count # diagnostics
while :; do
 for x in $(cat $1); do 
  if [[ "$low_count" -ne "$max_count" ]]; then
   sleep 0.02
   echo -e "\n\nTHE CALL IS: $x\n\n" && echo -e "GET $x\r\n\r\n\r\n\r\n" | ncat -i 1 -w 1 $4 $2 $3 &
   echo -e "\n"
   low_count=$((low_count + 1))
  else
   break
  fi
 done
done
