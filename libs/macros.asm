%macro print 1
    mov si, %1
    call printk
%endmacro

%macro printnum 1
    mov ax, %1
    call printnumk
%endmacro

%macro clrscr 0
    call clearscr
%endmacro

%macro scan 1
    mov di, %1
    call scank
%endmacro

%macro allocinit 0
    call kalloc_init
%endmacro

%macro alloc 1
    mov bx, %1
    call kmalloc
%endmacro

%macro free 1
    mov bx, %1
    call kfree
%endmacro

%macro len 2
    mov si, %1
    call getlen
    mov %2, ax
%endmacro
