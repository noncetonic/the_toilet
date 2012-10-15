 #!/bin/bash/

ext_array=( js asp html htm jsp txt )
page_call=( robots_drilled_my_brain )
http_ver=( 0\.0 0\.1 1\.2 1\.1 1\.0 2\.0 3\.0 )
t_ip="google.com"
t_port=443
# echo ${ext_array[@]} # diagnostics
# echo ${page_call[@]} # diagnostics
# echo ${http_ver[@]} # diagnostics
while true; do
 for ext in "${ext_array[@]}"; do
  # echo $ext # diagnostics
  echo -e "\n[+] Testing extension: $ext\n\n"
  for page in "${page_call[@]}"; do
   # echo $page # diagnostics
   echo -e "\n[+] Testing page: $page\n\n"
   for ver in "${http_ver[@]}"; do
    # echo $ver # diagnostics
    echo -e "\n[+] Testing HTTPver: $ver\n"
    echo -e "GET /$page.$ext HTTP/$ver\n\n\n" | ncat -i 2 -w 2 --ssl $t_ip $t_port 2> /dev/null &
    echo -e "\n\n"
   done
  done
 done
done

