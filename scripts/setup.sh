#!/usr/bin/env bash

set -e

SETUP_TEMP_FOLDER=/tmp/setup-script

function start {
	log-title "Starting"
	create-temp-folder
	log-sep
	
	log-title "Installing apt keys"
	install-apt-key "https://download.sublimetext.com/sublimehq-pub.gpg"
	install-apt-key "https://packages.microsoft.com/keys/microsoft.asc"
	install-apt-key "https://dbeaver.io/debs/dbeaver.gpg.key"
	log-sep

	log-title "Installing repositories"
	install-apt-repository "sublime-text" 	"deb https://download.sublimetext.com/ apt/stable/"
	install-apt-repository "vscode" 		"deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	install-apt-repository "dbeaver" 		"deb https://dbeaver.io/debs/dbeaver-ce /"
	# https://linux.dropboxstatic.com/ubuntu/dists/cosmic/ ?
	install-ppa "ppa:phoerious/keepassxc"
	log-sep

	log-title "Pinning packages"
	pin-package "keepassxc" 	"release o=LP-PPA-phoerious-keepassxc"
	pin-package "dbeaver-ce" 	"origin dbeaver.io"
	log-sep

	log-title "Refreshing packages"
	install-repository-addition-dependencies
	log-sep
	log-step "apt update..."
	apt-get update > /dev/null
	log-sep

	log-title "Installing packages"
	apt-get install -y vim keepassxc gnome-shell-extension-appindicator sublime-merge sublime-text python3-gpg gnome-tweaks dbeaver-ce code
	log-sep

	# title "Installing Dropbox"
	# wget -O /tmp/setup-script/dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2019.02.14_amd64.deb
	# apt install -y /tmp/setup-script/dropbox.deb

	log-title "Cleaning up"
	clean-temp-folder
}

function create-temp-folder {
	log-step "Creating temporal folder for setup in '${SETUP_TEMP_FOLDER}'"
	mkdir -p $SETUP_TEMP_FOLDER
}

function clean-temp-folder {
	rm -rf $SETUP_TEMP_FOLDER
}

function install-repository-addition-dependencies {
	log-step "Installing 'apt-transport-https'"
	apt-get install -y apt-transport-https > /dev/null
}

function install-apt-key {
	log-step "Installing apt key '${1}'"
	curl -s "${1}" | apt-key add -
}

function install-apt-repository {
	ID=${1}
	CONF=${2}
	log-step "Installing apt repository ${ID}"
	printf "${CONF}\n" > /etc/apt/sources.list.d/${ID}.list
}

function install-ppa {
	log-step "Installing ppa repository ${1}"
	add-apt-repository -yn "${1}"
}

function pin-package {
	PACKAGE_NAME=${1}
	MATCHER=${2}
	log-step "Pinning package ${PACKAGE_NAME}"
	printf "Package: ${PACKAGE_NAME}\nPin: ${MATCHER}\nPin-Priority: 2000\n" > /etc/apt/preferences.d/pin-${PACKAGE_NAME}
}

function log-title {
	echo "########################## ${1}"
}

function log-sep {
	echo ""
}

function log-step {
	echo "${1}"
}

start
