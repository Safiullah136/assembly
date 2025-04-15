; vucoal chap 02 Q: 10

[org 0x0100]

mov ax, 0
mov cx, 20

square:
    add ax, 20
    dec cx
    jne square

mov ax, 0x4c00
int 0x21