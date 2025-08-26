[bits 64]

file_load_va: equ 4096 * 40

db 0x7f, 'E', 'L', 'F'
db 2
db 1
db 1
db 0
dq 0
dw 2
dw 0x3e
dd 1
dq entry_point + file_load_va
dq program_headers_start
dq 0
dd 0
dw 64
dw 0x38
dw 1
dw 0x40
dw 0
dw 0

program_headers_start:
dd 1
dd 5
dq 0
dq file_load_va
dq file_load_va
dq file_end
dq file_end
dq 0x200000

entry_point:
  ; Устанавливаем eax (и, как следствие, rax) на 1. (Номер системного вызова write).
  xor eax, eax
  inc eax
  ; Устанавливаем edi (и, как следствие, rdi) на 1. (Файловый дескриптор для stdout).
  mov edi, eax
  ; Устанавливаем esi (и, как следствие, rsi) на виртуальный адрес строки.
  mov esi, file_load_va + message
  ; Устанавливаем edx (и, как следствие, rdx) на длину строки.
  xor edx, edx
  mov dl, message_length
  ; Осуществляем системный вызов write.
  syscall
  ; Предполагая успешность write, rax уже равен 0, значит устанавливаем номер следующего 
  ;системного вызова на 60 для совершения exit.

  mov al, 60
  ; Устанавливаем статус exit на 0.
  xor edi, edi
  ; Выходим из программы.
  syscall
code_end:

message: db `Hello, world!\n`
message_length: equ $ - message

file_end:
