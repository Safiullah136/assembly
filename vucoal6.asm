; Example 4.3
; 16bit multiplication using test for bit testing

[org 0x0100]

jmp start

    multiplicand: dd 1300       ; 16bit multiplicand 32bit space
    multiplier: dw 500          ; 16bit multiplier
    result: dd 0                ; 32bit result

start:
    mov bx, 1

    checkbit:
        test bx, [multiplier]           ; test right most bit
        jz skip                         ; skip addition if bit is zero

            mov ax, [multiplicand]
            add [result], ax            ; add less significant word
            mov ax, [multiplicand + 2]
            adc [result + 2], ax            ; add more significant word

    skip: 
        shl word [multiplicand], 1           ; shift multiplicand left
        rcl word [multiplicand + 2], 1
        shl bx, 1                       ; shift mask towards next bit
        jnz checkbit                    ; repeat if bitmask left

    mov ax, 0x4c00
    int 0x21