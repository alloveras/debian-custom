################################################################
# File: install_additional_software.sh
# Author: Albert Lloveras Carbonell (albertlloveras@gmail.com),
# Roger Fernandez Guri (rfguri@gmail.com).
# Date: 08/01/2015
# Description: Script that install additional software that is
# commonly used by people such as audio & video codecs, flash
# player, file compression formats...
# License: MIT
################################################################

#!/bin/bash

#Install some audio and video codecs

echo -ne "${BLUE}[INFO]:${NO_COLOR} Installing audio & video common codecs...\n";
su root -c "apt-get -y --force-yes install libdvdcss2";

arch=`uname -m`;

#Check system architecture to decide which codecs to install
if [ "$arch" == "x86_64" ]; then
	su root -c "apt-get -y --force-yes install w64codecs";
else
	su root -c "apt-get -y --force-yes install w32codecs";
fi

#Ask the user if he/she wants to install Java 1.8 SDK
echo -ne "${BLUE}[INFO]:${NO_COLOR} Would you like to install Java 1.8 SDK? [Y/N]\n";

while read option; do

  if [ "$option" == "Y" ] || [ "$option" == "y" ]; then

    echo -ne "${BLUE}[INFO]:${NO_COLOR} Installing Oracle Sun Java SDK 1.8...\n";
    if [ "$arch" == "x86_64" ]; then
      cd /opt/;
      wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz";
      tar xzf jdk-8u66-linux-x64.tar.gz;
      rm -rf jdk-8u66-linux-x64.tar.gz;
    else
      cd /opt/;
      wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-i586.tar.gz";
      tar xzf jdk-8u66-linux-i586.tar.gz;
      rm -rf jdk-8u66-linux-i586.tar.gz;
    fi

    update-alternatives --install "/usr/bin/java" "java" "/opt/jdk1.8.0_66/bin/java" 1;
    update-alternatives --install "/usr/bin/javac" "javac" "/opt/jdk1.8.0_66/bin/javac" 1;
    update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/jdk1.8.0_66/bin/javaws" 1;
    update-alternatives --set java /opt/jdk1.8.0_66/bin/java;
    update-alternatives --set javac /opt/jdk1.8.0_66/bin/javac;
    update-alternatives --set javaws /opt/jdk1.8.0_66/bin/javaws;

    echo -ne "${BLUE}[INFO]:${GREEN} Oracle Sun Java SDK 1.8 installed!${NO_COLOR}\n";

    break;

  elif [ "$option" == "N" ] || [ "$option" == "n" ]; then
    break;
  else
    echo -ne "${RED}[ERROR]: Incorrect option!${NO_COLOR}  Would you like to install Java 1.8 SDK? [Y/N]\n";
  fi

done

echo -ne "${BLUE}[INFO]:${GREEN} Common audio & video codecs intalled!${NO_COLOR}\n";

echo -ne "${BLUE}[INFO]:${NO_COLOR} Installing Adobe Flash Player plugin...\n";
su root -c "apt-get -y --force-yes install flashplugin-nonfree";
echo -ne "${BLUE}[INFO]:${GREEN} Adobe Flash Player plugin installed!${NO_COLOR}\n";

echo -ne "${BLUE}[INFO]:${NO_COLOR} Uninstalling OpenJDK...\n";
su root -c "apt-get -y --force-yes purge openjdk-\*";
echo -ne "${BLUE}[INFO]:${GREEN} OpenJDK uninstalled!${NO_COLOR}\n";

echo -ne "${BLUE}[INFO]:${NO_COLOR} Installing compatibility with common compression methods...\n";
su root -c "apt-get -y --force-yes install rar unrar zip unzip unace bzip2 lzop p7zip-full p7zip-rar";
echo -ne "${BLUE}[INFO]:${GREEN} Compatibility with common compression methods has been enabled!${NO_COLOR}\n";

