; VU COAL CH # 5 Q: 5

[org 0x0100]

    jmp start

    new_stack_segment: dw 0x1234
    new_stack_offset:  dw 0xFFFE

    switch_stack:
        push bp
        mov bp, sp
        push bx
        push si

        mov bx, sp
        sub bx, 2

        mov si, 0xFFFC

        mov sp, [bp + 4]
        mov ss, [bp + 6]

    loop1:
        push word [si]
        sub si, 2
        cmp bx, si
        jnz loop1

    return: 
        pop si
        pop bx
        pop bp
        ret 4

    start:  
        mov ax, 0xABCD    ; Test values
		mov cx, 0

        push ax
        push 123

        push word [new_stack_segment]
        push word [new_stack_offset]
        call switch_stack

        pop cx
        pop bx

    end:
        mov ax, 0x4c00
        int 21h