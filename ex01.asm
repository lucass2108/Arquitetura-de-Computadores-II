section .data
    nome db 'Meu nome e Lucas', 0xA
    len equ $- nome
    msg db 'Estudando assembly', 0xA
    lenn equ $- msg

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, nome
    mov edx, len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, lenn
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80