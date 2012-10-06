if [ -z $1 ]; then
	echo "supply a directory to parse for IG001 results"

else
	if [ ! -d ./$1 ]; then
		echo -e "\n\t[-] Directory does not exist, exiting due to failure\n\n"
		exit
	else
		cd $1
		echo -e "\n\t[-] Entered directory, parsing contents now ...\n\n"
		for x in $(ls -asl ./ | grep -E "http(s|)\_robots" | tr -s " \t" | cut -d" " -f9);do echo $x >> ./robots_contents.txt && cat $x | grep -i -E "((disa|a)llow)" | sort -u >> ./robots_contents.txt;done
	fi
	echo -e "\n\n\t[-] Finished parsing the directories contents...\n\n"
fi
