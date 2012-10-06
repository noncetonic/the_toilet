# makes files in folder named cm001 which represents cm001 from owasp
# expects targets to be in this format:
#		ipaddress:portnumber
# feed it a file from the commandline
# ex:
#	./cm001.sh target.lst
#

if [ ! -d ./cm001 ]; then

	mkdir ./cm001
fi

for x in $(cat $1); do sslscan --no-failed $x > ./cm001/OWASP-CM-001_$x.txt; done &

