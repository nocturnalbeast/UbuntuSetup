#!/bin/bash

#Script to setup Ubuntu 18.04 LTS to my liking.
#Whiptail version for even lazier users!
#Feel free to use it!

TITLE="UbuntuSetup"
RESMSG=""

function preStart {
    echo "Checking if necessary tools for running are installed.."
    [ "$(dpkg-query -l whiptail | tail -1 | awk '{ print $1 }')" != "ii" ] && sudo apt install whiptail
    [ "$(dpkg-query -l curl | tail -1 | awk '{ print $1 }')" != "ii" ] && sudo apt install curl
    [ "$(dpkg-query -l tasksel | tail -1 | awk '{ print $1 }')" != "ii" ] && sudo apt install tasksel
    echo "A dash of color.."
    #TODO - finish color palette
    export NEWT_COLORS='
        root=,red
        window=red,black
        title=brightred,black
        border=brightred,black
        textbox=red,black
        button=black,red'
}

function setupProxy {
    if (whiptail --title $TITLE --yesno "Do you want to enable or disable the proxy?" --yes-button "Enable" --no-button "Disable" 8 47) then
        sudo rm /etc/apt/apt.conf.d/02proxy
        sudo touch /etc/apt/apt.conf.d/02proxy
        sudo echo "proxylineone" >> /etc/apt/apt.conf.d/02proxy
        sudo echo "proxylinetwo" >> /etc/apt/apt.conf.d/02proxy
    else
        sudo rm /etc/apt/apt.conf.d/02proxy
    fi
    RESMSG="Updates will work now...I think."
}

function updatePackages {
    sudo apt-get update
    sudo apt-get -y upgrade
    RESMSG="System's spankin new now!"
}

function installNewDE {
    IDECH=$(
    whiptail --title $TITLE --menu "Pick your poison:" 21 60 13 \
        "1." "XFCE" \
        "2." "LXDE" \
        "3." "Budgie" \
        "4." "KDE" \
        "5." "Cinnamon" \
        "6." "MATE" \
        "7." "Enlightenment" \
        "8." "Unity (don't say I didn't warn ya.)"  3>&2 2>&1 1>&3
    )
    sudo apt update
    case $IDECH in
        "1.")   
            sudo tasksel install lubuntu-desktop
            ;;
        "2.")   
            sudo tasksel install xubuntu-desktop
            ;;
        "3.")   
            sudo apt install -y ubuntu-budgie-desktop
            ;;
        "4.")   
            sudo tasksel install kubuntu-desktop
            ;;
        "5.")   
            sudo apt install -y cinnamon-desktop-environment lightdm
            sudo dpkg-reconfigure
            ;;
        "6.")   
            sudo tasksel install ubuntu-mate-desktop
            ;;
        "7.")
            sudo add-apt-repository ppa:niko2040/e19
            sudo apt update
            sudo apt install -y enlightenment terminology
            ;;
        "8.")
            sudo apt install -y ubuntu-unity-desktop
            ;;
    esac
    RESMSG="Enjoy your new DE!"
}

function uninstallDefaultDE {
    if (whiptail --title $TITLE --yesno "This will remove the default GNOME desktop and GDM login manager. Sure you want to continue?" 8 78) then
        sudo apt-get remove -y --auto-remove ubuntu-gnome-desktop
        sudo apt-get remove -y gnome-shell
        sudo apt-get purge --auto-remove ubuntu-gnome-desktop
        sudo apt-get autoremove
        sudo dpkg-reconfigure gdm
        sudo apt-get remove -y gdm3
        echo -e "${green}Buhbye GNOME!"
    else
        continue
    fi
    RESMSG=""
}

function installFonts {
    #TODO - port from main version after finishing functionality
    RESMSG=""
}

function installIDE {
    #TODO - port from main version
    RESMSG=""
}

function sysBeaut {
    #TODO - setup themes and such
    RESMSG=""
}

function rootPass {
    sudo passwd root
    RESMSG="Root secured!"
}

function rmSnapnSApps {
    snap list | awk -F" " '{if ($1 && NR>1) { system("snap remove " $1 " 2>/dev/null") }}'
	sudo apt purge gnome-software-plugin-snap -qqy
	sudo apt purge snapd ubuntu-core-launcher squashfs-tools -qqy
    RESMSG="Aw, snap!"
}

