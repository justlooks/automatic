#install
/usr/libexec/qemu-kvm -drive file=/vdisk/wxp_qcow2.img,if=virtio,cache=none -cdrom winxp_withvirtio.iso -smp 1 -boot d -m 4G -vnc :2 -usb -usbdevice tablet -soundhw es1370 -net nic,vlan=0,macaddr=52:54:00:94:78:C8,model=virtio -net tap,vnet_hdr=on,vhost=on -name "winxp"#install
