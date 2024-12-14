#include <avr/io.h>
char x;
int main(void){
    DDRA = 0xFF; //PortA output
    DDRC = 0x00l //PortC input
    x = 1; //Default ON LED

    while(1){
        if ((PINC & 0x01) == 1){ // SW0 push button press detection
            while ((PINC & 0x01) == 1); // Push button SW0 return check 
                if (x==128) //Overflow check
                    x = 1;
                else
                    x = x << 1; // Shift left 
        }
        else if ((PINC & 0x02) == 2) {//SW1 press
            while ((PINC & 0x02) == 2); // SW1 return
                if (x==1) //Overflow
                    x = 128;
                else
                    x = x >> 1; // Shift right
        }
        else if ((PINC & 0x04) == 4) { //SW2 push
            while ((PINC & 0x04) == 4); //SW2 release
            x = 128; //MSB (LED7)
        }
        else if ((PINC & 0x08) == 8) { //SW3 push
            while ((PINC & 0x08) == 8); //SW3 release
            x = 1;  //LSB (LED0)
        }
        PORTA = x; // output at PortA
    }
    return 0;
}