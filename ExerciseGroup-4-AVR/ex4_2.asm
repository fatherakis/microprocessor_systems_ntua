.include "m16def.inc"

.DEF A = r18 
.DEF B = r19
.DEF C = r20
.DEF D = r21
.DEF F0 = r22
.DEF F1 = r23
.DEF T = r17
.DEF FT = r16

stack:  ldi r24, low(RAMEND)
        out SPL, r24
        ldi r24, high(RAMEND)
        out SPH, r24
    
IO_set: ser r24 ; initialize PortA
        out DDRA, r24 ; output
        clr r24 ; initialize PortB

main:   clr F0 ; ready F
        in T, PORTB ; T <-- input

        mov A, T ; LSB(A) = A
        andi A, 0x01

        mov B, T ; LSB(B) = B
        andi B, 0x02
        LSR B

        mov C, T ; LSB(C) = C
        andi C, 0x04
        LSR C
        LSR C

        mov D, T ; LSB(D) = D
        andi C, 0x08
        LSR D
        LSR D
        LSR D

        mov F0,C
        com F0 ; F0 = C'
        and F0, B
        and F0, A ; F0 = ABC'
        mov T, C
        and T, D ; T = CD
        or F0 , T ; F0 = ABC' + CD
        com F0 ; F0 = (ABC' + CD)'
        andi F0, 0x01
        clr F1
        
        mov F1, brcc
        or F1, A ; F1 = A+B
        mov T, D
        or T, C ; T = C + D
        and F1, T ; F1 = (A+B)(C+D)
        lsl F1
        mov FT, F1
        add FT, F0
        out PORTA, FT
        rjmp main

