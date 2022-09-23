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
cd ./Output/$URL && mkdir xss && cd ../.. 
subfinder -d $URL -t 200 -v -o ./Output/$URL/allsub.txt
amass enum  -ip -brute -d $URL -o ./Output/$URL/allsub1.txt
bash ./.Script/crt.sh $URL > ./Output/$URL/allsub2.txt
sort ./Output/$URL/allsub.txt ./Output/$URL/allsub1.txt ./Output/$URL/allsub2.txt | uniq -u > ./Output/$URL/finalsubdomain.txt
httpx-toolkit -l  ./Output/$URL/finalsubdomain.txt | tee -a ./Output/$URL/subdomain.txt
cat ./Output/$URL/subdomain.txt | waybackurls | tee -a ./Output/$URL/waybackurls.txt
cat ./Output/$URL/waybackurls.txt | gf xss | sed 's/=.*/=/' | sed 's/URL: //' | sort -u | tee -a ./Output/$URL/xss/output.txt
