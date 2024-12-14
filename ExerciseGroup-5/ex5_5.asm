
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
M0 DB 'SIDENOTE: T(oC) = 200*(HEX A/C) / 1024, 800*(ΗΕΧ  Α/C) /1024  - 1200 $'
M1 DB 'START(Y,N) ','$'
M2 DB 'TEMP IS T=','$'
M3 DB 'TEMP READER GIVES A HEX OF :', '$'
M4 DB 'ERROR$'

PRINT MACRO CHAR
    PUSH AX
    PUSH DX ;store register values that will be changed
    MOV DL,CHAR
    MOV AH,2
    INT 21H
    POP DX
    POP AX
ENDM

PRINT_STR MACRO STRING
    PUSH AX
    PUSH DX
    MOV DX,OFFSET STRING
    MOV AH,9
    INT 21H
    POP DX
    POP AX
ENDM

PRINT_LINE MACRO
    PUSH BX
    MOV BL,13
    PRINT BL
    MOV BL,10 ;ASCII code for new line
    PRINT BL
    POP BX
ENDM

READ MACRO
    MOV AH,8
    INT 21H
ENDM


EXIT MACRO
    MOV AX, 4C00H
    INT 21H
ENDM



MAIN PROC FAR
    PRINT_STR M0
    PRINT_LINE
    PRINT_LINE
  START:
    PRINT_STR M1
  WAITi:
    READ
    PRINT AL
    CMP AL, 'N'
    JE SENDS
    CMP AL, 'Y'
    JNE WAITi
    PRINT_LINE
    PRINT_STR M3
  INPUT:
    CALL HEX_KEYB ;read first hex digit

    CMP AL,4EH    ;N
    JE SENDS

    MOV AH,0
    SHL AX,8 ;shift bits in correct position
    MOV BX,AX
    CALL HEX_KEYB ;read second hex digit

    CMP AL,4EH    ;N
    JE SENDS

    MOV AH,0
    SHL AX,4 ;shift bits in correct position
    ADD BX,AX
    CALL HEX_KEYB ;read third hex digit

    CMP AL,4EH    ;N
    JE SENDS

    PRINT_LINE
    MOV AH,0
    ADD AX,BX


    CMP AX,0C00H    ;T> 120,0 is error
    JA error
    CMP AX,2047D   ; 0 <= Y <=  2047   decimal
    JBE CASE1
    CMP AX,3072D   ; second case
    JBE CASE2

  CASE1:
    MOV DX, 200D
    MUL DX
    MOV CX, 1024D
    DIV CX
    JMP CONV
  CASE2:
    MOV DX, 800D
    MUL DX
    MOV CX, 1024D
    DIV CX
    SUB AX, 1200D
    JMP CONV

              ;same as show in  lectures
  CONV:
    MOV CX, 0
  DIGIT:
    MOV DX, 0
    MOV BX, 10D
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIGIT
    DEC CX
    PRINT_LINE
    PRINT_STR M2
  TIGID:
    POP DX
    PRINT_DEC
    LOOP TIGID
    PRINT '.'
    POP DX
    PRINT_DEC
    PRINT_LINE
    JMP START
  SENDS:
    CMP AL,4EH
    JE exit
    EXIT
  error:
    PRINT_STR M4
    EXIT
  exit:
    PRINT AL
    EXIT
MAIN ENDP

PRINT_DEC MACRO
    ADD DL, 30H
    MOV AH,2
    INT 21H
    SUB DL, 30H
ENDM



HEX_KEYB PROC NEAR
    PUSH DX
  IGNORE:
    READ
    CMP AL, 'N'
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
   ADDR2: POP DX
    RET
HEX_KEYB ENDP

ret
