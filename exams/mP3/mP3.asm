INCLUDE	MACROS

DATA_SEG	SEGMENT
	MSG1	DB 0AH,0DH, 'GIVE 1ST NUMBER=  $'
	MSG2	DB 0AH,0DH, 'GIVE 2ND NUMBER= $'
	MSG3	DB 0AH,0DH, 'GIVE 3ND NUMBER= $'
	MSG4 	DB 0AH,0DH, 'RESULT = $'
	MSG5           DB 0AH,0DH, 'overf$'
DATA_SEG	ENDS

CODE_SEG	SEGMENT
	ASSUME   CS:CODE_SEG, DS:DATA_SEG

MAIN	PROC	FAR
MOV	AX, DATA_SEG
MOV	DS, AX
ADDR1:  PRINT_STR MSG1
	     CALL DEC_KEYB
	     PRINT AL
	     MOV BL, AL ; SAVE FIRST DIG
	     PRINT_STR MSG2
	     CALL DEC_KEYB
	     PRINT AL
	     ADD  BL;  D3 + D2
	     MOV BL,AL ;  D3 + D2  to BL
	     PRINT_STR MSG3
	     CALL DEC_KEYB
	     PRINT AL
	     MOV CH,AL
	     CALL DEC_KEYB
	     PRINT AL
	     MOV CL, AL  ; NOW CX HAS    CH  FISRT PART      CL SECOND PART
Await:	     MOV AL,00H
	     MOV AH,8
    	     INT 21H
	     PRINT AL
	     CMP AL,48H  ; or CMP AL,’H’
	     JE CALC
	     JMP Await
CALC:     MOV DL,10 ;  else we do MOV DL, 0AH
	     MOV AL, CH
	     MUL DL
	    ADD CL    ; AL HAS  10*D1 + D0
	    MOV CH,00H
	    MOV CL, AL ; CL has 10*D1 + D0  or in hex  0A*D1 + D0
	    MOV AH,00H
	    MOV AL,BL
	    MUL  CX  ; MULTIPLY AX  = (D3 + D2 )  with  CX ( D1*10 + D0)
	    CMP AH, 05H
	    JNB  overflow_handle   ; if AH >= 5  possible overflow   (05 00 is  500 overflow)
CONTINUE:    
     	PRINT_STR MSG4
	    PRINT AH
	    PRINT AL
	    RET
OVERFLOW_HANDLE:
	    PRINT_STR MSG5
        RET