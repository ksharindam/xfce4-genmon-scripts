#!/bin/sh
# Change wlan0 to your Wifi interface


if $(/sbin/ifconfig | grep -q wlan0) ; then
  has_ip=`/sbin/ifconfig wlan0 | grep 'inet '`
  unassociated=$(/sbin/iwconfig wlan0 | grep "unassociated")
  if ! [ -z "$has_ip" ] && [ -z "$unassociated" ] ; then
    # Show info and signal strength icon
    ip_addr=$(/sbin/ifconfig wlan0 | grep 'inet ' | tr -s ' ' | cut -d ' ' -f 3)
    ESSID=$(/sbin/iwconfig wlan0 | grep "ESSID" |cut -d "\"" -f 2)
    sig_strength=$(/sbin/iwconfig wlan0 | grep "Signal level" |cut -d "=" -f 3 | cut -d "/" -f 1)
    if [ "$sig_strength" -gt '80' ] ; then
      echo "<img>/usr/share/icons/hicolor/22x22/status/wifi-3.png</img>"
    elif [ "$sig_strength" -gt '60' ] ; then
      echo "<img>/usr/share/icons/hicolor/22x22/status/wifi-2.png</img>"
    elif [ "$sig_strength" -gt '40' ] ; then
      echo "<img>/usr/share/icons/hicolor/22x22/status/wifi-1.png</img>"
    else
      echo "<img>/usr/share/icons/hicolor/22x22/status/wifi-0.png</img>"
    fi
    echo "<tool>Connected to :" $ESSID
    echo "Signal Level :" $sig_strength"%"
    echo "IP Addr : $ip_addr</tool>"
  else
    # Show disconnected icon, click to configure
    echo "<img>/usr/share/icons/hicolor/22x22/status/wifi-disconn.png</img>"
    echo "<tool>Not Connected to Hotspot"
    echo "Click to configure</tool>"
    echo "<click>/usr/sbin/wpa_gui</click>"
  fi

elif $(/sbin/ifconfig | grep -q eth1) ; then # Ethernet plugged
  if $(/sbin/ifconfig eth1 | grep -q 'inet ') ; then
    ip_addr=$(/sbin/ifconfig eth1 | grep 'inet ' | tr -s ' ' | cut -d ' ' -f 3)
    # Show connected icon and ip tooltip
    echo "<img>/usr/share/icons/Adwaita/22x22/status/network-transmit.png</img>"
    echo "<tool>IP Addr : $ip_addr</tool>"
  else
    # Show not connected icon
    echo "<img>/usr/share/icons/Adwaita/22x22/status/network-error.png</img>"
    echo "<tool>Not Connected to Internet</tool>"
  fi

else
  # Hide icon when no interface is attached
  echo
fi
