[org 0x0100]

jmp start

multiplicand:   dw 0xD431, 0x0    ; 54321  =   0b 1101010000110001
multiplier:     dw 0x3039    ; 12345   =   0b 0011000000111001
result:         dw 0, 0       ; should be 10,000 = 0x2710 

start:

mov  cl, 16
mov  dl, [multiplier]


checkbit: 
    shr byte [multiplier + 1], 1
    rcr  dl, 1
    jnc  skip

        mov  al, [multiplicand]      ; extended addition 
        add  byte [result], al
        mov  al, [multiplicand + 1]
        adc  byte [result + 1], al 
        mov  al, [multiplicand + 2]
        adc  byte [result + 2], al 
        mov  al, [multiplicand + 3]
        adc  byte [result + 3], al 

    skip:
    shl  byte [multiplicand], 1      ; extended shift
    rcl  byte [multiplicand + 1], 1
    rcl  byte [multiplicand + 2], 1
    rcl  byte [multiplicand + 3], 1
    
    
    dec  cl
    jnz  checkbit




; exit syscall 
mov  ax, 0x4c00
int  0x21