;Exercício Prático 1 - EP01 13/10/2026
;Questão 3
;Lucas Silva Correa - 2026000475
;Matheus Gouveia David - 2026003904

%include "io64.inc"
default rel

section .data
    x dd 10
    
section .bss
    y resd 1
   
section .text
    global main
    
main:
    GET_DEC 4,y
    
    mov eax, [y]
    
    cmp eax, 5
    jl .entao      
    cmp eax, 10
    jge .entao      
.senao:
    add eax,eax
    add [x],eax
    jmp .fimse
    
.entao:
    add [x],eax
    
.fimse:
    mov eax, [x]
    PRINT_DEC 4, eax
    NEWLINE
    
    xor rax, rax
    ret
        

section .note.GNU-stack