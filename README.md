# SpectrumAnalyzer
SpectrumAnalyzer is an FPGA-based real-time audio spectrum analyzer. It measures the magnitude of an input audio signal versus frequency. The sound waves are converted into an electrical signal via a microphone and then sampled by the FPGA. The sampled data is used to perform a Discrete Fourier Transform (DFT), which converts a time-domain audio signal into a frequency domain. At the end, the processed data is sent to the PC via USB and displayed on the screen with the help of a Python script.

<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/images/prototype.png" widht="300" height="300">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/images/graph.png" widht="300" height="300">
</div>
<div align="center">
  <i>Fig. 1. One the left: hardware used for the project. On the right: Python script showing measurement of a signal consisting of 1 kHz, 5 kHz and 10 kHz sine waves.</i>
</div>

## Specifications
* Frequency measurement range: 36.84 to 22105 Hz.
* Resolution: 36.84 Hz.
* Data rate: ~37 data frames per second at 3 Mbits/s.
* Adjustable gain: 0 - 909.
* Power source: USB.

Sampling and data processing, with transmission, is done in parallel. When the measurement starts, the hardware responsible for data processing waits for the entire data frame to be collected by the ADC, which takes 27.14 ms. After that, the processing starts, while the ADC proceeds to collect a new data frame. Data processing consists of:
1. Data transmission from RWM (read-write memory) to the DFT core (12 us).
2. DFT core calculation (37.92 us for 1200 points).
3. DFT output storage to RWM (12 us).
4. Data transmission via UART (4.01 ms).
5. Redrawing the graph on the screen (~23 ms).

The time required by each process is depicted graphically in the timing diagram (Fig. 2). The conclusion is that the data rate (frame rate) is determined by the longest process, which is the ADC sampling time. Currently, there are a few issues regarding timing, so be sure to check the "Issues and notes for further development" section below.

<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/drawings/timing_diagram.png" widht="400" height="400">
</div>
<div align="center">
  <i>Fig. 2. Timing diagram (timing bars are not to scale).</i>
</div>
<br></br>

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
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/drawings/external_circuit_schematic_diagram.png">
</div>
<div align="center">
  <i>Fig. 3. SpectrumAnalyzer external circuit schematic diagram.</i>
</div>

## How it works?
The system consists of three parts:
1. External hardware (microphone, amplifier, passive components).
2. Internal hardware (reconfigurable hardware inside the FPGA described by Verilog code).
3. Software (Python script that runs on PC).

### External hardware
External hardware (Fig. 2) is responsible for sound wave conversion into an electrical signal and its conditioning that allows it later to be sampled by electronics. An electret microphone is used for the conversion, which is a parallel plate capacitor, of which the front plate acts as a diaphragm. When the sound waves hit the diaphragm, it vibrates with the signal. The vibrations change the distance between the two plates, which changes the capacitance of the capacitor. This can be detected as a voltage signal. Typically, the signal is very weak. For a person talking normally into the microphone, the signal amplitude can be something like 40 mV peak-to-peak. For weaker sound sources, the amplitude can easily be less than 10 mV peak-to-peak. Such a weak signal first needs to be amplified before it can be sampled by the ADC. The amplification is done with a two-stage amplifier, which consists of two LM358P op-amps. Before the signal is passed to the first stage, the DC component of the signal is blocked with a high-pass filter made from the C1 capacitor and R3 resistor. The R3 resistor here is important because, without it, the capacitor would still retain some bias, which complicates the biasing of op-amps. Since this circuit doesn't work with negative voltages, we need to bias the signal to prevent clipping. After passing the capacitor, the signal is re-biased with R2 and R3 resistors at 2.5 V. The op-amps are also biased at 2.5 V. It means that when there is no sound, each op-amp will output a 2.5 V signal. This is later scaled down to 1.65 V using a voltage divider, which is half of 3.3 V. This is what we need because the FPGA analog pins accept voltages in the range of 0 V - 3.3 V. After passing the first stage, the signal is amplified with a gain of 30. This does not exceed the maximum gain possible given by the gain-bandwidth product for a 20 kHz signal. The second stage amplifier has a variable gain that can be tuned with a potentiometer from 0 to 30.3. The overall gain of the two-stage amplifier is the two gains multiplied together which results in a range of 0 to 909. After the second op-amp, the signal passes through a voltage divider (R10 and R11). The values might seem strange as they do not convert 2.5 V to 1.65 V. This is because there is another voltage divider soldered on the development board itself, which finally scales down the voltage from 3.3 V to 1V. This is the maximum voltage that the ADC can accept. R11 and the on-board voltage divider add together in parallel and create a 2.01 k resistor.

