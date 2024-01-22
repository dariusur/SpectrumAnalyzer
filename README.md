# SpectrumAnalyzer
SpectrumAnalyzer is a FPGA based real-time audio spectrum analyzer. It measures the magnitude of an input audio signal versus frequency. The sound waves are converted into an electrical signal via a microphone and then sampled by the FPGA. The sampled data is used to perform Discrete Fourier Transform (DFT) which converts a time domain audio signal into frequency domain. At the end, the processed data is sent to PC via USB and displayed on screen with the help of a Python script.

<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/images/prototype.png" widht="300" height="300">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/images/graph.png" widht="300" height="300">
</div>
<div align="center">
  <i>Fig. 1. One the left: hardware used for the project. On the right: Python script showing measurement of a signal consisting of 1 kHz, 5 kHz and 10 kHz sine waves.</i>
</div>

## Installation
1. Assemble the circuit.
2. Download and extract the repository ZIP file.
3. Program the microcontroller using Microchip Studio.
4. Configure HC-05 Bluetooth module: Slave mode, 9600 baud rate (default settings).
5. Create a Python virtual environment that satisfies the requirements found in **DataVisualizer/requirements.txt**.
6. Attach a magnet to a rotating object to be measured.
7. Power up the tachometer.
8. Switch on Bluetooth on your PC and pair it with HC-05.
9. In the DataVisualizer Python script, configure the COM_PORT and SAVE_DIRECTORY parameters (X_LIMIT and Y_LIMIT are optional).
10. Run the DataVisualizer Python script.
11. Measure RPM.

## Hardware
1. Artix 7 35T Arty FPGA Development Board.
2. Electret microphone.
3. LM358P op-amp X 2.
4. 10k resistor X 2.
5. 51k resistor X 4.
6. 300k resistor.
7. 3.3k resistor.
8. 1k resistor.
9. 5.1k resistor.
10. 100k potentiometer.
11. 1u capacitor.

<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/drawings/external_circuit_schematic.png">
</div>
<div align="center">
  <i>Fig. 2. SpectrumAnalyzer external circuit schematic.</i>
</div>

## How it works?
This project consists of three parts: 
1. External hardware.
2. Internal hardware.
3. Software.


<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/drawings/dataflow_diagram.png">
</div>
<div align="center">
  <i>Fig. 3. Data flow block diagram.</i>
</div>
<br></br>
<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/drawings/internal_circuit_block_diagram.png">
</div>
<div align="center">
  <i>Fig. 4. Internal circuit block diagram.</i>
</div>

### DataVisualizer
DataVisualizer script uses 4 libraries:
1. pyserial for communication with HC-05.
2. matplotlib for data plotting.
3. numpy for temporary data storage in numpy array.
4. pandas for data export to .csv.

Firstly, the script tries to open a serial port over Bluetooth to receive data from HC-05. If it succeeds, then the graph is configured (figure, labels, grid, etc). After that, an empty graph is displayed, and the script enters a loop and waits for data. The received data is converted to RPM and displayed on screen. Finally, after closing the figure window (click X), the script asks if data should be saved to .csv.

## Specifications
* RPM measurement range: 0.017 to 9000000 RPM.

|Resolution|RPM|
|---|---|
|<5|18972|
|<1|8486|
|<0.5|6000|
|<0.1|2683|

* Data rate = 125 samples per second (5000 bits/s)

Resolution depends on CPU clock frequency (1.2 MHz). The greater the frequency, the larger RPM values can be measured, but at a cost of resolution. This characteristic is illustrated in Fig. 5. The graph shows that there are two limits, one is the $f_{cpu}$ limit, which represents the greatest possible RPM value that can be measured. This limit could only be reached if MCU would perform the measurement on every clock cycle. However, instructions take time to execute, and in worst case scenario it takes 4 clock cycles to perform the measurement. This brings us to the other, measurement algorithm limit, which represents the greatest RPM value that the MCU can actually measure. Even though it is possible to measure up to 9000000 RPM, the resolution is so bad that the error is in the order of 100000s of RPM. In addition, there is one more limit which is not shown, which is the 32 bit timer limit, which sets the lowest possible RPM value that can be measured, which is 0.017.

<div align="center">
  <img src="https://github.com/dariusur/BlueTachometer/blob/main/misc/graphs/untitled.png">
</div>
<div align="center">
  <i>Fig. 5. BlueTachometer resolution dependence on RPM. Note that values below 7 RPM are not shown, but the graph should extend toward 0.017 RPM</i>
</div>

## Issues and notes for further development
* Currently there is a reliability issue, because there is no mechanism to track and prevent data loss during transmission. In addition there is no checking which byte of the four byte data packet is being read. When the first byte is being read, it is only assumed that it is the first byte. This leads to incorrect calculation of RPM. It seems like this issue can be avoided if the script is first started and only then the measurement is performed. The only time when this issue was observed is when the script is started during measurement.
* Measures only every other signal period. This issue comes from the fact that Attiny13 has only one timer and it is used for both the measurement and UART communication. If there were at least two timers, then one timer could be dedicated solely for measurement, and instead of stopping, it could simply be reset and continue to measure during communication.
* Data rate is slow. The communication speed could be improved if a greater baud rate was used. Also, pyserial read() function takes quite a significant time to execute (15-32 ms).

