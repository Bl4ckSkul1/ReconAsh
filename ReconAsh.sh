#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

var=$1

#Reconocimiento

function port(){

$(nmap  -n -Pn  --open  -sS -min-rate 5000 -T5 -p- $var  -oA  nmap/$var+portall.txt) 2>/dev/null

echo -e "${blueColour}[*]${endColour}Sugerencia: de Enumeracion [ nmap  -sV -sC  -sS -min-rate 5000 -T5 -p puertos  -vvvv | tee nmapinfo.txt]{endColour}"


}

function banner() {
echo ""
echo ""
echo -e "${greenColour}██████╗ ███████╗ ██████╗ ██████╗ ███╗   ██╗${endColour}"
echo -e "${greenColour}██╔══██╗██╔════╝██╔════╝██╔═══██╗████╗  ██║${endColour}"
echo -e "${greenColour}██████╔╝█████╗  ██║     ██║   ██║██╔██╗ ██║${endColour}"
echo -e "${greenColour}██╔══██╗██╔══╝  ██║     ██║   ██║██║╚██╗██║${endColour}"
echo -e "${greenColour}██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║${endColour}"
echo -e "${greenColour}╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝${endColour}"
echo -e "${greenColour}╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝${endColour}"
echo -e "${greenColour} Echo por Bl4ckSkull${endColour}"

}

if [ $1 == ""] 2>/dev/null
then
banner
echo ""
echo ""
echo -e "${redColour}[X]${endColour}Fatal error:  Ingresa una ip o dominio "
echo -e "${greenColour}[i]${endColour} Ingresa  una ip"
echo -e "${greenColour}[i]${endColour} Formato : Recon.sh IP"

else 

banner

echo -e "${blueColour}[ El proceso demorara un buen rato]${endColour} "
echo -e "${greenColour}[*]${endColour} Ve por un cafe o checa otra etapa"
echo -e "${greenColour}[*]${endColour} Gracias por usar ReconAsh"
echo ""
mkdir {nmap,Wfuzz,Subdomain}
echo -e "${yellowColour}[i]${endColour} ${greenColour}Iniciando Escaneo de Puertos ${endColour}"
port
echo -e "${yellowColour}[i]${endColour} ${greenColour}Iniciando Fuzz ${endColour}"

$(wfuzz -f Wfuzz/$var.raw,raw -c --hc=404 -z file,/usr/share/wordlists/wfuzz/general/common.txt http://$var/FUZZ) 2>/dev/null
echo -e "${yellowColour}[i]${endColour} ${greenColour}Buscando Subdominios con assetfinder ${endColour}"
$(assetfinder -subs-only $var|httprobe > Subdomain/subdoman.txt) 2>/dev/null
echo -e "${yellowColour}[i]${endColour} ${greenColour}Comprobando con httprobe ${endColour}"

echo -e "${yellowColour}[i]${endColour} ${greenColour}Comprobando con httprobe ${endColour}"
echo -e "${greenColour}[OK]${endColour}"
echo -e "${yellowColour}[i]${endColour} ${greenColour}Iniciando Sublist3r ${endColour}"
$(sublist3r -d $var -o Subdomain/sublist3rSubdomain.txt) 2>/dev/null

echo -e "${greenColour}[OK]${endColour}"
fi




