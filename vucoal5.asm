; VU COAL CH # 3 Q: 6

[org 0x0100]

jmp begin

data: dw 7
fact_result: dw 1

begin:
    mov cx, [data]  

    mov [fact_result], cx 
    cmp cx, 1
    jbe end

    fact:
        sub cx, 1
        cmp cx, 1
        jle end

        mov dx, cx
        mov bx, 1
        mov ax, [fact_result]
        mov word [fact_result], 0

            checkbit:
                test dx, bx                        ; ax is multiplicand and cx is multiplier 
                jz skip
                
                    add [fact_result], ax
            

                skip: 
                    shl ax, 1  
                    shl bx, 1                     
                    jnz checkbit
                    jz fact  



    end:
        mov ax, 0x4c00 
        int 0x21
