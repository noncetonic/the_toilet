for t in $(cat webdavtargets); do /opt/framework/msf3/msfcli auxiliary/scanner/http/webdav_scanner RHOSTS=$t RPORT=443 THREADS=30 E 2> /dev/null | grep WebDAV; done
