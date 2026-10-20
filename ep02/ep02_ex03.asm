; CRSC04 – Arquitetura de Computadores II
; Exercício Prático 2 – EP02 Data: 20/10/2026 
; Alunos (grupo 07):
; Lucas Silva Correa | Matricula: 2026000475
; Vinicius Kadlubiski Teixeira | Matricula: 2026004699
; Exercício 03: Somatória de intervalos
%include "io64.inc"         
default rel 

section .bss
    a resd 1
    b resd 1
    
section .text
    global main
    
main:
    GET_DEC 4, a
    GET_DEC 4, b
    
    mov ebx, [a]
    mov ecx, [b]
    
    call soma                ;chama a funcao de somar intervalos
    
    PRINT_DEC 4, eax
    
    xor rax, rax             
    ret                  

;realiza um loop começando em a até b, para cada iteração, soma o atual elemento
soma:
    xor eax, eax
    enquanto:
    cmp ebx, ecx             ;se o contador de a for maior q o valor b termina
    jg fim
        add eax, ebx         ;soma os valores
        inc ebx              ;incrementa a
        jmp enquanto
        
    fim:
        ret                  ;retorna o valor da soma em eax


section .note.GNU-stack