[BITS 16]
[ORG 0x7C00]

start:
    cli
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    mov ah, 0x02
    mov al, 8
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x80
    mov bx, 0x8000
    int 0x13
    jmp 0x8000
    cli
    hlt

times 510 - ($ - $$) db 0
db 0x55, 0xAA
