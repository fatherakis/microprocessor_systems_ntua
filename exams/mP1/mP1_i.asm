ORG 2000H
	LDA 2000H
	RRC
    RRC 
   	ANI 63H ; x7 – x2 is now x5 – x0
	MOV B,A
	ANI 01H ;x0 
	MOV C,A ;save to C
	MOV A,B
	RRC ;x1
	RRC ;x2
	RRC ;x3
	ANI 01H
	ANA C  ; x2*x3
	MOV C,A
	MOV A,B
	RRC ;x1
	RRC ;x2
	RRC ;x3
 	RRC ;x4
	ANI 01H
	ANA C  ; (x2*x3)*x4
	MOV C,A
	MOV A,B
	RRC ;x1
	RRC ;x2
	RRC ;x3
 	RRC ;x4
	RRC ;x5
	ANI 01H
	ANA C  ; ((x2*x3)*x4)*x5
	MOV C,A   ; FIRST PART OF y0 IS ON C

	MOV A,B
	RRC ;x1
	RRC ;x2
	RRC ;x3
 	RRC ;x4
	RRC ;x5
	RRC ;x6
	ANI 01H
	MOV D,A ;D has x6
	MOV A,B
	RRC ;x1
	RRC ;x2
	RRC ;x3
 	RRC ;x4
	RRC ;x5
	RRC ;x6
	RRC ;x7
	ANI 01H
	ANA D ; A   =  x7*x6
	ORA C ; A   = (x7*x6) + (x5*(x4*(x3*x2))) = x7 * x6  +  x5*x4*x3*x2
	STA 3000H
END
