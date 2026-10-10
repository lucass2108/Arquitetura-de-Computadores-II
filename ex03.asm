section .data
    ind1 dd 100
    v1 db 0xE5

section .bss
    ind2 resd 1
    v2 resb 1

section .text
    global _start

_start:
    mov eax, [ind1]
    mov [ind2],eax

    mov al, [v1]
    mov [v2], al

    movzx ebx, byte [v2]
    mov eax, 1
    int 0x80