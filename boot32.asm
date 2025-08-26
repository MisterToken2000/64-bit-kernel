org 0x7c00

jmp load

start:

	times 0Bh-$+start db 0

load:

	mov ebp, 0x9000                       ; Set stack base at top of free space
	mov esp, ebp
	mov ah, 00
	int 0x13

; Load kernel to memory
read_sector:
	pusha
	mov ax, 0x0
	mov es, ax      ; ES = 0
	mov bx, 0x1000  ; BX = 0x1000. ES:BX=0x0:0x1000
                	; ES:BX = starting address to read sector(s) into
	mov ah, 02      ; Int 13h/AH=2 = Read Sectors From Drive
	mov al, 15      ; Sectors to read = 15
	mov ch, 00      ; CH=Cylinder. Second sector of disk
                	; is at Cylinder 0 not 1
	mov cl, 02      ; Sector to read = 2
	mov dh, 00      ; Head to read = 0
                	; DL hasn't been destroyed by our bootloader code and still
                	; contains boot drive # passed to our bootloader by the BIOS
	int 0x13
	popa

	cli




	xor ax,ax
	mov ds, ax

	lgdt [gdt_descriptor]



	mov eax, cr0
	or eax, 0x1

	mov cr0, eax



	jmp gdt_codeSeg:init_pm



[bits 32]


init_pm:

	mov ax, gdt_dataSeg                     ; Update segments for protected mode as defined in GDT
	mov ds, ax
	mov ss, ax
	mov es, ax
	; mov fs, ax
	; mov gs, ax

	mov ebp, 0x9000                       ; Set stack base at top of free space
	mov esp, ebp

clear_screen:
	mov edi, 0xb8000
	mov ecx, 80 * 25
	mov ax, 0x0720

.loop:
	mov word [edi], ax
	add edi, 2
	loop .loop

print_text:
	mov dword [0xb8000], 0x076d076a
	mov dword [0xb8004], 0x07200770
	mov dword [0xb8008], 0x07780730
	mov dword [0xb800c], 0x07380730
	mov dword [0xb8010], 0x0730073a
	mov dword [0xb8014], 0x07310778
	mov dword [0xb8018], 0x07300730
	mov dword [0xb801c], 0x072e0730

	mov ecx, 0x2fffffff

.b:
	dec ecx
	jnz .b

boot:
	jmp 0x08:0x1000 ; Jump to kernel header

; Global descriptor table for 32-bit protected mode
gdt_start:                              ; Start of global descriptor table
    gdt_null:                           ; Null descriptor chunk
        dd 0x00
        dd 0x00
    gdt_code:                           ; Code descriptor chunk
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0x9A
        db 0xCF
        db 0x00
    gdt_data:                           ; Data descriptor chunk
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0x92
        db 0xCF
        db 0x00
    gdt_end:                            ; Bottom of table
gdt_descriptor:                         ; Table descriptor
    dw gdt_end - gdt_start - 1          ; Size of table
    dd gdt_start                        ; Start point of table

gdt_codeSeg equ gdt_code - gdt_start    ; Offset of code segment from start
gdt_dataSeg equ gdt_data - gdt_start    ; Offset of data segment from start

; Tail

times 510 -( $ - $$ ) db 0
dw 0xaa55
