# Emulator for x86 and PowerPC augmented with a power of VirGL

> this repository is inspired by and based on
> https://github.com/knazarov/homebrew-qemu-virgl
> thank you for your work, @knazarov

## Installation

### Usage - Intel Macs

assume you already have `rootfs.qcow2` image

```sh
qemu-system-x86_64 \
    -machine q35,accel=hvf \
    -cpu host \
    -smp 2 \
    -m 4G \
    -netdev vmnet-shared,id=vmnet0 \
    -device virtio-net-pci,netdev=vmnet0 \
    -device virtio-vga-gl \
    -device virtio-keyboard-pci \
    -device virtio-tablet-pci \
    -display cocoa,gl=es \
    -chardev qemu-vdagent,id=spice,name=vdagent,clipboard=on \
    -device virtio-serial-pci \
    -device virtserialport,chardev=spice,name=com.redhat.spice.0 \
    -virtfs local,path=/Users,mount_tag=Users,id=vfs0,security_model=none \
    -hda rootfs.qcow2 \
    -full-screen

```
