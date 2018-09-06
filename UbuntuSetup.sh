#!/bin/bash

#Script to setup Ubuntu 18.04 LTS to my liking.
#Feel free to use it!

#Before we start, colors for a little pop!
no_color='\033[0m'
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'

echo -e "${cyan}UbuntuSetup${no_color} - Setting up ${red}Ubuntu${no_color} for lazy people!"
echo "Let's get started! What do ya want to do?"

while :
do
	# Write out the menu options...
	echo "Select an option:"
	echo ""
	echo -e " ${cyan}1${no_color}: Setup Proxy for apt"
	echo -e " ${cyan}2${no_color}: Update packages"
	echo -e " ${cyan}3${no_color}: Install another desktop environment"
	echo -e " ${cyan}4${no_color}: Uninstall default desktop environment"
	echo -e " ${cyan}5${no_color}: Install display and terminal fonts"
	echo -e " ${cyan}6${no_color}: Install a IDE or advanced text editor"
	echo -e " ${cyan}7${no_color}: Beautify your system"
	echo -e " ${cyan}8${no_color}: Set root password"
	echo -e " ${cyan}9${no_color}: Remove snap applications and snapd"
	echo -e " ${cyan}10${no_color}: Remove bloat and tracking"
	echo -e " ${cyan}11${no_color}: Clean up packages"
	echo -e " ${cyan}12${no_color}: Install preferred applications"
	echo -e " ${cyan}13${no_color}: Install restricted extras"
	echo -e " ${cyan}14${no_color}: Set up IDE extensions (for VS Code only)"

	echo -e " ${cyan}15${no_color}: Exit"

	#Do eeet!
	read fch
	case $fch in
		1) 
			read -p "Do you want to enable or disable the proxy? (y to enable, n to disable)" yn
			case $yn in
				[Yy]* )
					sudo touch /etc/apt/apt.conf.d/02proxy
					sudo echo "proxylineone" >> /etc/apt/apt.conf.d/02proxy
					sudo echo "proxylinetwo" >> /etc/apt/apt.conf.d/02proxy
					echo -e "${green}Proxy set up!"
					;;
				[Nn]* ) 
					sudo rm /etc/apt/apt.conf.d/02proxy
					;;
				* ) 
					echo -e "${red}It's invalid kiddo! Try again."
					;;
			esac
			;;
		2) 
			sudo apt-get update
			sudo apt-get -y upgrade
			echo -e "${green}System's spankin new now!"
			;;
		3) 
			echo "Pick your poison:"
			echo -e " ${cyan}a${no_color}: LXDE"
			echo -e " ${cyan}b${no_color}: XFCE"
			echo -e " ${cyan}c${no_color}: Budgie"
			echo -e " ${cyan}d${no_color}: KDE"
			echo -e " ${cyan}e${no_color}: Cinnamon"
			echo -e " ${cyan}f${no_color}: Mate"
			echo -e " ${cyan}g${no_color}: Enlightenment"
			echo -e " ${cyan}h${no_color}: Unity (don't say I didn't warn ya.)"

			read dech
			case $dech in
				a) 
					sudo apt install tasksel
					sudo apt update
					sudo tasksel install lubuntu-desktop
					;;
				b) 
					sudo apt install tasksel
					sudo apt update
					sudo tasksel install xubuntu-desktop
					;;
				c) 
					sudo apt install -y ubuntu-budgie-desktop
					;;
				d) 
					sudo apt install tasksel
					sudo apt update
					sudo tasksel install kubuntu-desktop
					;;
				e) 
					sudo apt install -y cinnamon-desktop-environment lightdm
					sudo dpkg-reconfigure
					;;
				f)
					sudo apt install tasksel
					sudo apt update
					sudo tasksel install ubuntu-mate-desktop
					;;
				g) 
					sudo add-apt-repository ppa:niko2040/e19
					sudo apt update
					sudo apt install -y enlightenment terminology
					;;
				h) 
					sudo apt install -y ubuntu-unity-desktop
					;;
				*) 
					echo -e "${red}Sorry kiddo, that isn't a valid DE choice."
					;;
			esac
			echo -e "${green}Enjoy your new DE!"
			;;
		4) 
			read -p "This will remove the default GNOME desktop and GDM login manager. Sure you want to continue? ${yellow}(y/n)${no_color}:" yn
			case $yn in
				[Yy]* ) 
					sudo apt-get remove -y --auto-remove ubuntu-gnome-desktop
					sudo apt-get remove -y gnome-shell
					sudo apt-get purge --auto-remove ubuntu-gnome-desktop
					sudo apt-get autoremove
					sudo dpkg-reconfigure gdm
					sudo apt-get remove -y gdm3
					echo -e "${green}Buhbye GNOME!"
					;;
				[Nn]* ) 
					continue
					;;
				* ) 
					echo -e "${red}It's invalid kiddo! Try again."
					;;
			esac
			;;
		5) 
			iosevka_loc="https://github.com/be5invis/Iosevka/releases/download/v2.0.0/02-iosevka-term-2.0.0.zip"
			hack_loc="https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip"
			input_loc="http://input.fontbureau.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email="
			overpass_loc="https://github.com/RedHatBrand/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip"
			google_loc="https://fonts.google.com/download?family=Dosis|Work%20Sans|Nanum%20Gothic|Fira%20Sans|Nunito|Noto%20Serif|PT%20Sans%20Narrow|Arimo|Muli|Roboto%20Mono|PT%20Serif|Titillium%20Web|Playfair%20Display|Lora|Noto%20Sans|Ubuntu|Open%20Sans%20Condensed|Merriweather|PT%20Sans|Roboto%20Slab|Raleway|Slabo%2027px|Source%20Sans%20Pro|Montserrat|Roboto%20Condensed|Oswald|Lato|Open%20Sans|Roboto"
			
			#to be done - curl commands and install
			echo -e "${cyan}Installing Iosevka..."
			curl --progress-bar -O iosevka.zip iosevka_loc
			unzip iosevka.zip
			sudo mkdir /usr/share/fonts/truetype/iosevka
			sudo cp something/*.ttf /usr/share/fonts/truetype/iosevka
			sudo chown root:root /usr/share/fonts/truetype/iosevka -R
			sudo chmod 644 /usr/share/fonts/truetype/iosevka/* -R
			sudo chmod 755 /usr/share/fonts/truetype/iosevka
			sudo fc-cache -fv
			cd ../..
			rm -rf something
			
			echo -e "${cyan}Installing Hack..."
			curl --progress-bar -O hack.zip hack_loc
			unzip hack.zip
			sudo mkdir /usr/share/fonts/truetype/iosevka
			sudo cp something/*.ttf /usr/share/fonts/truetype/iosevka
			sudo chown root:root /usr/share/fonts/truetype/iosevka -R
			sudo chmod 644 /usr/share/fonts/truetype/iosevka/* -R
			sudo chmod 755 /usr/share/fonts/truetype/iosevka
			sudo fc-cache -fv
			cd ../..
			rm -rf something

			echo -e "${cyan}Installing Input..."
			curl --progress-bar -O input.zip input_loc
			unzip input.zip
			sudo mkdir /usr/share/fonts/truetype/input
			sudo cp something/*.ttf /usr/share/fonts/truetype/input
			sudo chown root:root /usr/share/fonts/truetype/input -R
			sudo chmod 644 /usr/share/fonts/truetype/input/* -R
			sudo chmod 755 /usr/share/fonts/truetype/input
			sudo fc-cache -fv
			cd ../..
			rm -rf something

			echo -e "${cyan}Installing Overpass..."
			curl --progress-bar -O overpass.zip overpass_loc
			unzip overpass.zip
			sudo mkdir /usr/share/fonts/truetype/overpass
			sudo cp something/*.ttf /usr/share/fonts/truetype/overpass
			sudo chown root:root /usr/share/fonts/truetype/overpass -R
			sudo chmod 644 /usr/share/fonts/truetype/overpass/* -R
			sudo chmod 755 /usr/share/fonts/truetype/overpass
			sudo fc-cache -fv
			cd ../..
			rm -rf something

			echo -e "${cyan}Installing Google Fonts..."
			curl --progress-bar -O google.zip google_loc
			unzip google.zip
			sudo mkdir /usr/share/fonts/truetype/google
			sudo cp something/*.ttf /usr/share/fonts/truetype/google
			sudo chown root:root /usr/share/fonts/truetype/google -R
			sudo chmod 644 /usr/share/fonts/truetype/google/* -R
			sudo chmod 755 /usr/share/fonts/truetype/google
			sudo fc-cache -fv
			cd ../..
			rm -rf something
			;;
		6) 
			echo "We have these in stock. Whaddaya need?"
			echo -e " ${cyan}a${no_color}: VS Code"
			echo -e " ${cyan}b${no_color}: Atom"
			echo -e " ${cyan}c${no_color}: Jupyter"
			echo -e " ${cyan}d${no_color}: Brackets"
			echo -e " ${cyan}e${no_color}: Eclipse"
			echo -e " ${cyan}f${no_color}: Android Studio"
			echo -e " ${cyan}f${no_color}: PyCharm Community Edition"
			echo -e " ${cyan}f${no_color}: Sublime Text"

			read idech
			case $idech in
				a) 
					mkdir codefolder && cd codefolder
					curl --progress-bar -O -L "https://go.microsoft.com/fwlink/?LinkID=760868"
					mv * code.deb
					sudo dpkg -i code.deb
					sudo apt-get install -f
					cd ..
					rm -rf codefolder
					;;
				b) 
					curl --progress-bar -O atom-amd64.deb https://atom.io/download/deb
					sudo dpkg -i atom-amd64.deb
					sudo apt-get install -f
					rm atom-amd64.deb
					;;
				c) 
					sudo apt-get install -y jupyter
					;;
				d) 
					brackets_loc="https://github.com/adobe/brackets/releases/download/release-1.13/Brackets.Release.1.13.64-bit.deb"
					curl --progress-bar -O brackets.deb $brackets_loc
					sudo dpkg -i brackets.deb
					sudo apt-get install -f
					rm brackets.deb
					;;
				e) 
					eclipse_loc="http://eclipse.bluemix.net/packages/photon/data/eclipse-inst-linux64.tar.gz"
					sudo apt install openjdk-9-jdk
					curl --progress-bar -O eclipse.tar.gz $eclipse_loc
					tar xzf eclipse.tar.gz
					./eclipse-installer/eclipse-inst
					;;
				f) 
					studio_loc="https://dl.google.com/dl/android/studio/ide-zips/3.1.4.0/android-studio-ide-173.4907809-linux.zip"
					curl --progress-bar -O studio.zip $studio_loc
					unzip studio.zip
					mv android-studio ~/AndroidStudio
					chmod +x ~/AndroidStudio/bin/studio.sh
					rm studio.zip 
					;;
				g)
					#to be done - download and install pycharm
					;;
				h)
					#to be done - download and install sublime
					;;

				*) 
					echo -e "${red}That doesn't exist! Try again!."
					;;
			esac
			echo -e "${green}Get to work now!"
			;;
		7)
			#to be done - cursors, icon sets and themes
			;;
		8) 
			sudo passwd root
			echo -e "${green}Root secured!"
			;;
		9) 
			snap list | awk -F" " '{if ($1 && NR>1) { system("snap remove " $1 " 2>/dev/null") }}'
			sudo apt purge gnome-software-plugin-snap -qqy
			sudo apt purge snapd ubuntu-core-launcher squashfs-tools -qqy
			echo -e "${green}Aw, snap!"
			;;
		10) 
			#uninstall account plugins and account related stuff.
			sudo apt-get purge account-plugin-aim account-plugin-facebook account-plugin-flickr account-plugin-google account-plugin-jabber account-plugin-salut account-plugin-twitter account-plugin-windows-live account-plugin-yahoo folks-common friends friends-dispatcher friends-facebook friends-twitter gnome-contacts nautilus-sendto unity-lens-friends unity-scope-gdrive unity-scope-musicstores unity-scope-zotero libfolks-eds25 libfriends0 mcp-account-manager-uoa rhythmbox-plugin-magnatune libaccount-plugin-google --qqy

			#uninstall games and other bloat
			sudo apt-get purge gnome-accessibility-themes gnome-mines gnome-orca gnome-sudoku gnomine nautilus-sendto-empathy aisleriot brltty cheese cheese-common example-content unity-plugin-scopes unity-scope-mediascanner2 -qqy

			#uninstall zeitgeist usage tracking or whatever it does
			sudo apt-get purge zeitgeist zeitgeist-datahub zeitgeist-core python-zeitgeist rhythmbox-plugin-zeitgeist -qqy

			#uninstall rhythmbox's firefox plugin
			sudo apt-get purge rhythmbox-mozilla -qqy

			#uninstall Ubuntu's crash stats daemon
			sudo apt-get purge whoopsie whoopsie-preferences -qqy

			#cleanup operations
			sudo apt-get autoremove --purge -qqy
			sudo apt-get autoclean -qqy
			sudo apt-get clean -qqy		
			echo -e "${green}Its squeaky clean!"
			;;
		11) 
			sudo apt-get autoremove --purge -qqy
			sudo apt-get autoclean -qqy
			sudo apt-get clean -qqy
			echo -e "${green}Wasn't it squeaky clean before? Well, now it is!"
			;;
		12) 
			#to be done - uninstall default apps and install preferred apps
			;;
		13) 
			sudo apt install -y ubuntu-restricted-extras
			echo -e "${green}Music time!"
			;;
		14) 
			#to be done - set up vs code extensions
			;;

		15) 
			echo -e "${green}Buhbye!"
			break
			;;
		*) 
			echo "${red}Wrong choice, kiddo." ;;
	esac

done