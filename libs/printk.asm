; Printk - Lib
; Author: Artik Lamartik
; Usable: printk, printnumk

printk:
    mov al, [si]
    inc si
    cmp al, 0
    je .printk_done
    cmp al, 10
    je .printk_newline
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    jmp printk

.printk_newline:
    mov al, 13
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    mov al, 10
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    jmp printk

.printk_done:
    ret

printnumk:
    push ax
    push bx
    push cx
    push dx
    push si
    test ax, ax
    jnz .printnumk_convert_number
    mov si, printnumk_zero_str
    call printk
    jmp .printnumk_done
    mov bx, 10
    xor cx, cx

.printnumk_convert_number:
    mov bx, 10
    xor cx, cx

.printnumk_convert_loop:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    test ax, ax
    jnz .printnumk_convert_loop

.printnumk_digits:
    pop dx
    mov [printnumk_temp_char], dl
    mov [printnumk_temp_char+1], byte 0
    mov si, printnumk_temp_char
    call printk
    loop .printnumk_digits

.printnumk_done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

printnumk_temp_char db 0, 0, 0
printnumk_zero_str db '0', 0
