#include <avr/io.h>
char x;
char a, b, c, d, c1, f0, f1;
int main(void){

    DDRB=0xFF; // Initialize PortB as output
    DDRA=0x00; // Initialize PortA as input
    x = 0;     // Default off LED
    while(1){
        // Bit isolation
        a = PINA & 0x01;
        b = PINA & 0x02;
        c = PINA & 0x04;
        d = PINA & 0x08; 

        c1 = !(c);

        f0 = !((a && b && c1) || (c && d)); // f0 = (ABC' + CD)'
        f1 = ((a || b) && (c || d)); // f1 = (A+B)(C+D)

        f1 = f1<<1 // f1 value should be at 2nd LSB
        x = f0 + f1; // x has f1 in first and f0 in 2nd bit

        PORTB = x; // PortB output

    }
    return 0;
}