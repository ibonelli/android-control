import cv2
import numpy as np
from matplotlib import pyplot as plt
import sys

if(len(sys.argv) < 2):
	print('Missing input file...')
	exit(-1)
else:
	fname = sys.argv[1]
	# '/home/ignacio/Nextcloud/Android-Celus/MotoG4/x_filtered.png'
	# '/home/ignacio/Nextcloud/Android-Celus/MotoG4/launch_icon.png'
	#screencap = './screencap.png'
	screencap = '/home/ignacio/Downloads/KINGSTON/Android/screencap.png'

img = cv2.imread(screencap, cv2.IMREAD_GRAYSCALE)
template = cv2.imread(fname, cv2.IMREAD_GRAYSCALE)

# Better possible match, siendo:
#	max_val el valor de "threshold" que dió y max_loc la pos en X,Y donde ocurrió

res = cv2.matchTemplate(img,template,cv2.TM_CCOEFF_NORMED)
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(res)

if max_val >= 0.9:
	print(str(max_loc[0]) + " " + str(max_loc[1]))
else:
	print("Couldn't not find image with a certainty level > 0,9")
