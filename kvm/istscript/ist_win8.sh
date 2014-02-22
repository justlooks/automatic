# install win8
/usr/libexec/qemu-kvm -drive file=/dev/sdb8 -cdrom win8_withvirtio_x86_64.iso -smp 1 -boot c -m 4G -vnc :2 -usb -usbdevice tablet

# start win8
/usr/libexec/qemu-kvm -drive file=/dev/sdb8,if=virtio,cache=none -net nic,vlan=0,macaddr=52:54:00:94:78:e7,model=virtio -net tap,vnet_hdr=on,vhost=on -smp 1 -boot d -m 4G -vnc :2 -usb -usbdevice tablet -name "win8"
