digitalocean安装wiregurad脚本说明
=================================
前置
---------------------
需在本地安装doct1，和expect
安装expect：Centos系统yum install expect -y或Ubuntu系统apt-get install expect -y

安装doct1：curl -sL https://github.com/digitalocean/doctl/releases/download/v<version>/doctl-<version>-linux-amd64.tar.gz | tar -xzv

ssh_start_install.sh
---------------------
自动获取ip，传递给wireguard_install进行连接安装，后拷贝配置文件至本地
wireguard_install
-----------------
ssh连接digitalocean上的vps下载wireguard安装脚本并执行，安装完成后重启