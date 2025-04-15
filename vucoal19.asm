; VU COAL CH # 5 Q: 3

[org 0x0100]

    jmp start

    fib:
        push bp
        mov bp, sp
        sub sp, 2

        push bx 
        push dx

        mov bx, [bp + 4]

        cmp bx, 0
        jne notzero
        
        mov word [bp + 6], 0
        jmp return

        notzero:       
            cmp bx, 1
            jne calls

            mov word [bp + 6], 1                
            jmp return

        calls:
            sub sp, 2
            
            dec bx
            push bx
            call fib

            pop word [bp - 2]             ;A local variable used to store the return value from the first 
											  ;recursive call

            sub sp, 2

            dec bx
            push bx
            call fib
            pop dx 
            
            add dx, [bp - 2]
            mov [bp + 6], dx


        return:
            pop dx
            pop bx
            mov sp, bp
            pop bp
            ret 2

    start:
        sub sp, 2

        mov bx, 7
        push bx

        call fib

        pop ax

    end:
        mov ax, 0x4c00
        int 21h