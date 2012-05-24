#!/bin/zsh

file=${HOME}/.fluxbox/wpa-menu
script=$0

run () {
  if [[ $1 == "daemon" ]]; then
    while true; do
      generate_menu
      sleep 15m
    done
  else
    generate_menu
  fi
}

generate_menu () {
  rm $file

  myssid=`wpa_cli status | grep "^ssid" | cut -f 2 -d "="`
  myipaddress=`wpa_cli status | grep "^ip_address" | cut -f 2 -d "="`

  wpa_cli scan 2&>/dev/null
  sleep 1
  res=`wpa_cli scan_results`
  lines=$((`echo ${res} | wc -l`-2))
  result=`echo ${res} | tail -n ${lines} | sort -k 3 -r`

  macs=`echo ${result} | cut -f 1`
  freqs=`echo ${result} | cut -f 2`
  strengths=`echo ${result} | cut -f 3`
  flags=`echo ${result} | cut -f 4`
  ssids=`echo ${result} | cut -f 5`

  echo "[begin] (WIFI)" >> $file
  echo "  [nop] (Connected to ${myssid})" >> $file
  echo "  [nop] (IP address: ${myipaddress})" >> $file
  echo "  [separator]" >> $file
  echo "  [nop] (Available networks)" >> $file
  for i in `seq ${lines}`; do
    echo "[nop] (`echo $ssids | head -n ${i} | tail -n 1`)" >> $file
  done
  echo "[end]" >> $file
}

run $@
