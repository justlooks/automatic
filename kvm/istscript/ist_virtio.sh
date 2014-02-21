# install guest use local iso file and local ks file,enable virtio net and disk

virt-install --connect qemu:///system \
--name mytest --ram 512 --vcpus=1 --nographics \
--location /opt/rhel-server-6.2-x86_64-dvd.iso --initrd-inject=/var/www/html/ks/ks_tmpl.cfg \
--extra-args="ks=file:/ks_tmpl.cfg ksdevice=eth0 ip=192.168.11.126 netmask=255.255.255.0 HOSTNAME=lvsmaster console=tty0 utf-8 console=ttyS0,115200" \
--disk path=/opt/test.qcow2,size=10,bus=virtio,cache=none,format=qcow2 \
--os-type linux --accelerate \
--network bridge=virbr0,model=virtio,mac=52:54:00:30:01:E8
