# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Custom kernel for realme GT Neo 3
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=boot
is_slot_device=1
ramdisk_compression=auto

## AnyKernel methods (DO NOT CHANGE)
. tools/ak3-core.sh

kernel_version=$(cat /proc/version | awk -F '-' '{print $1}' | awk '{print $3}')
case $kernel_version in
    4.1*) ksu_supported=true ;;
    5.1*) ksu_supported=true ;;
    6.1*) ksu_supported=true ;;
    6.6*) ksu_supported=true ;;
    *) ksu_supported=false ;;
esac

ui_print " "
ui_print "================================"
ui_print " Zephyr Kernel — GT Neo 3"
ui_print "================================"
ui_print " "
ui_print "Kernel version: $kernel_version"
ui_print "GKI supported: $ksu_supported"

if [ -f "$home/ROOT" ]; then
    root_impl=$(cat "$home/ROOT")
    ui_print "Root implementation: $root_impl"
else
    ui_print "Root implementation: Not specified"
fi

if [ -f "$home/MANAGER" ]; then
    ui_print "Kernel manager: $(cat "$home/MANAGER")"
fi

ui_print " "
ui_print "Flashing kernel..."
ui_print " "

## AnyKernel install
if [ -L "/dev/block/bootdevice/by-name/init_boot_a" ] || [ -L "/dev/block/by-name/init_boot_a" ]; then
    split_boot
    flash_boot
else
    dump_boot
    write_boot
fi

ui_print " "
ui_print "================================"
ui_print " Kernel installation complete"
ui_print "================================"
## end install
