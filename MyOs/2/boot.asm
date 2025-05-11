org 0x7C00

start:
    mov ah, 0x0e    ; Функция вывода символа
    mov si, 0       ; Начальная позиция курсора (строка)
    mov di, 0       ; Начальная позиция курсора (столбец)

cursor_loop:
    ; Устанавливаем позицию курсора
    mov ah, 0x02    ; Функция установки позиции курсора
    mov bh, 0x00    ; Номер страницы
    mov dh, byte [si] ; Строка (используем байт из si)
    mov dl, byte [di] ; Столбец (используем байт из di)
    int 0x10        ; Вызов прерывания BIOS

    ; Ожидаем нажатия клавиши
    mov ah, 0x00    ; Функция чтения клавиши
    int 0x16        ; Вызов прерывания BIOS для чтения клавиши

    ; Проверяем нажатую клавишу
    cmp al, 0x00    ; Проверяем на расширенные клавиши
    je extended_key

    jmp cursor_loop  ; Если не расширенная клавиша, продолжаем цикл

extended_key:
    ; Читаем скан-код клавиши
    mov ah, 0x00    ; Функция чтения клавиши
    int 0x16        ; Вызов прерывания BIOS для чтения клавиши

    ; Проверяем скан-код
    cmp ah, 0x48    ; Скан-код клавиши "вверх"
    je move_up

    cmp ah, 0x50    ; Скан-код клавиши "вниз"
    je move_down

    cmp ah, 0x4B    ; Скан-код клавиши "влево"
    je move_left

    cmp ah, 0x4D    ; Скан-код клавиши "вправо"
    je move_right

    jmp cursor_loop  ; Если не клавиша со стрелкой, продолжаем цикл

move_up:
    dec si          ; Перемещаем курсор вверх
    jmp cursor_loop

move_down:
    inc si          ; Перемещаем курсор вниз
    jmp cursor_loop

move_left:
    dec di          ; Перемещаем курсор влево
    jmp cursor_loop

move_right:
    inc di          ; Перемещаем курсор вправо
    jmp cursor_loop

times 510-($-$$) db 0
dw 0xAA55
