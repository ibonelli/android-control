#!/bin/bash

APP_PATH="./"
SCREENCAP_PATH="./downloads"
CMD="python3 ${APP_PATH}find_img.py"
HOME="./imgs/launch_icon.png"
CLOSE1="./imgs/x_filtered_v1.png"
CLOSE2="./imgs/x_filtered_v2.png"
CLOSE3="./imgs/x_filtered_v3.png"
NOT_FOUND="NoPosition"
RUNS=1
RESULT=1

function verify_homescreen {
	## We verify we land back into the homescreen
	pushd ${SCREENCAP_PATH}
	adb shell screencap -p /sdcard/Download/screencap.png ; adb pull /sdcard/Download/screencap.png
	popd
	sleep 1
	FOUND_COORDS=`${CMD} ${HOME}`
	if [[ ${HOME_COORDS} == ${NOT_FOUND} ]]
	then
		return 0
	else
		return 1
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
	pushd ${SCREENCAP_PATH}
	adb shell screencap -p /sdcard/Download/screencap.png ; adb pull /sdcard/Download/screencap.png
	popd
	sleep 1
	POS=`${CMD} ${CLOSE1}`
	if [[ ${POS} == ${NOT_FOUND} ]]
	then
		POS=`${CMD} ${CLOSE2}`
		if [[ ${POS} == ${NOT_FOUND} ]]
		then
			POS=`${CMD} ${CLOSE3}`
		fi
	fi
	sleep 2

	# screencap04.png - Find the closing X position
	if [[ ${POS} == ${NOT_FOUND} ]]
	then
		echo "Could not find the image..."
	else
		adb shell input tap ${POS}
	fi
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

mkdir -p ${SCREENCAP_PATH}

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
