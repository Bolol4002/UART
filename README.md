# UART
source - https://www.analog.com/en/resources/analog-dialogue/articles/uart-a-hardware-communication-protocol.html

---

## Basics

Embedded systems, microcontrollers, and computers mostly use UART as a form of device-to-device hardware communication protocol. Among the available communication protocols, UART uses only two wires for its transmitting and receiving ends.

IT is a hardware communication protocol that uses asynchrounus (no clock signal) serial communication with configurable speed.  

There are two imp signals
- transimitter
- reciever

THe main puropose is to transmit and recieve serial data intended for serial communication.

![Architecture Diagram](scrn/dig.png)

Uart lines serve as the ocmmunication medium to transmit and recieve one data to another.
From this , the data will be transmitted on the transmission line serially, bit by bit, to the recieving Uart. This converts serial data to parallel.

|Wires|qnty|
|-----|----|
|Speed|9600,19200,38400 etc|
|Method of transmission|asynchrounous|
|Max no. of masters|1|
|Max no. of slaves|1|

---

## Data Transmission

![UART packet](scrn/frame.png)

UART is in the form of a packet - the peice that connects transmitter and reciever.

- Start bit - Data transmission line is usually high (no data transmission). To start the transmission line is pulled from high to low for one clock cycle. When the reciving UART detects the high to low voltage transition , it begins reading the bits in the data frame at the frequency of the baud rate.

- Data frame - Contains the acutal data can be 5 to 8 bits long if a parity bit is used. If no parity it can transmit upto 9 bits. 
