from matplotlib import pyplot as plt
import csv
import numpy as np
import numpy_indexed as npi

x_1 = []
y_1 = []
x_2 = []
y_2 = []
x_3 = []
y_3 = []
x_4 = []
y_4 = []
x_5 = []
y_5 = []
x_6 = []
y_6 = []

with open('fft_result_hpxmp_1th_run.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_1.append(float(row[0]))
        y_1.append(float(row[1]))

with open('fft_result_hpxmp_2th_run.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_2.append(float(row[0]))
        y_2.append(float(row[1]))

with open('fft_result_hpxmp_3th_run.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_3.append(float(row[0]))
        y_3.append(float(row[1]))

with open('fft_result_openmp_1th_run.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_4.append(float(row[0]))
        y_4.append(float(row[1]))

with open('fft_result_openmp_2th_run.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_5.append(float(row[0]))
        y_5.append(float(row[1]))

with open('fft_result_openmp_3th_run.txt', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x_6.append(float(row[0]))
        y_6.append(float(row[1]))

x = np.concatenate([x_1, x_2, x_3])
y = np.concatenate([y_1, y_2, y_3])
x_unique, y_mean = npi.group_by(x).mean(y)

x = np.concatenate([x_4, x_5, x_6])
y = np.concatenate([y_4, y_5, y_6])
x_unique_1, y_mean_1 = npi.group_by(x).mean(y)

plt.plot(x_unique,y_mean, label='hpxmp')
plt.plot(x_unique_1,y_mean_1, label='openmp')
plt.xlabel('Number of threads')
plt.ylabel('time in secondes')
plt.title('Coluculating FFT Performance comparision between hpxmp and openmp')
plt.legend()
plt.show()
