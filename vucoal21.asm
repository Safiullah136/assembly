; VU COAL CH # 5 Q: 4

[org 0x0100]

    jmp start

    fib:
        push bp
        mov bp, sp
        push cx
        push bx
        push ax

        mov ax, 0
        mov cx, 1
        mov bx, [bp + 4]

        zero:
            cmp bx, 0
            jne loop1
            mov cx, 0
            jmp return

        loop1:
            dec bx
            cmp bx, 0
            je return

            xchg ax, cx
            add cx, ax
            jmp loop1

    return:
        mov [bp + 6], cx
        pop ax
        pop bx
        pop cx
        pop bp
        ret 2


    start:
        sub sp, 2

        mov bx, 0
        push bx

        call fib

        pop ax

    end:
        mov ax, 0x4c00
        int 21h



; def fib(n):
;     if n == 0:
;         return 0

;     a, b = 0, 1

;     for i in range(n - 1):
;         a, b = b, a + b

;     return b