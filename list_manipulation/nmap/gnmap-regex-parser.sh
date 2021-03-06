#
# Written by William SubINacls Coppola
#  Enables user to remove items from greabable files using regex from the commandline
#   example usage: read the code below ...
#  
#	bash -e grep_parse.sh ./testfile.gnmap | tee -a w00t	# this is with out any filtering of IP Addresses
#	bash -e grep_parse.sh ./testfile.gnmap "" | tee -a w00t	# this is with out any filtering of IP Addresses
#	bash -e grep_parse.sh ./testfile.gnmap "(([0-9]{1,3}\.)76 ) " | tee -a w00t
#	({[?]}) removes any IP matching "76" on the last octet, displays information to STDOUT and into w00t ;)
#
#   Your milage may vary - like it or hate it, it simply works
#

if [ -z $1 ]; then
	echo -e "\n[*] - { Read the source luke... }"
	echo -e "[*] - example: ./grep_parse.sh ./test.gnamp '(([0-9]{1,3}\.)76) \(\))' | tee -a w00t"
	echo -e "[*]\t > removes any IP matching .76 at the end of it, echos remaining info into w00t file\n"
	exit
fi

if [ -z $2 ]; then
	cat $1 | grep Ports | tr -s "," "\n" 

	if [ $2 != "" ]; then
		 cat $1 | grep Ports | grep -v -E "$2" | tr -s "," "\n"
	fi
fi
