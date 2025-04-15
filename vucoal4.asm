; VU COAL CH # 3 Q: 6

[org 0x0100]

jmp begin

data: dw 0

begin:
    mov cx, 2
    mov ax, 1

    cmp word [data], 1
    jbe end

    fact:
        mov dx, ax 
        mov bx, cx

        innerloop:
            add ax, dx

            sub bx, 1
            cmp bx, 1
            ja innerloop

        add cx, 1
        cmp cx, [data]
        jbe fact

    end:
        mov ax, 0x4c00 
        int 0x21
