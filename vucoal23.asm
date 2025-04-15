; VU COAL CH # 5 Q: 6

[org 0x0100]

    jmp start

    arr: dw 0, 0, 0, 0, 0, 0, 0, 0

    test_func:
        ret

    addtoset:
        push bp
        mov bp, sp
        push bx
        push dx

        mov bx, 0

        loop1
            cmp word [arr + bx], 0
            jnz skip

            mov dx, [bp + 4]
            mov [arr + bx], dx
            jmp return

        skip:
            add bx, 2

            cmp bx, 16
            jnz loop1
        
        return:
            pop dx
            pop bx
            pop bp
            ret 2
        
    callset:
        push bp
        mov bp, sp
        push bx

        mov bx, 0

        loop2:
            cmp word [arr + bx], 0
            jz skipcall
            call [arr + bx]

        skipcall:
            add bx, 2
            cmp bx, 16
            jnz loop2

        _return:
            pop bx 
            pop bp
            ret

    start:  
        push word test_func
        call addtoset

        push word test_func
        call addtoset

        call callset

    end:
        mov ax, 0x4c00
        int 21h