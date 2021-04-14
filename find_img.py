import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('./screencap.png', cv2.IMREAD_GRAYSCALE)
template = cv2.imread('/home/ignacio/Nextcloud/Android-Celus/MotoG4/x_filtered.png', cv2.IMREAD_GRAYSCALE)

# Better possible match, siendo:
#	max_val el valor de "threshold" que dió y max_loc la pos en X,Y donde ocurrió

res = cv2.matchTemplate(img,template,cv2.TM_CCOEFF_NORMED)
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(res)
print(str(max_loc[0]) + " " + str(max_loc[1]))
