
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

Table DB 20 DUP('.')

PRINT MACRO CHAR
    PUSH AX
    PUSH DX ;store register values that will be changed
    MOV DL,CHAR
    MOV AH,2
    INT 21H
    POP DX
    POP AX
ENDM

READ MACRO
    MOV AH, 8
    INT 21H
ENDM



Print_empty MACRO
    PUSH BX
    MOV BL,13
    PRINT BL
    MOV BL,10 ;ASCII code for new line
    PRINT BL
    POP BX
ENDM



MAIN PROC FAR
  Start:
   MOV BX,0    ; Actual read characters
   MOV CX,20   ; Max read chars
   MOV DI,0    ; Array pointer
  Read:
   Call READER
   MOV Table(DI),AL
   INC DI
   LOOP Read   ; UNTIL 20 chars or enter  read
   Print_empty
   MOV CX,BX   ; Loop for actual read numbers
   MOV DI,0
  Letters:
   MOV AL,Table(DI)
   CMP AL,97
   JB SKIP
   SUB AL,32   ; lowercase -> uppercase 
   PRINT AL
  SKIP:
   INC DI
   LOOP Letters
   Print '-'
   MOV CX,BX   ; Loop for actual read numbers
   MOV DI,0
  Numbers:
   MOV AL,Table(DI)
   CMP AL,57
   JA SKIP2
   PRINT AL
  SKIP2:
   INC DI
   LOOP Numbers

   Print_empty
   JMP Start
MAIN ENDP



READER PROC NEAR
  Repeat:
    READ
    CMP AL,13      ; if ENTER
    JE enter
    CMP AL,61      ; if =
    JE end         ; exit
    CMP AL,48      ; <0
    JB Repeat
    CMP AL,122     ; >z
    JA Repeat
    CMP AL,57      ; <=9
    JBE calc
    CMP AL,97      ; <a
    JB Repeat
  calc:
    INC BX
    PRINT AL
    ret
  end:
    MOV AX,4C00H
    INT 21H
  enter:
    MOV CX,1
    ret
READER ENDP


ret
