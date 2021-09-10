#!/usr/bin/bash

con=$(doctl compute droplet list "tes*" --format "PublicIPv4")
ip=$(grep -oP '([0-9]{1,3}\.){1,3}[0-9]{1,3}' <<< $con)

arr=(${ip//,/})

echo ${arr[@]}

for n in ${arr[@]};do
	./wireguard_install $n
	scp root@$n:/etc/wireguard/wg0_client /vagrant/peiz/$n.conf
done

