section .text
global _start

_start:
    mov edx, len    ;tamanho da mensagem
    mov ecx, msg    ;ponteiro da mensagem
    mov ebx, 1      ;file descriptor 1 = stdout
    mov eax, 4      ;syscall 4 = sys_write
    int 0x80

    mov eax, 1      ;syscall 1 = sys_exit
    int 0x80

section .data
    msg db 'Hello, world!', 0xA
    len equ $ - msg