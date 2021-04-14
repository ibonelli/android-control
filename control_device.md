# Manejando el celu desde la PC

```
adb devices
adb shell
athene_f:/ $ exit
```

## android touch clicks using adb (basic)
- https://stackoverflow.com/questions/3437686/how-to-use-adb-to-send-touch-events-to-device-using-sendevent-command
- https://source.android.com/devices/input/touch-devices

```
adb shell input tap 757 1694
```

## How to Capture Screenshot and Record Screen using ADB
- https://www.learn2crack.com/2014/08/capture-screenshot-record-screen-using-adb.html

```
adb shell screencap -p /sdcard/Download/screencap.png ; adb pull /sdcard/Download/screencap.png
```

## How do I keep my screen unlocked during USB debugging?
- https://stackoverflow.com/questions/8840954/how-do-i-keep-my-screen-unlocked-during-usb-debugging

This is:

1. Go to Settings > About phone
1. Touch several times (about 10 times) on "Build number".
1. Then go back to Sttings menu and you'll find the "Developer options"
1. Under "Developer Options", you will see "stay awake option ".

## Android touch clicks using adb (advance)
- https://igor.mp/blog/2018/02/23/using-adb-simulate-touch-events.html

```
$ adb shell

athene_f:/ $ getevent -l
	add device 1: /dev/input/event7
	  name:     "Rear proximity sensor"
	...
	add device 8: /dev/input/event2
	  name:     "synaptics_dsx_i2c"
```

This keeps running and if for example we touch the screen somewhere we'll get something like:

```
/dev/input/event2: EV_SYN       0004                 00247411            
/dev/input/event2: EV_SYN       0005                 3207db60            
/dev/input/event2: EV_ABS       ABS_MT_TRACKING_ID   00009ff1            
/dev/input/event2: EV_ABS       ABS_MT_POSITION_X    000003a7            
/dev/input/event2: EV_ABS       ABS_MT_POSITION_Y    0000041f            
/dev/input/event2: EV_ABS       ABS_MT_PRESSURE      00000044            
/dev/input/event2: EV_ABS       ABS_MT_TOUCH_MAJOR   00000044            
/dev/input/event2: EV_SYN       SYN_REPORT           00000000            
/dev/input/event2: EV_SYN       0004                 00247411            
/dev/input/event2: EV_SYN       0005                 3783b1f0            
/dev/input/event2: EV_ABS       ABS_MT_TRACKING_ID   ffffffff            
/dev/input/event2: EV_SYN       SYN_REPORT           00000000            
```

Take notice of the values taken from: ```ABS_MT_POSITION_X and ABS_MT_POSITION_Y```
Those are the coordinates for your X and Y axis in hexadecimal: ```x: 0x3a7 and y: 0x41f```
Which translate to ```x: 935 and y: 1055``` in decimal

We could also do a screen "slide" of the main window to the secondary/right one and we'll get much more data.

A more direct approach would be to simply capture the raw input information by doing:

```
$ dd if=/dev/input/event2 of=/sdcard/Download/record1
```

Which we could reproduce (byte-for-byte) by doing:

```
$ dd if=/sdcard/Download/record1 of=/dev/input/event2
```

The problem with this is that it will reproduce all inputs recorded without any delay between each "command".

Also tried doing:

```
$ adb pull /sdcard/Download/record1
```

But the result is binary and really difficult to read. So I used the approach you can see in the bash script.

## Stopping an Android app from console
- https://stackoverflow.com/questions/3117095/stopping-an-android-app-from-console

```
adb shell ps | grep com | grep bri
```

Output:

```
u0_a256   26514 576   2041320 290664 SyS_epoll_ 00000000 S com.mobirix.swipebrick
```

I get the name/"domain" of the running application I want to "kill" and then do:

```
adb shell am force-stop com.mobirix.swipebrick
```

# Different approaches I reviewed

- [adb python appium](http://appium.io/docs/en/commands/mobile-command/)
- [android python control via adb](https://pypi.org/project/pure-python-adb/)

# adb-shell-input-events
- https://stackoverflow.com/questions/7789826/adb-shell-input-events

Insert text:

```
adb shell input text "insert%syour%stext%shere"
```

In this context the "%s" means/gets-translated into SPACE character.

Event codes:

```
adb shell input keyevent 82
```

Where 82 is the MENU_BUTTON. Here you have the [full keyevents codes see list](http://developer.android.com/reference/android/view/KeyEvent.html).

## Some examples

**Tap X,Y position:**

```
adb shell input tap 500 1450
```

To find the exact X,Y position you want to Tap go to: Settings > Developer Options > Check the option POINTER SLOCATION

**Swipe X1 Y1 X2 Y2 [duration(ms)]:**

```
adb shell input swipe 100 500 100 1450 100
```

in this example X1=100, Y1=500, X2=100, Y2=1450, Duration = 100ms

**LongPress X Y:**

```
adb shell input swipe 100 500 100 500 250
```

We utilise the same command for a swipe to emulate a long press. In this example X=100, Y=500, Duration = 250ms
