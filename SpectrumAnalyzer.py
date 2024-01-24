import serial
import matplotlib.pyplot as plt
import numpy as np
import time

POINTS = 1200 # number of samples
S_FREQ = 44210 # Hz
NYQ_FREQ = S_FREQ / 2 # Nyquist frequency (22105 Hz)
X_SCALE_MULTIPLIER = NYQ_FREQ / (POINTS / 2)

def bin_decode(data):
    #data = b'\x1C\x05'
    a = data[0] + (data[1] << 8)
    length = len(bin(a))
    x = 0
    for i in range(length-2):
        x = x + int(bin(a)[(length-1)-i]) * pow(2,-11+i)

    return x;

def draw_graph():
    x = np.linspace(0,600, num=601) * X_SCALE_MULTIPLIER
    sample = np.linspace(0.5,0.5, num=601)

    fig, ax1 = plt.subplots()
    line, = ax1.plot([], lw=1)
    line.set_data(x, sample)
    text = ax1.text(0, 1.02, "")

    ax1.set_xlim([0, 22105])
    #ax1.set_xlim([0, 22105/2]) # half
    ax1.set_ylim([0, 1])
    ax1.set_xlabel('Frequency, Hz')
    ax1.set_ylabel('Amplitude')
    ax1.set_yticks(np.linspace(0,1, num=11))
    ax1.grid()
    
    fig.canvas.draw()   # note that the first draw comes before setting data 
    plt.show(block=False)
    fig.canvas.flush_events()

    while (True):
        start = time.time()
        ser_data = ser.read(1203)
        sample = []
        multiplier = 2**ser_data[0] / 1200 * 2
        for i in range(1,1203,2):
            sample.append(bin_decode(ser_data[i:i+2]) * multiplier)
        line.set_data(x, sample)

        
        # redraw everything
        fig.canvas.draw()
        fig.canvas.flush_events()
        tx = '{:.2f} fps'.format(1 / (time.time() - start))
        text.set_text(tx)
        
ser = serial.Serial('COM10', 3000000)
draw_graph()

ser.close();
print("done")
