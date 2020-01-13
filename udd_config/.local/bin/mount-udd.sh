#!/bin/bash
if ping -c 1 sabre.irisa.fr &> /dev/null
then
  sshfs -o reconnect -C kchoi@sabre.irisa.fr:/udd/kchoi /udd/kchoi
  sshfs -o reconnect -C kchoi@sabre.irisa.fr:/temp_dd/igrida-fs1/kchoi /temp_dd/igrida-fs1/kchoi
fi
