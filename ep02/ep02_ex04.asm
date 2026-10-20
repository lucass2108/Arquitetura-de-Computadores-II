; CRSC04 – Arquitetura de Computadores II
; Exercício Prático 2 – EP02 Data: 20/10/2026 
; Alunos (grupo 07):
; Lucas Silva Correa | Matricula: 2026000475
; Vinicius Kadlubiski Teixeira | Matricula: 2026004699
; Exercício 04: ver o maior em array

%include "io64.inc"
default rel
section .data
    i dd 0
section .bss
    array resd 6
    temp resd 1

section .text
    global main

main:
    call ler
    call maior

    PRINT_DEC 4, eax

    xor eax, eax
    ret

ler:

    mov ecx, [i]

    .enquanto:
    cmp ecx, 6    ;verifica se leu os seis valores
    jge .fim

        GET_DEC 4, temp
        mov eax, [temp]

        mov [array + ecx*4], eax ;guarda o valor

        inc ecx   ;incrementa o contador
        jmp .enquanto

    .fim:
    ret

maior:
    mov eax, [array]    ;considera o primeiro valor como maior
    mov ecx, 1    ;contador, comeca pelo segundo elemento

    .enquanto_maior:
    cmp ecx, 6    ;verifica se percorreu o vetor
    jge .fim_maior

        mov edx, [array +ecx*4] ;pega o valor atual

        cmp edx, eax    ;compara com o maior atual
        jle .proximo

        mov eax, edx    ;atualiza o maior

    .proximo:
        inc ecx
        jmp .enquanto_maior

    .fim_maior:
        ret

section .note.GNU-stack noalloc noexec nowrite progbits