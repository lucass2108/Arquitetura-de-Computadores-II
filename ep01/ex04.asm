;Exercício Prático 1 - EP01 13/10/2026
;Questão 4
;Lucas Silva Correa - 2026000475
;Matheus Gouveia David - 2026003904

%include "io64.inc"
default rel

section .data
    x dd 5
    
section .bss
    y resd 1
    
section .text
    global main
    
main:
    GET_DEC 4, y
    
    mov eax, [y]
    mov ecx, [x]
    
enquanto:
    cmp ecx, 0
    jle fim_enquanto
    add eax, ecx
    dec ecx
    jmp enquanto
        
fim_enquanto:    
    PRINT_DEC 4, eax
    NEWLINE
    
    xor rax, rax
    ret

section .note.GNU-stack