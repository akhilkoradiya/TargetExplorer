#!/bin/bash  

read -p "Enter the URL without http and https: " URL

mkdir ./Output/$URL

subfinder -d $URL -t 200 -v -o ./Output/$URL/allsub.txt
amass enum  -ip -brute -d $URL -o ./Output/$URL/allsub1.txt
bash ./.Script/crt.sh $URL > ./Output/$URL/allsub2.txt
sort ./Output/$URL/allsub.txt ./Output/$URL/allsub1.txt ./Output/$URL/allsub2.txt | uniq -u > ./Output/$URL/finalsubdomain.txt
cat ./Output/$URL/finalsubdomain.txt | httpx -threads 300 | tee -a ./Output/$URL/subdomain.txt
cat ./Output/$URL/subdomain.txt | waybackurls | tee -a ./Output/$URL/waybackurls.txt
