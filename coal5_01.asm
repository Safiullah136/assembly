; https://github.com/recluze/assembly-lang-course/blob/master/c05-01.asm



; in modern OSs, programs do not start executing
; "from the first instruction"

; instead, there is a library (ld.so) that looks for the "start symbol"
; and executes from there

; a 'section' directive marks the parts of a program
; for the ELF format (or whatever binary format you are using)



SECTION .text

; We mark the start for this library using the following:  
GLOBAL _start

_start:                                                                                   
    ; write the string to console
    mov eax, 0x4                   ; write syscall is 0x4
    mov ebx, 1                     ; parameter - std output (1) console should be used     Other option: File Output.
    mov ecx, message               ; the string to write
    mov edx, message_length        ; the length of the string
    int 0x80                        ; invoke the system call

    ; exit the program
    mov eax, 0x1                   ; exit system call is 0x0
    mov ebx, 0                     ; exit code is 0 (return 0) error free execution 
    int 0x80                        ; 0x80 for linux



; data section here. We can also move it above .code
SECTION .data:
    ; 0xA is new line, 0x0 is null terminator 
    message: db "Hello!", 0xA, 0x0
    message_length: equ $-message

    ; message_length: equ 8 
	; .... is exactly the same as 
	; #define message_length 8 
    ; equ --> assemble time replace all message length labels with value computed by ($-message)
    ; $ -> current line address - (message) line address ==> string length
    ; string length given b/c it is char array and when array create length told


; -f elf32 : format 32 bit exe. default was 64 bit on 64 bit machine.

