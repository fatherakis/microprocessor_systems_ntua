#include <avr/io.h>
#include <mega16.h>
unsigned char B,S0,S1,F0,F1,X,setter;

void restarter (){
	IF (S0 == 0){
	   WHILE (S0 != 1){
		setter = 0x01;
		PORTC = setter;
   }
 setter = 0x00;
PORTC = setter;
}
}
void go_up (){
	IF (S1 == 0){
	   WHILE (S1 != 1){
		setter = 0x02;
		PORTC = setter;
   }
 setter = 0x00;
PORTC = setter;
}
}

void go_down (){
	IF (S0 == 0){
	   WHILE (S0 != 1){
		setter = 0x01;
		PORTC = setter;
   }
 setter = 0x00;
PORTC = setter;
}
}


int main (void){
	DDRC = 0x00 //input
	DDRA = 0xFF //output

	 B=PINC
	S0 = B & 0x10;
	S1 = B & 0x08;
	F0 = B & 0x04;
	F1 = B & 0x02;
	X  =  B & 0x01;
	S0 = S0>>4;
	S1 = S1 >>3;
	F0 = F0>>2;
	F1 = F1>>1;
	Restarter();
	
WHILE (1){
B=PINC
	S0 = B & 0x10;
	S1 = B & 0x08;
	F0 = B & 0x04;
	F1 = B & 0x02;
	X  =  B & 0x01;
	S0 = S0>>4;
	S1 = S1 >>3;
	F0 = F0>>2;
F1 = F1>>1;
	IF(S0 == 1 && S1 == 0){
		If (F1 == 1 || X == 1){
			Go_up();
		}
	}
	IF (S0 == 0&&S1 ==1 ){
		If(F0 == 1 || X == 1){
			Go_down();
		}
	}
	else restarter();
}
return 0;
}

Assume 01 means down, 10 means up and 00 no function/stop.
Assume that X refers to another floor (if its on ground floor, go to 1st and vice versa).

