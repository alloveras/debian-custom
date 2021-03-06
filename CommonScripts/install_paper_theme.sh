################################################################
# File: install_paper_theme.sh
# Author: Albert Lloveras Carbonell (albertlloveras@gmail.com),
# Roger Fernandez Guri (rfguri@gmail.com).
# Date: 08/01/2015
# Description: Script that installs and sets Paper Theme as
# default Gnome3 theme providing a Material-Design based UI.
# License: MIT
################################################################

#!/bin/bash

#Download and Install the Paper Theme
echo -ne "${BLUE}[INFO]:${NO_COLOR} Downloading Paper Theme...\n";

rm -rf /tmp/PaperTheme;
rm -rf /tmp/SuperFlat;
git clone https://github.com/snwh/paper-gtk-theme.git /tmp/PaperTheme;
git clone https://github.com/daniruiz/Super-Flat-Remix-GNOME-theme.git /tmp/SuperFlat;

echo -ne "${BLUE}[INFO]:${NO_COLOR} Installing Paper Theme...\n";

#Copy SuperFlat theme
su root -c "cp -R /tmp/SuperFlat/Super\ Flat\ Remix\ GNOME\ theme /usr/share/themes/SuperFlat";

current_path=`pwd`;

cd /tmp/PaperTheme;
su root -c "yes | bash install.sh" /dev/null 2>&1;
cd $current_path;

echo -ne "${BLUE}[INFO]:${GREEN} Paper theme installed!${NO_COLOR}\n";

echo -ne "${BLUE}[INFO]:${NO_COLOR} Setting Paper Theme as default theme for user $current_user...${NO_COLOR}\n";
su $current_user -c "gsettings set org.gnome.desktop.interface gtk-theme 'Paper'";
su $current_user -c "gconftool-2 --set --type string /apps/metacity/general/theme 'Paper'";
su $current_user -c "gsettings set org.gnome.shell.extensions.user-theme name 'SuperFlat'";

echo -ne "${BLUE}[INFO]:${GREEN} Paper Theme installed!${NO_COLOR}\n";
