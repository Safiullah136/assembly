; VU COAL CH # 4 Q: 2

[org 0x0100]

    stc
    mov ax, 46
    adc ah, 83
    cmc
    xor ah, al
    mov cl, 4
    shr al, cl
    rcr ah, cl

    mov ax, 0x4c00
    int 21h

; CF: 1  AX: 0000h
; CF: 1  AX: 002Eh
; CF: 0  AX: 542Eh
; CF: 1  AX: 542Eh
; CF: 0  AX: 7A2Eh
; CF: 0  AX: 7A2Eh
; CF: 1  AX: 7A02h
; CF: 1  AX: 5702h