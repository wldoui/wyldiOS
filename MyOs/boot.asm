org 0x7C00

start:
    mov ax, 0x13
	int 0x10
    jmp draw_pixel

draw_pixel:
    ;Графический режим 
	;Размер экрана 320x200, 256 цветов
    mov ax, 0x13
    int 0x10

    mov ax, 0xA000
    mov es, ax

    mov di, 320 * 100 + 150

    mov cx, 10
    mov al, 0x40
cycle:
	call render
	jmp cycle
render:
	;doLoopX:
		;doLoopY:
			
		;endLoopY:
	;endLoopX:
	mov [es:di], al
	inc di
	
	mov al, al
	inc al
	


times 510-($-$$) db 0
dw 0xAA55
