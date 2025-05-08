	@j
	M=0
	@SCREEN
	D=A
	@k
	M=D
	
(LOOPLONG)
	@j
	D=M
	@R0
	D=D-M
	@END
	D;JEQ
	
	@k
	A=M
	M=-1
	
	@j
	M=M+1
	@32
	D=A
	@k
	M=D+M
	@LOOPLONG
	0;JMP
	
(END)
	@END
	0;JMP
	
	
