#!/usr/bin/bash

MYUSER="root"
con=$(doctl compute droplet list "$1*" --format "PublicIPv4")
ip=$(grep -oP '([0-9]{1,3}\.){1,3}[0-9]{1,3}' <<< $con)

arr=(${ip//,/})

echo ${arr[@]}
load="/vagrant/peiz/$1"

mkdir $load

for n in ${arr[@]};do
	./wireguard_install $n
	sleep 40
	echo -e "done\n"
	scp $MYUSER@$n:/etc/wireguard/client.conf $load/$n.conf
done

for m in ${arr[@]};do
	if [ -r "/vagrant/peiz/$1/$m.conf" ];then
		scp $MYUSER@$m:/etc/wireguard/client.conf $load/$m.conf
	fi	
done
