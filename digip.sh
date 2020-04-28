#!/bin/bash
# Usage: ./digip.sh [domain-list-file] [output-file]
echo "      _ _         _         ";
echo "     | (_)       (_)        ";
echo "   __| |_  __ _   _ _ __    ";
echo "  / _\` | |/ _\` | | | '_ \ ";
echo " | (_| | | (_| | | | |_) |  ";
echo "  \__,_|_|\__, | |_| .__/   ";
echo "           __/ |   | |      ";
echo "          |___/    |_|      ";
echo -e "\n"
echo -e "[+] DigIP.sh by Black Coder\n"
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "[!] Usage: ./digip.sh [domain-list-file] [output-file]"
  exit 1
fi
echo "[+] Resolving domains to IPs..."
while read d || [[ -n $d ]]; do
  ip=$(dig +short $d|grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -1)
  if [ -n "$ip" ]; then
    echo "[+] '$d' => $ip"
    echo $ip >> $2
  else
    echo "[!] '$d' => [RESOLVE ERROR]"
  fi
done < $1
echo -e "\n[+] Removing duplicates..."
sort $2 | uniq > $2.new
mv $2.new $2
echo -e "\n[+] Done.\n===>IPs saved to '$2'."
