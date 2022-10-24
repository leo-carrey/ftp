#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install proftpd*

echo "<Anonymous ~ftp>;User ftp;Group nogroup;UserAlias anonymous ftp;DirFakeUser on ftp;DirFakeGroup on ftp;RequireValidShell off;MaxClients 10;DisplayLogin welcom.msg;DisplayChdir .message;<Directory *>;	<Limit WRITE>;		DenyAll;	</limit>;</Directory>;</Anonymous>" nvproftpd
echo "Include /etc/nvproftpd" >> /etc/proftpd/proftpd.conf

cd /etc/proftpd/
sudo mkdir ssl
cd ssl/

sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 -out proftpd-rsa.pem -keyout proftpd-key.pem -passin pass "" \
	-subj '/C= /ST= /L= /O= /OU= /CN= /emailAddress= '
chmod 760 proftpd-key.pem

echo "done"
