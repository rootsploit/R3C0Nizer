#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/reconizer/ ]
then
  echo " "
else
  mkdir ~/reconizer
fi

if [ -d ~/reconizer/$DOM/nuclei ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/nuclei
fi


echo "${red}
 =================================================
|   ____  _____  ____ ___  _   _ _                |
|  |  _ \|___ / / ___/ _ \| \ | (_)_______ _ __   |
|  | |_) | |_ \| |  | | | |  \| | |_  / _ \ '__|  |
|  |  _ < ___) | |__| |_| | |\  | |/ /  __/ |     |
|  |_| \_\____/ \____\___/|_| \_|_/___\___|_|     |
|                                                 |
 ================== Anon-Artist ==================
${reset}"
echo "${blue} [+] Started Nuclei Vulnerability Scanning ${reset}"
echo " "

#nuclei
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/reconizer/$DOM/nuclei/cves_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/reconizer/$DOM/nuclei/files_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/reconizer/$DOM/nuclei/vulnerabilities_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/security-misconfiguration/ -c 200 -o ~/reconizer/$DOM/nuclei/sec-misconf_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/default-credentials/ -c 200 -o ~/reconizer/$DOM/nuclei/default-creds_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/reconizer/$DOM/nuclei/cves_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/reconizer/$DOM/nuclei/files_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/reconizer/$DOM/nuclei/vulnerabilities_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/security-misconfiguration/ -c 200 -o ~/reconizer/$DOM/nuclei/sec-misconf_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/default-credentials/ -c 200 -o ~/reconizer/$DOM/nuclei/default-creds_results.txt
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
