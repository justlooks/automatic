# install guest on disk file image
virt-install --connect qemu:///system \
--name kstest --ram 512 --vcpus=1 --nographics \
--disk path=/vdisk/centos.img,size=10 \
--os-type linux --accelerate --hvm \
--network bridge=br0 \
--location http://192.168.1.24/6.5/x86_64/ \
--extra-args="ks=http://192.168.1.24/6.5/ks/ks_tmpl.cfg ksdevice=eth0 ip=192.168.1.26 netmask=255.255.255.240 dns=8.8.8.8 gateway=192.168.1.88 HOSTNAME=haha HOSTGW=192.168.122.1 HOSTIP=192.166.122.88 console=tty0 utf-8 console=ttyS0,115200" 


