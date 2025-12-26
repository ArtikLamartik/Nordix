; Kalloc - Lib
; Author: Artik Lamartik
; Usable: kmalloc, kfree, kalloc_init

kalloc_init:
    push ax
    push bx
    push cx
    push dx
    mov ax, 0xB000
    mov [heap_start], ax
    mov [heap_end], ax
    add ax, 1024
    mov [heap_ptr], ax
    mov bx, [heap_ptr]
    mov word [bx], 0
    mov word [bx+2], 65535
    mov byte [bx+4], 0
    pop dx
    pop cx
    pop bx
    pop ax
    ret

kmalloc:
    push bx
    push cx
    push dx
    push si
    push di
    mov si, [heap_ptr]
    
kmalloc_search:
    cmp word [si], 0
    je kmalloc_check_last
    cmp byte [si+4], 0
    jne kmalloc_next
    mov ax, [si+2]
    cmp ax, bx
    jb kmalloc_next
    mov byte [si+4], 1
    mov ax, si
    add ax, 5
    jmp kmalloc_done
    
kmalloc_next:
    mov si, [si]
    jmp kmalloc_search

kmalloc_check_last:
    cmp byte [si+4], 0
    jne kmalloc_fail
    mov ax, [si+2]
    cmp ax, bx
    jb kmalloc_fail
    mov byte [si+4], 1
    mov ax, si
    add ax, 5
    jmp kmalloc_done

kmalloc_fail:
    xor ax, ax

kmalloc_done:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret

kfree:
    push ax
    push bx
    mov ax, bx
    sub ax, 5
    mov bx, ax
    mov byte [bx+4], 0
    pop bx
    pop ax
    ret

heap_start: dw 0
heap_end:   dw 0  
heap_ptr:   dw 0