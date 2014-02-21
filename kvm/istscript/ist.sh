#install guest use local iso
virt-install --connect qemu:///system \
--name centos2 --ram 512 --vcpus=1 --nographics \
--cdrom /vdisk/CentOS-6.5-x86_64-bin-DVD1.iso \
--disk path=/vdisk/centos2.img,size=10 \
--os-type linux --accelerate --hvm 

