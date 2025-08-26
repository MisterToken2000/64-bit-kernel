bits 64
global loadkernel
extern main
extern print
extern clear_screen
extern newline

loadkernel:
mov ax, 0
mov ss, ax
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax

call clear_screen
mov rax, 0x0f5d024b024f0f5b
mov qword [0xb8000], rax
call newline
call main