### Internal hardware
Fig. 3 shows a simplified block diagram of the internal hardware. Simplified here means that this is not a 1:1 representation of the actual implementation, which contains a lot more wires and a few other submodules. The purpose of this diagram is just to show the main parts of internal hardware and to give a rough idea of how everything is wired up. Internal hardware, as described by Verilog code, consists of 12 modules:
1. TOP - contains all other modules and makes connections between them.
2. reset_debouncer - debounces reset push button to generate a clean signal.
3. reset_debouncer - debounces start push button to generate a clean signal.
4. FSM_ADC - finite state machine that controls storage of data sampled by ADC and output for further processing.
5. ADC - analog to digital converter, taken from Vivado IP catalog.
6. RWM (FSM_ADC) - read-write memory that stores data sampled by ADC.
7. FSM_DFT_UART - finite state machine that controls storage of DFT calculation result and transmission to PC procedure.
8. DFT - performs discrete Fourier transform, taken from Vivado IP catalog.
9. RWM (FSM_DFT_UART) - read-write memory that stores processed data from DFT.
10. modulus - computes the modulus of a complex number.
11. multiplexer - packs data into 8-bit packets.
12. UART - implements UART protocol and is responsible for data transmission to the on-board FTDI chip.

<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/drawings/internal_circuit_block_diagram.png">
</div>
<div align="center">
  <i>Fig. 4. Internal circuit block diagram (simplified).</i>
</div>
<br></br>
The FPGA is controlled with two on-board push buttons. "BTN0" is the reset button, which stops the measurement and resets the system. "BTN1" is the start button that begins the measurement. When the measurement starts, the ADC will start collecting samples, which are stored in RWM. The storage is controlled by a FSM, which increments the address at which a sample is stored in memory. Once 1200 samples are stored, immediately after, the FSM initiates data transmission to the DFT core. The DFT core accepts real and imaginary data, in this case, only real data is available, so imaginary data is always 0. The DFT computation result, however, will contain imaginary data even if the input of it was 0. The output from DFT is stored in another RWM, which stores 1200 points of real and imaginary data each, as well as the block exponent. The block exponent is the same for the entire frame, so only one memory cell is sufficient to store it. Again, the storage of DFT output data is controlled by another FSM. Once the DFT is done with the data output, the FSM initiates data transmission to the UART module, which sends data to the on-board FTDI chip. Along the way from RWM to the UART chip the data passes through modulus and multiplexer modules. The modulus module computes the modulus of a complex number. It takes only a few clock cycles to compute it and is done when UART is sending data, so there is no delay because of it. The modulus operation essentially combines real and imaginary data, which allows to cut the amount of data transmitted to the PC by half. The multiplexer module packs data into 8-bit packets because the on-board FTDI chip UART interface supports only 7/8 data bits. The UART module sends 12030 bits in total for each data frame (including start and stop bits). This number comes from 601 12-bit data points and a single 4-bit block exponent. Because the imaginary data input to the DFT core is 0, the double-sided FFT spectrum will always be symmetrical around 0 Hz. Therefore, it is sufficient to transmit only half of the modulus computation result, which equals to 601. The additional 1 comes from the fact that this is where the center is. In the end, the PC will receive 1203 bytes of data in total (this is without start and stop bits).
<br></br>
The data, beginning from the microphone to the PC, undergoes multiple format conversions. The data format is only converted when it is required for another module. For example: the ADC will sample the voltage present on the analog pin and convert it to a 12-bit integer value (0-4095), but the DFT accepts input in 2's complement fixed-point number format. For the DFT to perform the calculation correctly, the data must be converted into the correct format. The summary of data flow through the system with all format conversions is shown in Fig. 4.

<div align="center">
  <img src="https://github.com/dariusur/SpectrumAnalyzer/blob/main/drawings/dataflow_diagram.png">
</div>
<div align="center">
  <i>Fig. 5. Data flow block diagram.</i>
</div>
<br></br>

