; VU COAL CH # 4 Q: 8

[org 0x0100]

    jmp start

    start:
        mov ax, 0xabcd
        mov bx, 0

    init:
        mov dx, 1
        mov si, 0

    ; Counting the no. of one bits in ax

    count:
        cmp dx, 0
        jz store

        test ax, dx 
        jz skip

        inc si

    skip:
        shl dx, 1
        jmp count

    store:
        inc bx
        mov ax, si
        cmp ax, 1           ; It is mentioned in the question that ax will always have a non zero value.
							; Thats why the comparision with 0 is ommitted.

        jnz init

    end:
        mov ax, 0x4c00
        int 21h

