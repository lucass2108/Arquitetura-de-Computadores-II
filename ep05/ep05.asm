; UNIFEI - Universidade Federal de Itajuba
; IMC - Instituto de Matematica e Computacao
; CRSC04 - Arquitetura de Computadores II
; Exercicio Pratico 5 (EP05) - Exercicio 1
; Data: 10/11/2026
; Aluno(s): Lucas Silva Correa - Matricula: 2026000475
;           Miguel Cortez Cavalcante - Matricula: 2026014891

%include "io64.inc"
default rel

section .bss
    n resd 1
    v resd 100
    sr resd 100
    m resd 1
    p resd 100
    k resd 1

section .text
    global main
    
    
main:
    ;ler n e v
    ;se eax 0 ok, 1 N inválido
    mov ebx, v
    call ler
    cmp eax, 1
    je .erro
    
    ;ler sr
    mov esi, v
    mov edi, sr
    mov ecx, [n]
    call semRep
    mov [m], eax
    
    ;ordena sr
    mov esi, v
    mov ebx, sr
    mov ecx, [m]
    call ordenar

    ;criar p com pares de sr
    mov esi, sr
    mov edi, p
    mov ecx, [m]
    call pares
    mov [k], eax
    
    ;imprimir m e sr
    PRINT_STRING "Numero de elementos em SR: "
    PRINT_DEC 4, [m]
    NEWLINE
    PRINT_STRING "Elementos em SR: "
    mov ebx, sr
    mov ecx, [m]
    call ImpVet
    
    ;imprimir k e p
    PRINT_STRING "Numero de elementos em P: "
    PRINT_DEC 4, [k]
    NEWLINE
    mov ebx, p
    mov ecx, [k]
    PRINT_STRING "Elementos em P: "
    call ImpVet
    
    xor rax, rax
    ret
    
    ;se o n era menor ou igual a 0 e maior q 100 encerra aqui
    .erro:
    PRINT_STRING "Valor de N invalido (1 - 100)"
    NEWLINE
    xor rax, rax
    ret

ler:
    GET_DEC 4, eax
    
    ;verifica se n está no intervalo permitido
    cmp eax, 100
    jg .fim
    
    cmp eax, 0
    jle .fim
    
    mov ecx, eax    ;copia quantidade
    
    xor edx, edx    ;quantidade N
    
    .enquanto:
    GET_DEC 4, eax
    
    ; se fora do intervalo ignora
    cmp eax, 100
    jg .prox
    
    cmp eax, 0
    jl .prox
    
    ;armazena o valor e pula pro próximo
    mov [ebx], eax
    add ebx, 4
    inc edx
    
    .prox:
    ; se ecx nn for zero volta pro loop
    dec ecx
    jnz .enquanto
    ;guarda a quantidade em n
    mov [n], edx
    ;limpa eax pra nn dar erro
    xor eax, eax
    
    ret
    
    ;se nn for permitido devolve eax = 1 para mostrar q deu erro
    .fim:
    mov eax, 1
    ret
    
semRep:
    xor eax, eax
    
    .prox:
    ; verifica se todos os elementos foram percorridos
    cmp ecx, 0
    je .fimRep
    
    mov edx, [esi]  ;elemento atual de v
    mov ebx, sr     ;atual de sr
    
    .enquanto:
    cmp ebx, edi    ;vê se chegou o fim de sr
    je .insere      ;se chegou o elemento ainda nn existe
    cmp [ebx], edx  ;compara os elementos
    je .rep
    add ebx, 4      ;avança para o próximo de sr
    jmp .enquanto
    
    .insere:
    mov [edi], edx  ;insere
    add edi, 4      ;proxima posição
    inc eax
    
    .rep:
    add esi, 4  ;vai para o próximo de V
    dec ecx     
    jmp .prox
    ret
    .fimRep:
    ret
    
ordenar:
    cmp ecx, 1  ;vê set tem mais de um elemento
    jle .fim
    
    mov edx, ecx    ;quant de elementos
    dec edx         ;quant de comprações na primeira chamada
    
    .passa:
    mov esi, ebx    ;volta ao inicio
    mov ecx, edx    ;define a quant de comparações
    
    .compara: 
    mov eax, [esi]          ;atual
    cmp eax, [esi + 4]      ;compara com o proximo
    jle .nTroca             ;se está na ordem pula
    mov edi, [esi+4]     
    mov [esi], edi  ;troca os dois
    mov [esi+4], eax
    .nTroca:
    add esi, 4              ;avança para o proximo
    dec ecx                 ;dec as repetições restantes
    jnz .compara
    dec edx                 
    jnz .passa
    
    .fim:
    ret
    
pares:
    xor eax, eax
    
    .enquanto:
    cmp ecx, 0
    je .fimPar
    
    mov edx, [esi]  ;atual
    mov ebx, edx    ;copia valor
    and ebx, 1      ;verica o ultimo bit
    jnz .prox       ;se for 1 é impar
    mov [edi], edx  ;adiciona a p
    add edi, 4
    inc eax
    
    ;avança
    .prox:
    add esi, 4
    dec ecx
    jmp .enquanto
    ret
    
    .fimPar:
    ret
    
ImpVet:
    cmp ecx,  0
    je .fim
    .enquanto:
    mov eax, [ebx]  ;pega o primeiro elemento
    PRINT_DEC 4, eax
    PRINT_CHAR ' '
    add ebx, 4      ;proximo
    dec ecx         ;decrementa contador
    jnz .enquanto   ;se nn for zero continua
    
    .fim:
    NEWLINE
    ret

section .note.GNU-stack