### Software
The Python script runs in an infinite loop, always waiting for new data. When new data is received, the script decodes it and draws/updates a graph on the screen. Since the data is sent as 8-bit packets, the script recombines two 8-bit packets into one 16-bit packet and then decodes it. At this point, it is assumed that the data format is an unsigned fixed-point number with the 12th bit representing the whole number part (greater bits are all 0s), while the rest of the bits represent the fractional part. There are four constants defined at the beginning of the script: POINTS, S_FREQ, NYQ_FREQ, and X_SCALE_MULTIPLIER. These should not be changed unless you modify the RTL code to support a different number of points or a different sampling frequency. The X_SCALE_MULTIPLIER ($2 * NYQ\textunderscore FREQ \over POINTS$) defines the resolution of the measurement and is used to scale the x-axis, which spans from 0 to the Nyquist frequency $f_{Nyquist} = {f_{sample} \over 2}$. The decoded data is multiplied by $2^{blk\textunderscore exp}$ to obtain the final data format (unsigned block floating-point number). The data is then normalized by the point size and multiplied by 2 to account for the fact that this is only half of the spectrum. Finally, the data is displayed on the screen as a single-sided DFT spectrum.

## Installation
### FPGA
This project was developed using Vivado 2022.2 IDE. The "SpectrumAnalyzer" folder in the repository is a project folder that you can open with Vivado. It contains all the files needed to generate a bitstream and program an FPGA. Keep in mind that this project was configured for the Arty A7-35 (xc7a35ticsg324-1L) development board. If you have a different board, you will need to configure the project for that particular board.
### Python script
SpectrumAnalyzer script was developed using:
1. Python 3.11.4.
2. pyserial 3.5
3. matplotlib 3.7.2
4. numpy 1.25.2

## Issues and notes for further development
1. Unreliable data transmission. The time it takes for the Python script to redraw the graph is variable. This will happen on non-RTOS systems such as Windows. On average, it's ~23 ms in addition to the UART transmission time of 4.01 ms. This results in 27.01 ms data processing time, which is just below the ADC data frame collection time of 27.14 ms for 1200 points. Sometimes, this can jump even above 30 ms, and when this happens enough times, the new data frames will start being buffered. Eventually, the buffer overflows resulting in loss of data, even worse than that, currently there is no way to tell where the data frame begins or ends. The script simply reads 1203 bytes and assumes it is correct. It causes data frame overlap and misrepresentation of data on the graph.
2. Poor measurement capabilities for very low frequencies and very high frequencies. This is because the electret microphone's (the one I use) frequency response is best in the 500 Hz - 9000 Hz frequency range. The signal outside of this range is still detectable but very weak. By adjusting the gain it is possible to increase the amplitude of this weak signal. Care must be taken to not increase the gain too much, or this will cause clipping due to op-amps not being able to go beyond the rails. Clipping causes harmonics to appear on the graph and this makes spectrum evaluation difficult. To solve this, either some compensation must be introduced to flatten the response, or perhaps it would just be better to focus on the 500 - 9000 Hz range exclusively. Using a different microphone is also an option.
3. The y-axis range spans 0 - 1. 0 means that there is no signal, while 1 means that the signal amplitude peak-to-peak is 3.3V. This is not very intuitive, and it would probably be best to convert this to sound pressure.
4. The external hardware currently is the weakest part of this project. The op-amps are biased at 2.5 V, but the maximum output voltage that can be provided is something like 3.78 V (this varies from one op-amp to another). It means that the bias is not at the middle $3.78 \over 2 = 1.89 V$. This causes underuse of the possible voltage range and prevents the signal from reaching 1 in amplitude on the graph. Currently, the maximum it can reach is 0.76, after that, clipping occurs and harmonics arise. I'm not sure if it's a good idea to bias the op-amp at 1.89 V because that would mean the greatest output from an op-amp I am expecting is 3.78 V, but who is to say that it will never swing above? After all, the datasheet only lists the maximum deviation from the V+ rail. In such an event, the analog pin of the FPGA might see a voltage that is not within the allowable range. To solve this, maybe a look into rail-to-rail op-amps would be worthy, or some kind of a protection circuit that would clip output voltages above 3.3 V would also be nice.

## References

1. https://www.youtube.com/watch?v=spUNpyF58BY
2. https://vanhunteradams.com/FFT/FFT.html
3. https://www.algorithm-archive.org/contents/cooley_tukey/cooley_tukey.html
4. https://web.mit.edu/6.111/www/f2017/handouts/FFTtutorial121102.pdf
5. https://pages.github.coecis.cornell.edu/jt658/ECE3400_Group9_2019/lab2.html
6. https://www.physicsforums.com/threads/relationship-between-frequency-and-power-for-sound.1055900/
7. https://forum.digilent.com/topic/17096-busbridge3-high-speed-ftdifpga-interface/
8. https://www.hackster.io/MichalsTC/how-to-use-the-fast-serial-mode-on-a-ftdi-ft2232h-7f0682
9. https://github.com/WangXuan95/FPGA-ftdi245fifo
10. https://forum.digilent.com/topic/3213-problem-ft2232-sync-fifo-mode/
