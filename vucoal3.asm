; VU COAL CH # 3 Q: 5

[org 0x0100]

jmp begin

data: db -40, -35, 0, 10, 25, 30, 45, 50, 55, 60 
start: db 0
end: db 10
key: db 1

begin:

    mov al, [key]
    mov bh, 0

    search:
        mov cl, [start]
        cmp cl, [end]
        ja not_found

        mov bl, [start]
        add bl, [end]
        sar bl, 1

        cmp [data + bx], al
        je found
        jl less
        jg greater

    less:
        add bl, 1
        mov [start], bl
        jmp search

    greater:
        sub bl, 1
        mov [end], bl
        jmp search

    found:
        mov ax, 1
        mov ax, 0x4c00
        int 0x21 

    not_found:
        mov ax, 0
        mov ax, 0x4c00
        int 0x21

    