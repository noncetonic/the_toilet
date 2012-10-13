#!/usr/bin/env python

import sys
from IPy import IP

	
network = IP(sys.argv[1])

for ip in network:
 print str(ip)+'\n',

#print '[*] Broadcast Address:\t' + str(network.broadcast()) + '\n',
#for rn in network:
# print ' [*] Reverse Name:\t' + str(rn.reverseNames()) + '\n',
