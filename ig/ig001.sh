if [ -z $1 ]; then
	echo -e "\n\t[-] Robots txt file testing... OWASP IG001"
	echo -e "\t[-] Takes Input as: IP_ADDRESS:PORT ie: 1.2.3.4:56"
	echo -e "\t[-] Include -ssl to enable https ie: ./ig001.sh 1.2.3.4:56 -ssl\n"
fi

if [ ! -d ./ig001 ];then
	mkdir ig001
fi

if [ -z $2 ]; then
	wget -S -t 1 -T 3 --max-redirect 5 http://$1/robots.txt -o ig001/$1.http_robots.txt -O ig001/$1.http_robots.txt
else
	wget -S -t 1 -T 3 --no-check-certificate --max-redirect 5 https://$1/robots.txt -o ig001/$1.https_robots.txt -O ig001/$1.https_robots.txt

fi


