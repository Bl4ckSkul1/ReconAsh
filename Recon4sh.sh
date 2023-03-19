#!/bin/sh
echo " ██▀███  ▓█████  ▄████▄   ▒█████   ███▄    █  ▄▄▄        ██████  ██░ ██ "
echo "▓██ ▒ ██▒▓█   ▀ ▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █ ▒████▄    ▒██    ▒ ▓██░ ██▒"
echo "▓██ ░▄█ ▒▒███   ▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░"
echo "▒██▀▀█▄  ▒▓█  ▄ ▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒░██▄▄▄▄██   ▒   ██▒░▓█ ░██ "
echo "░██▓ ▒██▒░▒████▒▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓"
echo "░ ▒▓ ░▒▓░░░ ▒░ ░░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒"
echo "  ░▒ ░ ▒░ ░ ░  ░  ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░"
echo "  ░░   ░    ░   ░        ░ ░ ░ ▒     ░   ░ ░   ░   ▒   ░  ░  ░   ░  ░░ ░"
echo "   ░        ░  ░░ ░          ░ ░           ░       ░  ░      ░   ░  ░  ░"
echo "                                      by Adrian Martinez(Blackskull)   "


echo "Ingrese un dominio:"
read -r -p "> " dominio

if [ -z "$dominio" ]; then
  echo "¡Debe ingresar un dominio válido!"
  exit 1
fi

echo "Espera un momento, estoy trabajando en brindarte los mejores resultados..."

# Ejecuta el comando "assetfinder" con el dominio ingresado, muestra una barra de progreso y guarda la salida en un archivo "assetfinder.txt"
assetfinder "$dominio" | pv -p -t -e -r -a -b | sort -u > subdominios.txt

# Usa "httprobe" para procesar los resultados de "assetfinder" y guardarlos en un archivo "httprobe.txt"
cat assetfinder.txt | httprobe | sort -u > http_services.txt

# Usa "hakrawler" para procesar los resultados de "httprobe" y guardarlos en un archivo "hakrawler.txt"
cat httprobe.txt | hakrawler | sort -u > crawler.txt

# Ejecuta el comando "nmap" con el dominio ingresado, muestra una barra de progreso y guarda la salida en un archivo "nmap.txt"
nmap "$dominio" | pv -p -t -e -r -a -b > puertosyversiones.txt

echo "¡Listo! Los resultados se han guardado en los siguientes archivos:"
echo "- subdominios.txt"
echo "- htt_services.txt"
echo "- crawler.txt"
echo "- Puertosyversiones.txt"
