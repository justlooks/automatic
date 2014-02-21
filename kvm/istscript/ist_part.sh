# install guest on disk partition enable disk virtio
virt-install --connect qemu:///system \
--name cobbler --ram 512 --vcpus=1 --nographics \
--disk path=/dev/sda1,bus=virtio,cache=none \
--os-type linux --accelerate \
--network bridge=br0 \
--location http://192.168.1.24/6.5/x86_64/ \
--extra-args="ks=http://192.168.1.24/6.5/ks/ks_tmpl.cfg ksdevice=eth0 ip=192.168.1.16 netmask=255.255.255.0 dns=8.8.8.8 gateway=192.168.1.88 HOSTNAME=cobbler console=tty0 utf-8 console=ttyS0,115200" 
