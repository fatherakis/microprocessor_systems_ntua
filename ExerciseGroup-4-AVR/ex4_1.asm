.include "m16def.inc"

stack:  ldi r24, low(RAMEND) ;initialize stack pointer
        out SPL, r24
        ldi r24, high(RAMEND)
        out SPH, r24

IO_set: ser r24 ;output PORTA
        out DDRA, r24
        clr r24

main:   ldi r26, 01 ; initialize r26
        rcall left
        rcall right
        rjmp main

left:   in r24, PINB ; check input
        andi r24, 01 ; pinB-> pin 0 gives 0x00
        cpi r24, 01 ; repeat till it's not 1
        brcc left ; jump if carry clear
        out PORTA, r26 
        cpi r26, 80
        brcc left_done ; jump if carry clear
        lsl r26     ;RLC
        rjmp left
left_done: ret

right:  in r24, PINB ; check input
        andi r24, 01 ; pinB-> pin0 gives 0x00
        cpi r24, 01 ; repeat till its not 1
        brcc right ; jump if carry clear
        out PORTA, r26
        cpi r26, 01
        breq right_done ; jump if equal
        lsr r26 ; RRC
        rjmp right
right_done: ret