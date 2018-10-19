from matplotlib import pyplot as plt
import csv
import numpy as np
import numpy_indexed as npi

x_1 = []
y_1 = []
x_2 = []
y_2 = []


with open('hpxMP_firstpriv_ben.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_1.append(float(row[0]))
        y_1.append(float(row[1]))

with open('openMP_firstpriv_ben.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_2.append(float(row[0]))
        y_2.append(float(row[1]))

# x = np.concatenate([x_1, x_2, x_3])
# y = np.concatenate([y_1, y_2, y_3])
# x_unique, y_mean = npi.group_by(x).mean(y)
#
# x = np.concatenate([x_4, x_5, x_6])
# y = np.concatenate([y_4, y_5, y_6])
# x_unique_1, y_mean_1 = npi.group_by(x).mean(y)

plt.plot(x_1,y_1, label='hpxMP')
plt.plot(x_2,y_2, label='openMP')
plt.xlabel('Number of threads')
plt.ylabel('time in microsecondes')
plt.title('overhead comparision between openMP and hpxMP')
plt.legend()
plt.show()
