;EP04 06/11/2026
;Lucas Silva Correa - 2026000475

%include "io64.inc"
default rel

section .data
    

section .bss
    qtd resd 1
    vetA resd 105
    vetB resd 105
    vetC resd 105
    
    maiorA resd 1
    maiorB resd 1
    maiorC resd 1

section .text
    global main
    
main:
    ;Ler quantidade
    GET_DEC 4, eax
    mov [qtd], eax
    
    ;se qtd for menor ou igual a zero o programa encerra
    cmp eax, 0
    jle .fim
    
    ;Ler A
    mov ebx, vetA
    mov ecx, [qtd]
    call ler
    
    ;Ler B
    mov ebx, vetB
    mov ecx, [qtd]
    call ler
    
    ;C = A + B
    mov esi, vetA
    mov ebx, vetB
    mov edi, vetC
    mov ecx, [qtd]
    call somar
    
    ;Maior de A
    mov ebx, vetA
    mov ecx, [qtd]
    call maior
    mov [maiorA], eax
    
    ;Maior de B
    mov ebx, vetB
    mov ecx, [qtd]
    call maior
    mov [maiorB], eax
    
    ;Maior de C
    mov ebx, vetC
    mov ecx, [qtd]
    call maior
    mov [maiorC], eax
    
    ;Imprime A
    PRINT_STRING "Vetor A: "
    mov ecx, [qtd]
    mov ebx, vetA
    call imprimir
    
    ;Imprime Maior de A
    PRINT_STRING "Maior em A: "
    PRINT_DEC 4, [maiorA]
    NEWLINE
    
    ;Imprime B
    PRINT_STRING "Vetor B: "
    mov ecx, [qtd]
    mov ebx, vetB
    call imprimir
    
    ;Imprime Maior de B
    PRINT_STRING "Maior em B: "
    PRINT_DEC 4, [maiorB]
    NEWLINE
    
    ;Imprime C
    PRINT_STRING "Vetor C: "
    mov ecx, [qtd]
    mov ebx, vetC
    call imprimir
    
    ;Imprime maior de C
    PRINT_STRING "Maior em C: "
    PRINT_DEC 4, [maiorC]
    NEWLINE
    
    xor rax, rax
    ret
    
    ;se qtd foi inválido encerra aqui
    .fim:
    PRINT_STRING "Valor qtd inválido"
    xor rax, rax
    ret
    
ler:
    .enquanto:
    GET_DEC 4, eax  ;lê o número
    mov [ebx],eax   
    add ebx, 4      ;próximo elemento
    dec ecx         ;decrementa contador
    jnz .enquanto   ;loop
    ret

somar:
    .enquanto:
    mov eax, [esi]  ;elemento do primeiro vetor
    add eax, [ebx]  ;adiciona elemento do segundo
    mov [edi], eax  ;move o resultado para o terceiro
    ;proximo elemento
    add esi, 4
    add ebx, 4
    add edi, 4
    dec ecx         ;decrementa contador
    jnz .enquanto   ;loop
    ret

maior:
    mov eax, [ebx]  ;define o primeiro elemento como o maior
    dec ecx         ;decrementa contador
    jz .fim         ;se tiver só um elemento finaliza aqui
    
    .enquanto:
    add ebx, 4      ;proximo elemento
    cmp [ebx], eax  ;se o atual for menor q o anterior pula
    jle .prox
    mov eax, [ebx]  ;define o atual como maior
    .prox:
    dec ecx
    jnz .enquanto
    .fim:
    ret

imprimir:
    .enquanto:
    mov eax, [ebx]  ;pega o primeiro elemento
    PRINT_DEC 4, eax
    PRINT_CHAR ' '
    add ebx, 4      ;proximo
    dec ecx         ;decrementa contador
    jnz .enquanto   ;se nn for zero continua
    NEWLINE
    ret


section .note.GNU-stack