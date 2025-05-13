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
string2:
db "SYKA SYKA IDI NAHYI BLYAT DA", 0x0a, "lol troll syks", 0x0a, "nah id win", 0x0a, 0x0d, "kiosk", 0

    
read_key:
    mov ah, 0x00
    int 0x16

    cmp al, 0xE0
    je check_arrow

    mov ah, 0x0e
    int 0x10

    jmp read_key
	
check_arrow:
    mov ah, 0x00
    int 0x16

    cmp ah, 0x4B
    je move_cursor_left

    jmp read_key

move_cursor_left:
	mov ah, 0x0e
	mov bx, string2
	mov ah, 0x03
    int 0x10
    cmp dl, 0x1B
    je end_move 

    dec dl

    mov ah, 0x02  
    int 0x10 
	jmp read_key
	
end_move:
	jmp $

times 510-($-$$) db 0
dw 0XAA55