%include "libs/macros.asm"

[BITS 16]
[ORG 0x8000]

start:
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    clrscr
    allocinit
    print msg1
    print msg2
    alloc 256
    jc alloc_failed
    scan ax
    len di, [str_len]
    print msg3
    print msg4
    print di
    print msg5
    printnum [str_len]
    free di
    cli
    hlt

alloc_failed:
    print alloc_failed_msg

%include "libs/printk.asm"
%include "libs/clearscr.asm" 
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
