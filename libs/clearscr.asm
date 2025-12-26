; Clearscr - Lib
; Author: Artik Lamartik
; Usable: clearscr

clearscr:
    mov ax, 0x03
    int 0x10
    mov ah, 0x02
    mov bh, 0x00
    mov dh, 0x00
    mov dl, 0x00
    int 0x10
    ret
