
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h



PRINT MACRO CHAR
    PUSH AX
    PUSH DX ;store register values that will be changed
    MOV DL,CHAR
    MOV AH,2
    INT 21H
    POP DX
    POP AX
ENDM

Print_empty_line MACRO
  PUSH BX
  MOV BL,13 ;This is carry return. https://www.petefreitag.com/item/863.cfm see for more info
  PRINT BL
  MOV BL,10 ;This is Line feed or \n
  PRINT BL
  POP BX

ENDM


READ MACRO
    MOV AH, 8
    INT 21H
ENDM



MAIN PROC FAR
Repeat:
    CALL HEX_KEYB   ; 4 - MSB / 12

    MOV BH,AL

    CALL HEX_KEYB   ; 4 - MID / 12

    MOV BL,AL
    SHL BL,4

    CALL HEX_KEYB   ; 4 - LSB / 12

    ADD BL,AL

    Print '='
    CALL PRINT_DEC

    Print_empty_line
    Print '='
    CALL PRINT_OCT

    Print_empty_line
    Print '='
    CALL PRINT_BIN
    Print_empty_line
    JMP Repeat

MAIN ENDP


PRINT_DEC PROC NEAR
PUSH DX
PUSH AX
PUSH CX

AND BH,0FH
MOV AX,BX
MOV DX,0064H  ;100 equivilent of decimal
DIV DL ; AL = (0 - 40) AH = remainder ( 0 - 99)
MOV CL,AH
AND AX,00FFH
MOV DX,0
MOV DL,10     ;10 equivilent of decimal
DIV DL ; AL = (0 - 4) AH = remainder (0- 9) aka hundreds
ADD AL,30H ; ASCII
PRINT AL ; PRINT THOUSANDS
ADD AH,30H ; ASCII
PRINT AH ; PRINT HUNDEREDS
MOV AX,0
MOV AL,CL
DIV DL
ADD AL,30H ; ASCII
PRINT AL ; PRINT Tens
ADD AH,30H ; ASCII
PRINT AH ; PRINT Remainder

POP DX
POP AX
POP CX
ret
PRINT_DEC ENDP





PRINT_OCT PROC NEAR
PUSH DX
PUSH AX
PUSH CX

AND BH,0FH
MOV AX,BX
MOV DX,0040H  ;equivilent 100 of octal
DIV DL ; AL = (0 - 40) AH = remainder ( 0 - 99)
MOV CL,AH
AND AX,00FFH  ;keep AL
MOV DX,0
MOV DL,08H  ; equivilent 10 of octal
DIV DL ; AL = (0 - 4) AH = remainder (0- 9) aka hundreds
ADD AL,30H ; ASCII
PRINT AL ; PRINT THOUSANDS
ADD AH,30H ; ASCII
PRINT AH ; PRINT HUNDEREDS
MOV AX,0
MOV AL,CL
DIV DL
ADD AL,30H ; ASCII
PRINT AL ; PRINT Tens
ADD AH,30H ; ASCII
PRINT AH ; PRINT Remainder

POP DX
POP AX
POP CX
ret
PRINT_OCT ENDP






PRINT_BIN PROC NEAR
    PUSH AX
    SHL BH,4    ;Get the LSB's to MSB possition
    MOV CX,12   ;Loop for 12 bits
Bin1:
    CMP BH,00H
    JE  Bin2    ; when the 4bits of BH are done,move to BL
    SHL BH,1    ; Shift to carry  left
    MOV AL,0
    ADC AL,30H ;30H+MSB of DL
    PRINT AL
    LOOP Bin1
Bin2:
    MOV CX,8    ;Change loop to the 8 remaining bits
Bin2_1:
    SHL BL,1
    MOV AL,0
    ADC AL,30H ;30H+MSB of DL
    PRINT AL    ;Same procedure
    LOOP Bin2_1
    POP AX
ret
PRINT_BIN ENDP




HEX_KEYB PROC NEAR

    PUSH DX
   IGNORE:
    READ
    CMP AL, 'T'
    JE ADDR2
    CMP AL,30H
    JL IGNORE
    CMP AL,39H
    JG ADDR1
    PUSH AX
    PRINT AL
    POP AX
    SUB AL,30H
    JMP ADDR2
    ADDR1: CMP AL,'A'
    JL IGNORE
    CMP AL,'F'
    JG IGNORE
    PUSH AX
    PRINT AL
    POP AX
    SUB AL,37H
   ADDR2:
    POP DX
    RET

HEX_KEYB ENDP

ret
