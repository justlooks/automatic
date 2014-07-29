virt-install --connect qemu:///system \
--name docker --ram 2048 --vcpus=1  \
--graphics none \
--location ftp://192.168.10.207/centos6_5 --initrd-inject=/opt/ks/ks_tmpl.cfg \
--extra-args="ks=file:/ks_tmpl.cfg ksdevice=eth0 ip=192.168.10.188 netmask=255.255.255.0 HOSTNAME=docker HOSTIP=192.168.10.246 text console=tty0 utf8 console=ttyS0,115200" \
--disk path=/vdisk/alex3.img,device=disk,bus=virtio,cache=none \
--network bridge=br0,model=virtio,mac=52:54:BA:30:01:F8 \
--os-type linux --accelerate

