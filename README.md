# rtl8189fs dkms kernel module for armbian current meson64

## Motivation

My gxl-p212 based tv box comes with rtl8188ftv sdio wifi chip.

Unfortunately, with the release of kernel 6.12.22-current, the 8189fs kernel module which the wifi chip needs no longer comes with the kernel package.

So, I build an out of tree kernel module using github-actions to make it easy for me and others to use.

## How to use

Get the resulting dkms tarball from the release page and load it.

```sh
MODVER='0.0.1'
KVER="6.12.22-current-meson64-arm64"
dkms ldtarball rtl8189fs-"$MODVER"-kernel"$KVER".dkms.tar.gz
modprobe -f 8189fs
```

To remove excessive kernel module log

```sh
echo 'options 8189fs rtw_power_mgnt=0 rtw_enusbss=0 rtw_drv_log_level=0' > /etc/modprobe.d/8189fs.conf
```

More options can be found via modinfo.

```sh
modinfo 8189fs
```

## Acknowledgements

Thanks to @jwrdegoede for the 8189fs kernel module and Github for providing github-actions compute time on arm64 native.
