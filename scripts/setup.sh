#!/usr/bin/env bash

set -e

function start {
	mkdir -p /tmp/setup-script
	
	title "Installing repositories"
	apt install -y apt-transport-https
	vscode-repo
	sublime-repo
	keepassxc-repo
	apt update

	title "Priorizing repositories for packages"
	touch /etc/apt/preferences.d/extra-settings
	keepassxc-pin
	apt update

	title "Installing packages"
	apt install -y vim keepassxc gnome-shell-extension-appindicator sublime-merge sublime-text python3-gpg gnome-tweaks

	title "Installing Dropbox"
	wget -O /tmp/setup-script/dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2019.02.14_amd64.deb
	apt install -y /tmp/setup-script/dropbox.deb

	title "Cleaning up"
	rm -rf /tmp/setup-script
	echo "Done!"
}

function sublime-repo {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
}

function vscode-repo {
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/setup-script/microsoft.gpg
	install -o root -g root -m 644 /tmp/setup-script/microsoft.gpg /etc/apt/trusted.gpg.d/
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
}

function keepassxc-repo {
	add-apt-repository -y ppa:phoerious/keepassxc
}

function keepassxc-pin {
	echo "Package: keepassxc\nPin: release o=LP-PPA-phoerious-keepassxc\nPin-Priority: 2000\n\n" > /etc/apt/preferences.d/extra-settings
}

function title {
	echo "########################## ${1}"
}

start
