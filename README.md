# rtl8189fs kernel module for armbian current meson64

## Motivation

My gxl-p212 based tv box comes with rtl8188ftv sdio wifi chip.

Unfortunately, with the release of kernel 6.12.22-current, the 8189fs kernel module which the wifi chip needs no longer comes with the kernel package.

So, I build an out of tree kernel module using github-actions to make it easy for me and others to use.

## How to use

Get the resulting kernel module from the release page and extract the module somewhere in the `/lib/modules/$(uname -r)` directory, such as `/lib/modules/$(uname -r)/updates/`.

```sh
mkdir /lib/modules/$(uname -r)/updates
tar -C /lib/modules/$(uname -r)/updates -xf rtl8189fs-"$(uname -r)".tar.gz
```

To test the module

```sh
insmod /lib/modules/$(uname -r)/updates/8189fs.ko
depmod -a
```

To remove excessive kernel module log

```sh
echo 'options 8189fs rtw_power_mgnt=0 rtw_enusbss=0 rtw_drv_log_level=0' > /etc/modprobe.d/8189fs.conf
```

More options can be found via modinfo.

```sh
modinfo /lib/modules/$(uname -r)/updates/8189fs.ko
```

## Acknowledgements

Thanks to @jwrdegoede for the 8189fs kernel module and Github for providing github-actions compute time on arm64 native.
