	@i
	M=0
	@R1
	M=0
(LOOP)	
	@R0
	D=M
	@i
	D=D-M
	@END
	D;JEQ
	
	@i
	M=M+1
	D=M
	@R1
	M=D+M
	@LOOP
	0;JMP
	
(END)
	@END
	0;JMP