function rmBloatnTrack {
    #uninstall account plugins and account related stuff.
    sudo apt purge account-plugin-aim account-plugin-facebook account-plugin-flickr account-plugin-google account-plugin-jabber account-plugin-salut account-plugin-twitter account-plugin-windows-live account-plugin-yahoo folks-common friends friends-dispatcher friends-facebook friends-twitter gnome-contacts nautilus-sendto unity-lens-friends unity-scope-gdrive unity-scope-musicstores unity-scope-zotero libfolks-eds25 libfriends0 mcp-account-manager-uoa rhythmbox-plugin-magnatune libaccount-plugin-google --qqy

    #uninstall games and other bloat
    sudo apt purge gnome-accessibility-themes gnome-mines gnome-orca gnome-sudoku gnomine nautilus-sendto-empathy aisleriot brltty cheese cheese-common example-content unity-plugin-scopes unity-scope-mediascanner2 -qqy

    #uninstall zeitgeist usage tracking or whatever it does
    sudo apt purge zeitgeist zeitgeist-datahub zeitgeist-core python-zeitgeist rhythmbox-plugin-zeitgeist -qqy

    #uninstall rhythmbox's firefox plugin
    sudo apt purge rhythmbox-mozilla -qqy

    #uninstall Ubuntu's crash stats daemon
    sudo apt purge whoopsie whoopsie-preferences -qqy

    #cleanup operations
    sudo apt autoremove --purge -qqy
    sudo apt autoclean -qqy
    sudo apt clean -qqy
    RESMSG="It's squeaky clean!"
}

function cleanupPackage {
    sudo apt autoremove --purge -qqy
    sudo apt autoclean -qqy
    sudo apt clean -qqy
    RESMSG="Wasn't it squeaky clean before? Well, now it is!"
}

function installFavApps {
    #TODO - install favorite apps
    RESMSG=""
}

function installRE {
    sudo apt install -y ubuntu-restricted-extras
    RESMSG="Yarr, matey!"
}

function setupIDEExtras {
    #TODO - setup vs-code extensions
    RESMSG=""
}

function eordBootScreen {
    #TODO - make this automatic, no user input, rewrite sed
    if (whiptail --title $TITLE --yesno "Is boot screen enabled or disabled?" 10 60) then
        sudo sed -i "s,GRUB_CMDLINE_LINUX_DEFAULT="quiet splash",GRUB_CMDLINE_LINUX_DEFAULT="",g" /etc/default/grub
        sudo update-grub
        RESMSG="Boot screen'nt!"
    else
        sudo sed -i "s,GRUB_CMDLINE_LINUX_DEFAULT="",GRUB_CMDLINE_LINUX_DEFAULT="quiet splash",g" /etc/default/grub
        sudo update-grub
        RESMSG="Boot screen restored."
    fi
}

function eordRecoveryMode {
    #TODO - make this automatic, no user input, rewrite sed
    if (whiptail --title $TITLE --yesno "Is recovery mode enabled or disabled?" 10 60) then
        sudo sed -i "s,#GRUB_DISABLE_RECOVERY,GRUB_DISABLE_RECOVERY,g" /etc/default/grub
        sudo update-grub
        RESMSG="Recovery mode'nt!"
    else
        sudo sed -i "s,GRUB_DISABLE_RECOVERY,#GRUB_DISABLE_RECOVERY,g" /etc/default/grub
        sudo update-grub
        RESMSG="Recovery mode restored."
    fi
}

function setupZnZIM {
    sudo apt install zsh
    chmod +x ./ZSetup.sh
    ./ZSetup.sh
    su -c ./ZSetup.sh
    RESMSG="Let'Z go!"
}

preStart

whiptail --title $TITLE --msgbox "Welcome to UbuntuSetup! Let's get started!" 8 46

while true
do
CHOICE=$(
whiptail --title $TITLE --menu "What do ya want to do? Select an option:" 21 60 13 \
	"1." "Setup Proxy for apt" \
	"2." "Update packages" \
	"3." "Install another desktop environment" \
	"4." "Uninstall default desktop environment" \
	"5." "Install display and terminal fonts" \
	"6." "Install a IDE or advanced text editor" \
	"7." "Beautify your system" \
	"8." "Set root password" \
	"9." "Remove snap applications and snapd" \
	"10." "Remove bloat and tracking" \
	"11." "Clean up packages" \
	"12." "Install preferred applications" \
	"13." "Install restricted extras" \
	"14." "Set up IDE extensions (for VS Code only)" \
	"15." "Enable/disable boot screen" \
    "16." "Enable/disable recovery mode" \
    "17." "Setup Z Shell and ZIM Framework" \
	"99." "Exit"  3>&2 2>&1 1>&3
)

RESMSG=""
case $CHOICE in
	"1.") setupProxy
	;;
	"2.") updatePackages
	;;
	"3.") installNewDE
	;;
	"4.") uninstallDefaultDE
	;;
	"5.") installFonts
	;;
	"6.") installIDE
	;;
	"7.") sysBeaut
	;;
	"8.") rootPass
	;;
	"9.") rmSnapnSApps
	;;
	"10.") rmBloatnTrack
	;;
	"11.") cleanupPackage
	;;
	"12.") installFavApps
	;;
	"13.") installRE
	;;
	"14.") setupIDEExtras
	;;
	"15.") eordBootScreen
	;;
	"16.") eordRecoveryMode
	;;
	"17.") setupZnZIM
	;;
	"99.") 
    whiptail --title $TITLE --msgbox "Buhbye!" 8 70
    clear
    exit
	;;
esac
whiptail --title $TITLE --msgbox "$RESMSG" 8 70
done