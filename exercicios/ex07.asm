%include "io64.inc"
default rel
section .data
x dd 10
section .text
global main
main:
    mov eax, 10
enquanto:
    cmp eax, 0
    jle fim_enquanto
    mov ebx, eax
    sub ebx, 5          ; b = a - 5
    mov ecx, [x]
    add ecx, ebx        ; c = x + b
    dec eax             ; a = a - 1
    jmp enquanto
fim_enquanto:
    PRINT_DEC 4, ecx    ; mostra c
    xor rax, rax
    ret
section .note.GNU-stack