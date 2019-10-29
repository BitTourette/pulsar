#!/bin/bash

# Check the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "jackd2 install error: must be run as root, will now exit"
   exit 1
fi

function jackd2_install()
{
	apt-get update
	apt-get install -y jackd2
	sh -c "echo @audio - memlock 256000 >> /etc/security/limits.conf"
	sh -c "echo @audio - rtprio 75 >> /etc/security/limits.conf"
}

function aubio_install()
{
	apt-get update
	apt-get install -y git aubio-tools libaubio-dev libaubio-doc aubio
}

function a2jmidid_install()
{
	apt-get update
	apt-get install -y a2jmidid
}

function jackmeter_install()
{
	apt-get update
	apt-get install -y jackmeter
}

function pulsar_install
{
	chmod +x pulsar
	cp pulsar /etc/init.d/
	update-rc.d pulsar defaults
}

jackd2_install
aubio_install
a2jmidid_install
jackmeter_install
pulsar_install
