#!/bin/bash

APP_PATH="/home/ignacio/Nextcloud/Android-Celus/MotoG4/"
CMD="python3 ${APP_PATH}find_img_v2.py"
HOME="/home/ignacio/Nextcloud/Android-Celus/MotoG4/launch_icon.png"
CLOSE="/home/ignacio/Nextcloud/Android-Celus/MotoG4/x_filtered.png"
HOME_COORDS="869 1003"
RUNS=1
RESULT=1

function verify_homescreen {
	## We verify we land back into the homescreen
	adb shell screencap -p /sdcard/Download/screencap.png ; adb pull /sdcard/Download/screencap.png
	sleep 1
	FOUND_COORDS=`${CMD} ${HOME}`
	if [[ ${HOME_COORDS} == ${FOUND_COORDS} ]]
	then
		return 1
	else
		return 0
	fi
}

function get_reward {
	# screencap01.png - Shell home2 (games folder)
	adb shell input tap 935 1050
	sleep 1

	# screencap02.png - Open Bricks
	adb shell input tap 420 1040
	sleep 8

	# screencap03.png - Close advertisement
	adb shell input tap 1023 56
	sleep 3

	# screencap04.png - Click ad to open
	adb shell input tap 380 310
	sleep 40

	# Find the closing X position
	adb shell screencap -p /sdcard/Download/screencap.png ; adb pull /sdcard/Download/screencap.png
	sleep 1
	POS=`${CMD} ${CLOSE}`
	sleep 2

	# screencap04.png - Find the closing X position
	adb shell input tap ${POS}
	sleep 5

	### Click power to close app
	#adb shell input tap 973 115
	#sleep 3

	### Confirm closing the app
	#adb shell input tap 785 1565
	#sleep 3

	# Replacing "Click power to close app" & "Confirm closing the app"
	# This is a more direct approach, just kill the app
	adb shell am force-stop com.mobirix.swipebrick
	sleep 3

	verify_homescreen
	RESULT=$?
	return ${RESULT}
}

while [[ 1 == ${RESULT} ]]
do
	echo "---> Fetching reward. Iteration "${RUNS}
	get_reward
	RESULT=$?
	sleep 2
	((RUNS=RUNS+1))
	if [ 1 != ${RESULT} ]
	then
		echo "  ---> Recovering to homescreen..."
		# If we are not at home screen we try to recover and check again
		# We try to kill the app
		adb shell am force-stop com.mobirix.swipebrick
		# We command to go to homescreen
		adb shell am start -W -c android.intent.category.HOME -a android.intent.action.MAIN
		sleep 3
		verify_homescreen
		RESULT=$?
	fi
done

echo "Finishing as we are no longer at homescreen."
