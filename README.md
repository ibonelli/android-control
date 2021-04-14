# android-control

Small script to control an Android device with some image recognition decision based on OpenCV

## Install

### On Debian 10

Required packages:

```
sudo apt install adb android-tools-adb android-tools-fastboot android-sdk-platform-tools-common
sudo apt install python3 python3-numpy python3-matplotlib python3-opencv libopencv-dev
```

### Opencv-python building (before Debian 10):

```
cmake
pip3 install scikit-build
pip3 install opencv-python
```

## Using

First make sure your connection to the device works by running the following commands:

```
adb devices
adb shell
```

Then you can run the app:

```
. control_device.sh
```

## Some notes on how this came to be

[stackoverflow, android, and more...](./control_device.md)
