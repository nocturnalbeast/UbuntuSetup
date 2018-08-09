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

# Write out the menu options...
echo "Let's get started! What do ya want to do?"
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
echo -e " ${cyan}10${no_color}: Remove Canonical's usage tracking"
echo -e " ${cyan}11${no_color}: Clean up packages"
echo -e " ${cyan}12${no_color}: Install preferred applications"

echo -e " ${cyan}15${no_color}: Exit"

#Do eeet!
read fch
case $fch in
	1) 
		sudo touch /etc/apt/apt.conf.d/02proxy
		sudo echo "proxylineone" >> /etc/apt/apt.conf.d/02proxy
		sudo echo "proxylinetwo" >> /etc/apt/apt.conf.d/02proxy
		echo -e "${green}Proxy set up!"
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
		echo -e " ${cyan}g${no_color}: Unity (don't say I didn't warn ya.)"

		read dech
		case $dech in
    		a) 
				sudo apt install tasksel
				sudo tasksel install lubuntu-desktop
				;;
    		b) 
				sudo apt install tasksel
				sudo tasksel install xubuntu-desktop
				;;
    		c) 
				sudo apt install ubuntu-budgie-desktop
				;;
			d) 
				sudo apt install tasksel
				sudo tasksel install kubuntu-desktop
				;;
			e) 
				sudo apt install cinnamon-desktop-environment lightdm
				sudo dpkg-reconfigure
				;;
			f) 
				sudo apt install ubuntu-unity-desktop
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
				sudo apt-get remove gdm
				echo -e "${green}Buhbye GNOME!"
				;;
        	[Nn]* ) 
				continue
				;;
        	* ) 
				echo -e "${red}It's invalid kiddo! Try again.";;
    	esac
		;;
	5) 
		iosevka_loc="https://github.com/be5invis/Iosevka/releases/download/v2.0.0/02-iosevka-term-2.0.0.zip"
		hack_loc="https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip"
		input_loc="http://input.fontbureau.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email="
		overpass_loc="https://github.com/RedHatBrand/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip"
		google_loc="https://fonts.google.com/download?family=Dosis|Work%20Sans|Nanum%20Gothic|Fira%20Sans|Nunito|Noto%20Serif|PT%20Sans%20Narrow|Arimo|Muli|Roboto%20Mono|PT%20Serif|Titillium%20Web|Playfair%20Display|Lora|Noto%20Sans|Ubuntu|Open%20Sans%20Condensed|Merriweather|PT%20Sans|Roboto%20Slab|Raleway|Slabo%2027px|Source%20Sans%20Pro|Montserrat|Roboto%20Condensed|Oswald|Lato|Open%20Sans|Roboto"

		;;
	6) 
		echo "We have these in stock. Whaddaya need?"
		echo " a: VS Code"
		echo " b: Atom"
		echo " c: Jupyter"
		echo " d: Brackets"
		echo " e: Eclipse"

		read idech
		case $idech in
    		a) 
				mkdir codefolder && cd codefolder
				curl -O -L "https://go.microsoft.com/fwlink/?LinkID=760868"
				mv * code.deb
				sudo dpkg -i code.deb
				sudo apt-get install -f
				cd ..
				rm -rf codefolder
				;;
    		b) 
				wget -O atom-amd64.deb https://atom.io/download/deb
				sudo dpkg -i atom-amd64.deb
				sudo apt-get install -f
				rm atom-amd64.deb
				;;
    		c) 
				sudo apt-get install -y jupyter
				;;
			d) 
				brackets_loc="https://github.com/adobe/brackets/releases/download/release-1.13/Brackets.Release.1.13.64-bit.deb"
				wget -O brackets.deb $brackets_loc
				sudo dpkg -i brackets.deb
				sudo apt-get install -f
				rm brackets.deb
				;;
			e) 
				#install eclipse
				;;

    		*) 
				echo -e "${red}That doesn't exist! Try again!."
				;;
		esac
		echo -e "${green}Get to coding now!"


	7) 
		;;
	8) 
		sudo su
		passwd
		exit
		echo -e "${green}Root secured!"
		;;
	9) 
		;;
	10) 
		sudo apt install ubuntu-restricted-extras
		echo -e "${green}Music time!"
		;;
	11) 
		;;
	12) 
		;;


	15) 
		;;
	*) 
		echo "${red}Wrong choice, kiddo." ;;
esac