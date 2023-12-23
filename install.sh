#!/bin/sh
# Script that automate the procces for setting up TOR as a tranparent proxy
# Autor: Edu4rdSHL @edu4rdshl

#Defining variables
torconfig="/etc/tor/torrc"
torconfigbackup="/etc/tor/torrc.backup"
executablerules="$PWD/files/net-spectre"
servicefile="$PWD/files/net-spectre.service"

#Check if the current user have root privileges
if [ "$UID" -ne "0" ] ; then
    echo -e "\nYou need root permisions to run it script."
    exit
fi

echo -e "Checking if TOR and Systemd are installed..."
if command -v tor >/dev/null && command -v systemctl > /dev/null ; then
  if grep -iq "# Seting up TOR transparent proxy for net-spectre" "$torconfig" ; then
    echo -e "\nnet-spectre is already configured in $torconfig"
  else
    echo -e "\nAll fundamentals tools are installed, proceding..."
    echo -e "\nMaking a backup of your torrc file, if you have problems with the new configuration, delete $torconfig and move $torconfigbackup to $torconfig"
    cp "$torconfig" "$torconfigbackup"
    echo -e "\nConfiguring the torrc file to use TOR as a transparent proxy..."
    # ToDo need replace torrc.base in following line
    echo -e "\n# Seting up TOR transparent proxy for net-spectre\nVirtualAddrNetwork 10.192.0.0/10\nAutomapHostsOnResolve 1\nTransPort 9040\nDNSPort 5353" >> "$torconfig"
    echo -e "\nCreating, enabling and starting the service file tor transparent proxy..."
    cp "$executablerules" "/usr/bin/"
    chmod +x "/usr/bin/net-spectre"
    cp "$servicefile" "/etc/systemd/system/"
    systemctl enable net-spectre.service && systemctl start net-spectre.service
    echo -e "\nEnabling and restarting the TOR daemon using systemctl..."
    systemctl enable tor && systemctl restart tor
    if [ "$?" == 0 ] ; then
      echo -e "Checking if all are working..."
      if command -v curl >/dev/null ; then
        curl https://check.torproject.org/ | grep "Congratulations."
        if [ "$?" == 0 ] ; then
          echo -e "\nAll is OK, from now on all your network traffic is under the TOR Network, look for your IP addres in your browser."
          exit
        fi
      else
        echo -e "\nYou haven't curl installed, try opening https://check.torproject.org/ in your browser and look for 'Congratulations.'"
      fi
    else
      echo -e "\nAn error as ocurrer, please open a issue in https://github.com/Edu4rdSHL/net-spectre/issues including log info and your Linux distribution."
    fi
  fi
else
  echo -e "Systemd or TOR are not installed, the script dont work."
  exit
fi
