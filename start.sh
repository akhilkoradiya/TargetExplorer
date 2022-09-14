#!/bin/bash  

read -p "
████████╗ █████╗ ██████╗  ██████╗ ███████╗████████╗    ███████╗██╗  ██╗██████╗ ██╗      ██████╗ ██████╗ ███████╗██████╗ 
╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝    ██╔════╝╚██╗██╔╝██╔══██╗██║     ██╔═══██╗██╔══██╗██╔════╝██╔══██╗
   ██║   ███████║██████╔╝██║  ███╗█████╗     ██║       █████╗   ╚███╔╝ ██████╔╝██║     ██║   ██║██████╔╝█████╗  ██████╔╝
   ██║   ██╔══██║██╔══██╗██║   ██║██╔══╝     ██║       ██╔══╝   ██╔██╗ ██╔═══╝ ██║     ██║   ██║██╔══██╗██╔══╝  ██╔══██╗
   ██║   ██║  ██║██║  ██║╚██████╔╝███████╗   ██║       ███████╗██╔╝ ██╗██║     ███████╗╚██████╔╝██║  ██║███████╗██║  ██║
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝       ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                                                                                                                        

Enter the URL without http and https: " URL

mkdir ./Output/$URL

subfinder -d $URL -t 200 -v -o ./Output/$URL/subfinder.txt
amass enum  -ip -brute -d $URL -o ./Output/$URL/amass.txt
bash ./.Script/crt.sh $URL > ./Output/$URL/crt_sh.txt
sort ./Output/$URL/subfinder.txt ./Output/$URL/amass.txt ./Output/$URL/crt_sh.txt | uniq -u > ./Output/$URL/subdomain.txt
cat ./Output/$URL/subdomain.txt | httpx -threads 300 | tee -a ./Output/$URL/subdomain_with_http.txt
