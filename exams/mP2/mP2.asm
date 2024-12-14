.DEF S0 = r18
.DEF B = r19
.DEF X = r20
.DEF F0 = r21
.DEF F1 = r22
.DEF S1 = r23
.DEF L = r17
.DEF setter = r16

stack:	ldi r24 , low(RAMEND)	; initialize stack pointer
		out SPL , r24
		ldi r24 , high(RAMEND)
		out SPH , r24

IO_set:
ser r24
out DDRA,r24
clr r24
OUT DDRC

Main: 
      START_INIT:
	IN B,PORTC
	LDI L,0x01
	MOV S0,B
	ANDI S0,0x10; this is  S0
	LSR S0
	LSR S0
	LSR S0
	LSR S0
	CMP S0,L
	BRNE go_down_setup   l IF S0 = 0 (lvl 1 or MID STUCK go 0)
      Start:
	IN B,PORTC
	MOV X,B
	ANDI X,0x01 ; this is X
	MOV F1,B
	ANDI F1,0x02; this is  F1
	LSR F1
	MOV F0,B
	ANDI F0,0x04; this is  F0
	LSR F0
	LSR F0
	MOV S1,B
	ANDI S1,0x08; this is  S1
	LSR S1
	LSR S1
	LSR S1
	MOV S0,B
	ANDI S0,0x10; this is  S0
	LSR S0
	LSR S0
	LSR S0
	LSR S0
	 
	CP S0, L
	BREQ   CONTINUE ;  if S0 != 1 then go to isogeio.	
	CP S1, L 
	BREQ  CONTINUE
	JMP START_INIT  ; IF S0 & S1 = 0   then its in transit aka Jump start.
     CONTINUE:
	CMP F0, L
	BREQ go_down
	CMP F1,L
	BREQ go_up
	CMP X,L
	BREQ go_up_down
	rjmp Start
  go_down _setup:    
 	LDI setter,0x01
	out PORTA, setter
	CMP S0, L
	BRNE go_down_setup
	LDI setter,0x00
	out PORTA, setter
	rjmp START_INIT
   go_down: 
	LDI setter,0x01;
	out PORTA,setter
	CMP S0, L
	BRNE go_down
	LDI setter,0x00
	out PORTA,setter
	rjmp Start
  go_up:
	LDI setter,0x02;
	out PORTA,setter
	CMP S0, L
	BRNE go_up
	LDI setter,0x00
	out PORTA,setter
	rjmp Start


 go_up_down:
	CMP S0,L
	BREQ go_up_x
	CMP S1,L
	BREQ go_down_x
	rjmp START_INIT
go_up_x:
	LDI setter,0x02;
	out PORTA,setter
	CMP S0, L
	BRNE go_up_x
	LDI setter,0x00
	out PORTA,setter
	rjmp Start
go_down_x:
	LDI setter,0x01
	out PORTA, setter
	CMP S0, L
	BRNE go_down_x
	LDI setter,0x00
	out PORTA, setter
	rjmp START_INIT



Assume 01 means down, 10 means up and 00 no function/stop.
Assume that X refers to another floor (if its on ground floor, go to 1st and vice versa).
