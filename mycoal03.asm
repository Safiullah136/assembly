[org 0x0100]

jmp start

num1: dw 0x8001

start:
    mov al, 0xFF
    add [num1], al

mov ax, 0x4c00
int 0x21 