[BITS 16]
[ORG 0x8000]

start:
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    call clrscr
    mov si, msg
    call printk
    mov si, msg2
    call printk
    mov di, input_buffer
    call scank
    mov si, msg4
    call printk
    mov si, msg3
    call printk
    mov si, input_buffer
    call printk
    cli
    hlt

%include "libs/printk.asm"
%include "libs/clrscr.asm"
%include "libs/scank.asm"

msg db 'Hello, World Kernel!', 10, 0
msg2 db 'Text:', 0
msg3 db 10, 'You typed: ', 0
msg4 db 10, '----------------', 0
input_buffer times 1024 db 0