for t in $(cat $1);do 
 echo -e "HEAD / HTTP/1.0\n\n\n"  | ncat -i 1 --ssl $1 443 2> /dev/null | grep -i -E "(Content-Loc)" | xargs echo $1 - | grep -E -v "(((([0-9]){1,3}\.){3}[0-9]{1,3}))$"
done
