org 0x7C00

start:
    mov ah, 0x0e
    mov bx, string

print:
    mov al, [bx]
    cmp al, 0
    je exit
    int 0x10
    inc bx
    jmp print
exit:
    mov bx, 0
    jmp read_key

string:
    db "sexa le wyldo", 0x0a, "lol sosi", 0x0a, "lol sosi", 0x0a, 0x0d, "kusk", 0

    
read_key:
    mov ah, 0x00
    int 0x16

    mov ah, 0x0e
    int 0x10
    
    jmp read_key

times 510-($-$$) db 0
dw 0XAA55