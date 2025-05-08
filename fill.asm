(MAIN)
	@8191
	D=A
	@n
	M=D
	
	@KBD
	D=M
	@DARK
	D;JNE
	
	@LIGHT
	D;JEQ
	
	@MAIN
	0;JMP
	
(DARK)
	@n
	D=M
	@MAIN
	D;JLT
	
	@n
	D=M
	@SCREEN
	A=D+A
	M=-1
	
	@n
	M=M-1
	@DARK
	0;JMP
	
(LIGHT)
	@n
	D=M
	@MAIN
	D;JLT
	
	@n
	D=M
	@SCREEN
	A=D+A
	M=0
	
	@n
	M=M-1
	@LIGHT
	0;JMP
