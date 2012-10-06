if [ ! -d ./cm001 ]; then

	mkdir ./cm001
fi

for x in $(cat $1); do sslscan --no-failed $x > ./cm001/OWASP-CM-001_$x.txt; done &

