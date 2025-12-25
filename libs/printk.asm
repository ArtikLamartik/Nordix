; Printk - Lib
; Author: Artik Lamartik

printk:
    mov al, [si]
    inc si
    cmp al, 0
    je .done
    cmp al, 10
    je .newline
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    jmp printk

.newline:
    mov al, 13
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    mov al, 10
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    jmp printk

.done:
    ret