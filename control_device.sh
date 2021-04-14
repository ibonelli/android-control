#!/bin/bash

APP_PATH="/home/ignacio/Nextcloud/Android-Celus/MotoG4/"
CMD="python3 ${APP_PATH}find_x.py"

# screencap01.png - Shell home2 (games folder)
adb shell input tap 935 1050
sleep 1

# screencap02.png - Open Bricks
adb shell input tap 420 1040
sleep 10

# screencap03.png - Close advertisement
adb shell input tap 1023 56
sleep 10

# screencap04.png - Click ad to open
adb shell input tap 380 310
sleep 45

# Find the closing X position
adb shell screencap -p /sdcard/Download/screencap.png ; adb pull /sdcard/Download/screencap.png
sleep 1
POS=`${CMD}`
sleep 2

# screencap04.png - Find the closing X position
adb shell input tap ${POS}
sleep 5

## screencap04.png - Click power to close app
adb shell input tap 973 115
sleep 3

## screencap04.png - Confirm closing the app
adb shell input tap 785 1565
