; VU COAL CH # 3 Q: 4

[org 0x0100]

jmp start

data: dw 60, 55, 45, 50, -40, -35, 25, 30, 10, 0
max_num: dw 0
min_num: dw 0

start:

mov bx, 2

mov ax, [data]
mov [min_num], ax
mov[max_num], ax

loop1:
    mov ax, [data + bx + 2]
    cmp ax, [min_num]
    jnl not_min

        mov [min_num], ax

    not_min:
        cmp ax, [max_num]
        jng not_max
            
            mov [max_num], ax

    not_max:

        add bx, 2
        cmp bx, 18
        jb loop1

mov ax, 0x4c00
int 0x21

