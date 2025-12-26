; Getlen - Lib
; Author: Artik Lamartik
; Usable: getlen

getlen:
    push si
    xor ax, ax
    
.getlen_loop:
    cmp byte [si], 0
    je .getlen_done
    inc ax
    inc si
    jmp .getlen_loop
    
.getlen_done:
    pop si
    ret