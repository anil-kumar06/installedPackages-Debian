#!/bin/bash
logfile=/tmp/installed_package.$$

if [ ! -f "/usr/bin/zenity" ]; then
  echo "Zenity package is not installed. !!!"
  exit 0
fi

array=( a ALL ssh locate tc )
value=$(zenity --entry --title "Enter the package you want to search" --text "${array[@]}" --text "Insert your choice." 2>/dev/null)

if [ $? -eq 0 ];then
  if [ $value == "ALL" ];then
    dpkg-query -l | grep '^ii' | awk '{print $2}' > $logfile
  else
    dpkg-query -l | grep '^ii' | awk '{print $2}' | grep $value > $logfile
  fi
  zenity --width=500 --height=600 --title "Installed" --text-info --filename="$logfile" 2>/dev/null
else
  zenity --error 2>/dev/null
fi
rm -f $logfile
