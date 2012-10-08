ntpdate -du ntp.fsu.edu 123 2> /dev/null | grep -E "(Server dropped\: no data$|receive\(([0-9]{1,3}\.){3}[0-9]{1,3}\)$)" | sort -u

