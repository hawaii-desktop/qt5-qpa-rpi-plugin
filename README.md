# Qt 5 QPA rpi plugin

This QPA allows rendering on Broadcom GPU even when qtbase is not built
for Raspberry Pi which is the case with some general purpose distributions.

## Build requirements

* Qt 5 devel package
* Broadcom drivers in /opt/vc

## How to build and install

```sh
cd eglfs_rpi
qmake-qt5
make
sudo make install
```

## ArchLinux

Make sure you have the following packages installed:

* raspberrypi-firmware
* raspberrypi-firmware-bootloader
* raspberrypi-firmware-tools

## How to use it

Run this command for tests:

```sh
QT_QPA_EGLFS_DEBUG=1 qmlscene -platform eglfs_rpi <filename>.qml
```

Replace <filename> with the actual name of a QML file.
