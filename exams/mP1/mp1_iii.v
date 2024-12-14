
Gate level

module part1_3(A,B,C,D,E,F);
	input ABCDE;
	output F;
	wire Cnot,w1,w2,w3,w4,w5;
	not N1(Cnot,C);
	and G1(w1, B,Cnot);
	or G2(w2,C,D);
	xor G3(w3,A,w2);
	and G4(w4,B,w3);
	or G5(w5,w1,w4);
	notif(F,E,w5);
	assing F=E? (~w5:1'bz);
endmodule


Dataflow

module part1_3(A,B,C,D,E,F)
		input A,B,C,D,E;
		output F;	
		assign F = E? (!( (((D||C)^A) && B) || (!C && B) ):1'bz);
endmodule