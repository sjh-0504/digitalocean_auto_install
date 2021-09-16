#!/usr/bin/bash

MYUSER="root"
con=$(doctl compute droplet list "$1*" --format "PublicIPv4")
ip=$(grep -oP '([0-9]{1,3}\.){1,3}[0-9]{1,3}' <<< $con)

arr=(${ip//,/})

echo ${arr[@]}

mkdir /vagrant/peiz/$1

for n in ${arr[@]};do
	./wireguard_install $n
	sleep 40
	echo -e "done\n"
	scp $MYUSER@$n:/etc/wireguard/client.conf /vagrant/peiz/$1/$n.conf
done

for m in ${arr[@]};do
	if [ -r "/vagrant/peiz/$1/$m.conf" ];then
		scp $MYUSER@$m:/etc/wireguard/client.conf /vagrant/peiz/$1/$m.conf
	fi	
done
