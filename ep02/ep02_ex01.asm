; CRSC04 – Arquitetura de Computadores II
; Exercício Prático 2 – EP02 Data: 20/10/2026 
; Alunos (grupo 07):
; Lucas Silva Correa | Matricula: 2026000475
; Vinicius Kadlubiski Teixeira | Matricula: 2026004699
; Exercício 01: números impares

%include "io64.inc"         
default rel                  

section .data
    msg db ' ', 0   
             
section .bss
    n resd 1    ;n
    
section .text
    global main                  

main:
    GET_DEC 4, n        
    
    mov ecx, [n]                ;guarda quantos faltam para imprimir
    mov eax, 1                  ; 1

    ;loop imprime de 1 a 2n-1, saltando de 2 em 2
    .enquanto:
    cmp ecx, 0                  ;verifica se ecx é maior do que 0, se sim, continua a contagem
    jle .fim_enquanto         
    
        PRINT_DEC 4, eax        

        dec ecx                 ; decrementa do contador
    
        PRINT_STRING msg        
        add eax, 2              ;adicona 2 para ir pro próximo número
        jmp .enquanto           ;volta pro começo
        
    .fim_enquanto:
    
    xor rax, rax            
    ret                    


section .note.GNU-stack

