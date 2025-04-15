; VU COAL CH # 7 Q: 1

[org 0x0100]

    jmp start

    flag: db 0

    start:
        mov al, 0x0f            ; Byte to find
        mov bx, 0x0000          ; Starting from segment 0x0000

    l1:
        mov es, bx

        mov di, 0
        mov cx, 0xffff

        cld 
        repne scasb
        je found

        add bx, 0x1000
        cmp bx, 0
        jz notfound
        jnz l1

    found:
        mov byte [flag], 1
        jmp end

    notfound:
        jmp end

    end:
        mov ax, 0x4c00 
        int 21h