<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a Moore Finite State Machine (FSM) based vending machine controller. The machine accepts three coin inputs: nickel (5 cents), dime (10 cents), and quarter (25 cents), and dispenses an item when the total reaches 25 cents. The FSM has 6 states each representing the running total of money inserted so far: (0¢, 5¢, 10¢, 15¢, 20¢, and 25¢). On every clock cycle, the FSM checks which coin input, if any, is active and moves to the next state. The output depends only on the current state, not on the inputs directly, which means the dispense signal only goes high when the machine has actually reached the 25¢ state. When the total reaches 25¢, the dispense output fires and the machine automatically resets back to the idle state.

## How to test

First, reset the machine by setting rst_n low then high. This brings the machine back to 0 cents.
- ui_in[0] = nickel (5 cents)
- ui_in[1] = dime (10 cents)
- ui_in[2] = quarter (25 cents)

Once the total reaches 25 cents, the machine will automatically dispense and reset back to 0 cents.

The output LEDs represent the following:
- uo_out[0] = dispense (LED lights up when 25 cents is reached)
- uo_out[1] = debug bit 0 (least sig. bit of current state)
- uo_out[2] = debug bit 1
- uo_out[3] = debug bit 2 (most sig. bit of current state)

The debug bits show the current state in binary:

| uo_out[3]  |  uo_out[2] |  uo_out[1]  |  Total    |
|------------|------------|-------------|-----------|
|  0         |   0        |       0     | 0 cents   |
|  0         |   0        |       1     | 5 cents   |
|  0         |   1        |       0     | 10 cents  |
|  0         |   1        |       1     | 15 cents  |
|  1         |   0        |       0     | 20 cents  |
|  1         |   0        |       1     | 25 cents  |

## External hardware

No external hardware is required. This design was also verified on a Digilent Nexys A7-100T FPGA development board, using onboard switches for coin inputs and LEDs for the dispense and debug outputs.

## I/O

| #   |    Input     |    Output     |
|-----|--------------|---------------|
|  0  |   Nickel     |  Dispense     |
|  1  |   Dime       |  Debug bit 0  |
|  2  |   Quarter    |  Debug bit 1  |
|  3  |   N/A        |  Debug bit 2  |
