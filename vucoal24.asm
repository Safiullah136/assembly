; VU COAL CH # 5 Q: 7

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
        mov bx, 14

        loop2:
            cmp word [arr + bx], 0
            jz skipcall
            
            push word [arr + bx]

        skipcall:
            sub bx, 2
            cmp bx, -2
            jnz loop2

        _return:
            ret

    start:  
        push word test_func
        call addtoset

        push word test_func
        call addtoset

        pusha
        call callset
        popa

    end:
        mov ax, 0x4c00
        int 21h