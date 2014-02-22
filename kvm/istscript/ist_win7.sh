#install
/usr/libexec/qemu-kvm -drive file=/dev/sdb7,if=virtio,cache=none -cdrom X17-59297.iso -smp 1 -boot d -m 4G -vnc :2 -usb -usbdevice tablet -soundhw es1370 -net nic,vlan=0,macaddr=52:54:00:94:78:D7,model=virtio -net tap,vnet_hdr=on,vhost=on -name "win7"
