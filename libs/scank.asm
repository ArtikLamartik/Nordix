; Scank - Lib
; Author: Artik Lamartik
; Usable: skank

scank:
    push ax
    push cx
    push di
    push si
    push dx
    mov si, di
    mov cx, 0

read_loop:
    mov ah, 0x00
    int 0x16
    cmp al, 0x0D
    je input_done
    cmp al, 0x08
    je handle_backspace
    cmp al, 0x00
    je handle_special_key
    push ax
    push bx
    push di
    mov di, si
    add di, cx
    push cx
    mov bx, di
    find_end_insert_shift:
        cmp byte [di], 0
        je end_found_insert_shift
        inc di
        jmp find_end_insert_shift
    end_found_insert_shift:
    shift_insert_loop_shift:
        cmp di, bx
        je shift_insert_done_shift
        mov al, [di - 1]
        mov [di], al
        dec di
        jmp shift_insert_loop_shift
    shift_insert_done_shift:
    pop cx
    pop di
    pop bx
    pop ax
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    push di
    mov di, si
    add di, cx
    mov [di], al
    pop di
    inc cx
    push di
    push cx
    push dx
    mov di, si
    add di, cx
    mov dx, 0
    redraw_shift_rest:
        mov al, [di]
        cmp al, 0
        je redraw_shift_done
        mov ah, 0x0E
        mov bx, 0x07
        int 0x10
        inc di
        inc dx
        jmp redraw_shift_rest
    redraw_shift_done:
    backspace_rest_shift:
        cmp dx, 0
        je backspace_done_shift
        mov ah, 0x0E
        mov al, 0x08
        mov bx, 0x07
        int 0x10
        dec dx
        jmp backspace_rest_shift
    backspace_done_shift:
    pop dx
    pop cx
    pop di
    jmp read_loop

handle_special_key:
    cmp ah, 0x48
    je handle_up_arrow
    cmp ah, 0x50
    je handle_down_arrow
    cmp ah, 0x4B
    je handle_left_arrow
    cmp ah, 0x4D
    je handle_right_arrow
    jmp read_loop

handle_left_arrow:
    cmp cx, 0
    jle read_loop
    dec cx
    mov ah, 0x0E
    mov al, 0x08
    mov bx, 0x07
    int 0x10
    jmp read_loop

handle_right_arrow:
    push di
    mov di, si
    add di, cx
    cmp byte [di], 0
    je right_arrow_done
    inc cx
    mov al, [di]
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    right_arrow_done:
    pop di
    jmp read_loop

handle_up_arrow:
    cmp cx, 0
    je up_arrow_done
    up_arrow_loop:
        cmp cx, 0
        je up_arrow_done
        dec cx
        mov ah, 0x0E
        mov al, 0x08
        mov bx, 0x07
        int 0x10
        jmp up_arrow_loop
    up_arrow_done:
    jmp read_loop

handle_down_arrow:
    push di
    mov di, si
    add di, cx
    cmp byte [di], 0
    je down_arrow_done
    inc cx
    mov al, [di]
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    pop di
    jmp handle_down_arrow
    down_arrow_done:
    pop di
    jmp read_loop

handle_backspace:
    cmp cx, 0
    jle read_loop
    dec cx
    mov ah, 0x0E
    mov al, 0x08
    mov bx, 0x07
    int 0x10
    push di
    mov di, si
    add di, cx
    shift_loop_backspace:
        mov al, [di + 1]
        mov [di], al
        cmp al, 0
        je shift_done_backspace
        inc di
        jmp shift_loop_backspace
    shift_done_backspace:
    pop di
    push di
    push cx
    mov di, si
    add di, cx
    redraw_loop_backspace:
        mov al, [di]
        cmp al, 0
        je redraw_done_backspace
        mov ah, 0x0E
        mov bx, 0x07
        int 0x10
        inc di
        jmp redraw_loop_backspace
    redraw_done_backspace:
    mov ah, 0x0E
    mov al, ' '
    mov bx, 0x07
    int 0x10
    pop cx
    mov di, si
    add di, cx
    reposition_loop_backspace:
        mov al, [di]
        cmp al, 0
        je reposition_done_backspace
        mov ah, 0x0E
        mov al, 0x08
        mov bx, 0x07
        int 0x10
        inc di
        jmp reposition_loop_backspace
    reposition_done_backspace:
    mov ah, 0x0E
    mov al, 0x08
    mov bx, 0x07
    int 0x10
    pop di
    jmp read_loop

input_done:
    push di
    mov di, si
    add di, cx
    mov byte [di], 0
    pop di
    pop dx
    pop si
    pop di
    pop cx
    pop ax
    ret
