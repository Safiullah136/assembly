	@R0
	D=M
	@n
	M=D
(LOOP)
	@n
	D=M
	@END
	D;JEQ
	
	@R1
	D=M
	@R2
	M=D+M
	
	@n
	M=M-1
	@LOOP
	0;JMP
	
(END)
	@END
	0;JMP
