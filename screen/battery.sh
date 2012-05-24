#!/bin/sh

acpi -a | grep on-line > /dev/null
if [ $? -eq 1 ]; then
  status=`acpi| cut -d "," -f2 | cut -d "%" -f1 | cut -d " " -f2`
  if [ "$status" -lt "10" ]
  then
    echo -e "\005{= rw} bat: ${status} \005{-}" ;
  elif [ "$status" -lt "25" ]
  then
    echo -e "\005{= yk} bat: ${status} \005{-}";
  else
    echo -e "\005{= Gk} bat: ${status} \005{-}";
  fi
else
  echo -e "\005{= Gk} bat: AC \005{-}";
fi
