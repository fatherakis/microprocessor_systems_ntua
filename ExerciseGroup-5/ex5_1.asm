ORG 100h

Table DB 128 DUP(0) ;Initialise Table(0 - 128) with 0's

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

Print_empty_line MACRO
  PUSH BX
  MOV BL,13 ;This is carry return. https://www.petefreitag.com/item/863.cfm see for more info
  PRINT BL
  MOV BL,10 ;This is Line feed or \n
  PRINT BL
  POP BX

ENDM


PRINT_DEC MACRO CHAR
 PUSH AX
 PUSH DX
 MOV DL,CHAR
 CMP DL,0AH
 JB  type_zero_nine ;DL < 10 (dec)
 MOV DH,0
 count_dec:
 INC DH
 MOV AL,DL
 SUB AL,0AH
 MOV DL,AL
 CMP AL,0AH
 JAE count_dec

 MOV AL, DH
 ADD AL, 30H

 MOV DH,DL

 MOV DL,AL
 MOV AX,0
 MOV AH,2
 INT 21H
 MOV DL,DH
 ADD DL,30H
 INT 21H
 JMP end
 type_zero_nine:
 MOV AL, DL
 ADD AL, 30H
 MOV DL,AL
 MOV AX,0
 MOV AH,2
 INT 21H    ; Printed if DL = 0 - 9
 end:
 POP DX
 POP AX


ENDM



MAIN PROC FAR

MOV BL,128
MOV DI,0

Init:
  MOV Table(DI),BL
  DEC BL
  INC DI
  CMP DI,128
  JNE Init
  ;Table = 128,127,126...1

  ;Adding odd nums
  MOV AX,0        ;Zero Accumulator for Mean value
  MOV DI,1
  ODD:            ;Load Table(1)=127, add to acc & INC by 2 till T(127).
  MOV BL,Table(DI)
  MOV BH,0
  ADD AX,BX
  INC DI
  INC DI
  CMP DI,129
  JNE ODD         ;Loop until done with array



  MOV BL,64       ;Load Half
  DIV BL ;  Divide Res by half. Result accumulator goes to AL.

  PRINT_DEC AL
  Print_empty_line

  MOV DI,0
  MOV BL,Table(DI); min
  MOV BH,Table(DI); max 

  cmpr:
  INC DI
  CMP BL,Table(DI)
  JB num_greater  ;num isnt lower than existing
  MOV BL,Table(DI)

  num_greater:
  CMP BH,Table(DI)
  JA move_on    ;num isnt greater than existing
  MOV BH,Table(DI)

  move_on:
  CMP DI,127
  JNE cmpr ;if D goes to 128 then end

  PRINT_HEX BH
  PRINT " "
  PRINT_HEX BL
  MOV AX,4C00H
  INT 21H

MAIN ENDP

PRINT_HEX MACRO SYM
  PUSH DX
  MOV DL,SYM
  AND DL,0F0H  ;4 - MSB
  SHR DL,4
  CALL HEX_PRINT
  MOV DL,SYM
  AND DL,0FH  ;4 - LSB
  CALL HEX_PRINT
  POP DX

ENDM

HEX_PRINT PROC NEAR

  PUSH DX
  CMP DL, 9 ; Checking if number or letter
  JG letter ;JG: if DL is greater than 9 then trigger
  SUB DL,07H; DL would be 0-9 so we add 30(aka 30-39 in hex)
  letter:
  ADD DL,37H; DL would be A-Z so we add 37 (letters are 7 symbols in front of numbers, 41 - 37 = A)
  PRINT DL
  POP DX
  RET

HEX_PRINT ENDP


ret
