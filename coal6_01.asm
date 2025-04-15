[org 0x0100]

    jmp start

    data: dw 60, 55    ; global data
    ; swapflag: db 0    ; Globals are bad! Let's make this local. 

    swap:
        push ax

        mov ax, [bx + si + 2]
        xchg [bx + si], ax
        mov [bx + si + 2], ax

        pop ax
        ret

    bubblesort:
        push bp
        mov bp, sp

        sub sp, 2           ; make space on the stack, just below BP 
                            ; only if you want to do local variables 

        push ax
        push bx
        push cx
        push si

        mov bx, [bp + 6]
        mov cx, [bp + 4]


        dec cx
        shl cx, 1

        mainloop:
            mov si, 0          ; use as array index 
            ; mov byte [swapflag], 0    ; byte to tell cpu that byte operation perform, not word. 
                                        ;Assembler gives error without it saying mention operation size

            mov word [bp - 2], 0

            innerloop:
                mov ax, [bx + si]
                cmp ax, [bx + si + 2]
                jbe noswap

                    call swap
                    mov word [bp - 2], 1

                noswap
                add si, 2
                cmp cx, si
                jne innerloop

        sub cx, 2
        je limit

            cmp word [bp - 2], 1
            je mainloop

        limit:
            pop si 
            pop cx
            pop bx
            pop ax 

            mov sp, bp

            pop bp
            ret 4

    start:
        mov bx, data         ; register data in main --> kind of global vars 
        mov cx, 2

        push bx 
        push cx

        call bubblesort

        mov ax, 0x4c00
        int 0x21


; F2 (ProcStep) --->>> procedure step; execute procedure in one go.  (AFD)


; helpful bash commands 

; hex to dec
; echo $((16#   F)) 

; dec to hex 
; printf '%x\n'   15 

; bin to hex 
; printf '%x\n' "$((2#   110010))" 

; hex to bin
; printf   '\x32'    | xxd -b | cut -d' ' -f2