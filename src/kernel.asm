[BITS 16]
[ORG 0x8000]

start:
    mov ax, 0x00
    mov ds, ax
    mov es, ax

    call clrscr

    call kalloc_init

    mov si, msg1
    call printk
    mov si, msg2
    call printk

    mov bx, 0
    call kmalloc
    jc alloc_failed

    mov di, ax
    call scank

    mov si, di
    call getlen
    mov [str_len], ax

    mov si, msg3
    call printk
    mov si, msg4
    call printk

    mov si, di
    call printk

    mov si, msg5
    call printk

    mov ax, [str_len]
    call printnumk

    mov bx, di
    call kfree

    cli
    hlt

alloc_failed:
    mov si, alloc_failed_msg
    call printk

%include "libs/printk.asm"
%include "libs/clrscr.asm" 
%include "libs/scank.asm"
%include "libs/kalloc.asm"
%include "libs/getlen.asm"

str_len dw 0
alloc_failed_msg db 'Memory allocation failed!', 10, 0
msg1 db 'Hello, World Kernel!', 10, 0
msg2 db 'Text: ', 0
msg3 db 10, '----------------', 0
msg4 db 10, 'You typed: ', 0
msg5 db 10, 'Length: ', 0
