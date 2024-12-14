
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

M1 DB 'Z=', '$'
M2 DB 'W=', '$'
M3 DB 'Z+W=', '$'
M4 DB 'Z-W=', '$'

PRINT MACRO let

  PUSH AX
  PUSH DX
  ;Store the register values since they are used
  MOV DL,let ;See Documentation:
  MOV AH,2   ;Standard Output is interrupt 21H with AH=2
  INT 21H    ;for character DL
  POP DX
  POP AX

ENDM


READ MACRO
    MOV AH, 8
    INT 21H

ENDM



Print_empty_line MACRO
  PUSH BX
  MOV BL,13 ;This is carry return. https://www.petefreitag.com/item/863.cfm see for more info
  PRINT BL
  MOV BL,10 ;This is Line feed or \n
  PRINT BL
  POP BX

ENDM

Print_space MACRO
  PUSH BX
  MOV BL,32
  PRINT BL
  POP BX

ENDM


PRINT_STR MACRO STRING
    PUSH AX
    PUSH DX
    MOV DX,OFFSET STRING
    MOV AH,9
    INT 21H               ;INTERRUPT 21H/ AH = 09H  Outputs string of DS:DX where string ends with "$"
    POP DX
    POP AX
ENDM



MAIN PROC FAR
    rest:
    PRINT_STR M1
    CALL DEC_KEYB
    MOV BL,0
    calc:
    CMP AL,00H
    JE fin
    ADD BL,0AH
    DEC AL
    JMP calc
    fin:
    CALL DEC_KEYB
    ADD BL,AL
                  ;Read the first num and converted to hex  to BL
    Print_space

    PRINT_STR M2
    CALL DEC_KEYB
    MOV CL,0
    calc2:
    CMP AL,00H
    JE fin2
    ADD CL,0AH
    DEC AL
    JMP calc2
    fin2:
    CALL DEC_KEYB
    ADD CL,AL
                  ;Read the second num and converted to hex to CL

    Print_empty_line

    PRINT_STR M3
    MOV BH,0
    MOV CH,0
    MOV AX,BX
    ADD AX,CX ;AX=x+y        ; ADD 1st NUM & 2nd NUM
    CALL PRINT_DEC ;print AX

    Print_space

    PRINT_STR M4

    MOV AX,BX
    SUB AX,CX
    CMP BX,CX
    JNB pos                 ;if Positive just print
    PRINT '-'
    NEG AX                  ;if Negative replace with negative and add '-'
    pos:
    CALL PRINT_DEC
    Print_empty_line
    JMP rest

MAIN ENDP



PRINT_DEC PROC NEAR
    PUSH BX
    CMP AX,10  ;skip hundreds and tens if AX<10
    JB ONES
    CMP AX,100 ;skip hundreds if AX<100
    JB TENS
    MOV BL,100
    DIV BL ;AL now contains hundreds, AH contains remainder
    ADD AL,30H ;ASCII code of digits 0-9
    PRINT AL ;print hundreds
    MOV AL,AH ;AL now contains remainder (tens+ones)
  TENS:
    MOV AH,0
    MOV BL,10
    DIV BL ;AL now contains tens and AH contains ones
    ADD AL,30H ;ASCII code of digits 0-9
    PRINT AL
    MOV AL,AH
  ONES:
    ADD AL,30H ;ASCII code of digits 0-9
    PRINT AL
    POP BX
    RET
PRINT_DEC ENDP



DEC_KEYB PROC NEAR

    PUSH DX
    IGNORE:
    READ
    CMP AL, 30H
    JL IGNORE
    CMP AL, 39H
    JG IGNORE
    PUSH AX
    PRINT AL
    POP AX
    SUB AL, 30H
    ADDR2:
    POP DX
    RET

DEC_KEYB ENDP



ret
