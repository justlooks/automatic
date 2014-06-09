#使用远程 VNC安装 

virt-install --connect qemu:///system \
--name math --ram 2048 --vcpus=1 --graphics vnc \
--cdrom /vdisk2/ubuntu-14.04-desktop-amd64.iso \
--disk path=/vdisk2/mathubuntu.img,size=20,bus=virtio,cache=none,format=qcow2 \
--os-type linux --accelerate \
--network bridge=virbr0,model=virtio,mac=52:54:00:30:03:E8

执行输出
-------------------

Starting install...
Creating domain...                                                                                                                               |    0 B     00:00
WARNING  Unable to connect to graphical console: virt-viewer not installed. Please install the 'virt-viewer' package.
Domain installation still in progress. You can reconnect to
the console to complete the installation process.

通过远程virt-viewer连接ip:5901 即可执行安装

