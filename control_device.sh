# ----------------
# Moto G4
# ----------------

#adb devices

# screencap01.png - Shell home2 (games folder)
adb shell input tap 935 1050
sleep 1
# screencap02.png - Open Bricks
adb shell input tap 420 1040
sleep 10
# screencap03.png - Close advertisement
adb shell input tap 1023 56
sleep 1
# screencap04.png - Click ad to open
adb shell input tap 380 310
sleep 45
# screencap05a.png - Playing the ad and wait...
# screencap05b.png - Finished the ad, ready to close! (right)
adb shell input tap 1015 65
# screencap05c.png - Finished the ad, ready to close! (left)
adb shell input tap 65 65
sleep 2
# screencap04.png - Click power to close app
adb shell input tap 973 115
sleep 1
# screencap04.png - Confirm closing the app
adb shell input tap 785 1565
