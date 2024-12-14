### Microcomputer Systems - NTUA Class 2021

Lab exercises were split in 5 groups and completed as 2-person colaboration teams.
* Exception on 4th AVR Lab where groups of 3 were formed.

All exercise descriptions and requirements are provided in their respective PDFs.

Contents:

* ExGroup1: 8085 Assembly coding

    * ex1_1.8085: Dissasembly of given machine code along with adjustments.

    * ex1_2.8085: Assembly control of an LEDs with clockwise and counter clockwise movement based on MSB DIP switch.

    * ex1_3.8085: Assembly program converting binary numbers to 2-digit Hex and showing to predetermined LEDs.

    *Answers to theoretical questions or Verilog examples are not uploaded.*

* ExGroup2: 8085 Assembly coding

    * ex2_1.8085: Multiple segments
        * i: Automatically save 0 to 255 in memory and verify results.
        * ii: Calculate units of saved numbers.
        * iii: Calculate how many of the saved numbers populate a given range.

    * ex2_2.8085: LED control based on Push Button (MSB DIP switch) input.

        Supported Functions:
        * OFF - ON - OFF: LED on for 20 sec.
            * OFF - ON - OFF (While active): Refresh timer.
        
        *Refresh rate 100ms*

    * ex2_3: Multiple segments
        * i.8085: Control LEDs through a DIP Switch.
        * ii.8085: Read 1-8 numbers from HEX keyboard and turn on MSB - Keyboard number LEDS.
        * iii.8085: Full support for Hex Keyboard and print selected charater on 7-segment display.

    * ex2_4.8085: IC Function simulation through assembly. dip switch and LEDs as I/O.

* ExGroup3: 8085 Assembly Coding

    * ex3_1.8085: LED control through Interrupts and Display.
        * On interrupt turn on for 1min.\
            **>** On secondary interrupt within timeframe, refresh timer.
        * Continuous remaing time display on 7-segment.

    * ex3_2.8085: Read 2 consecutive hexadecimal numbers, print on display and compare with 2 thresholds.

    * ex3_3i.8085: Implementation of "SWAP Nible Q".

    * ex3_3ii.8085: Implementation of "FILL RP, X, K".

    * ex3_3iii.8085: Implementation of "RHLR".

    * ex3_5a.8085: Data transfer Link. Read 32 8-bit data and calculate the average. Receive each 4-bits after interrupt from "Data Ready" signal.

    * ex3_5b.8085: Same as 5a without interrupts. "Data Ready" is connected to another data bit which we check.


* ExGroup4: AVR Coding

    * ex4_1.asm: Left and Right movement of LED (in an LED array). Direction is controlled from a push button.

    * ex4_2.asm: Logic functions.
    * ex4_2.c: Logic functions exaclty like assembly but in C.

    * ex4_3.c: C program for AVR ATmega16. LED control through push buttons (on-release).

        Supported Functions:
        * Left-Circular LED movement
        * Right-Circular LED movemnt
        * Fixed MSB position
        * Fixed LSB position

* ExGroup5: 8086 Assembly Coding
    * ex5_1.asm: Save 128 - 1 consecutively in memory and print\
        i) Interger part of average of odd numbers on one display line in decimal form.

        ii) Min and Max in size in hexadecimal form on another line.\
        **Search for them at the same time in the same loop.**

    * ex5_2.asm: Read 2 double-digit decimals, show on display on first line, calculate sum and difference and show on secondary line in hexadecimal form. *Keep the program continuous.*
    
    * ex5_3.asm: Add diplay support for decimal, octal and binary representation of numbers. Read 3 digit hex number from keyboard, display all implemented forms and await for new 2 digit hex number.
    *Keep program continuous until "T" is input from keyboard to terminate.*

    * ex5_4.asm: Display 20 characters as received from keyboard. On "ENTER" or 20th character, display on secondary line, all characters capitalized and numbers at the end retaining positions and splitting character sequence and number sequence with "-".

    * ex5_5.asm: Read Temperature sensor through ADC converter.Support readings from 0 to 1200°C. If out of range, display error. Keep program continuous and terminate on input character "N".

* exams: These are my answers on the exams. They are split in 3 segments each in its own folder.

    PDFs contain the questions and answers (excluding Theoretical Questions).\
    The answers are also available in their respective code files for easier access.