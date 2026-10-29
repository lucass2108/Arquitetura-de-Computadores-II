;EP 03 - 27/10/2026
;Lucas Silva Correa - 2026000475
;Vinicius Guimarães Lopes - 2026003780

%include "io64.inc"
default rel

section .data
    frase_qtdLetras db "Quantidade de letras (qletras): ",0
    frase_qtdPalavras db "Quantidade de palavras (qplavras): ", 0
    frase_asmExtraido db "Assembly extraido (palavra): ",0
    frase_palavraM db "Palavra em maiusculo: ",0
    frase_maius db "Frase com maiculas (frase1): ",0
    frase_maiorP db "Maior palavra (maior): ",0
    frase_maiorqtd db "Quantidade de letras da maior (qmaior): ",0
    frase_menorP db "Menor palavra (menor): ",0
    frase_menorqtd db "Quantidade de letra de menor (qmenor): ", 0
    
section .bss
    frase resb 200
    qletras resd 1
    qpalavras resd 1
    palavra resb 9 
    frase1 resb 200
    maior resb 30
    menor resb 30
    qmaior resd 1
    qmenor resd 1
    
section .text
    global main
    
main:
    ;lê a frase
    ;quem gosta de programar em assembly eh alguem que aprecia o controle absoluto sobre o hardware e a eficiencia maxima enfrentando cada byte e bit como um desafio de precisao e performance
    GET_STRING frase, 200
    call por_zero
    
    call qtdLetras
    PRINT_STRING frase_qtdLetras
    PRINT_DEC 4, [qletras]
    NEWLINE
    
    call qtdPalavras
    PRINT_STRING frase_qtdPalavras
    PRINT_DEC 4, [qpalavras]
    NEWLINE
    
    call extrairAsm
    PRINT_STRING frase_asmExtraido
    PRINT_STRING palavra
    NEWLINE
    
    call palavraMaiuscula
    
    PRINT_STRING frase_palavraM
    PRINT_STRING palavra
    NEWLINE
    
    call copiar
    PRINT_STRING frase_maius
    PRINT_STRING frase1
    NEWLINE
    
    call procurar_maior
    PRINT_STRING frase_maiorP
    PRINT_STRING maior
    NEWLINE
    PRINT_STRING frase_maiorqtd
    PRINT_DEC 4, [qmaior]
    NEWLINE
    
    call procurar_menor
    PRINT_STRING frase_menorP
    PRINT_STRING menor
    NEWLINE
    PRINT_STRING frase_menorqtd
    PRINT_DEC 4, [qmenor]
    NEWLINE
    
    xor rax, rax
    ret

por_zero:
    mov rsi, frase
    mov ecx, 199
    
.enquanto:
    mov al, [rsi]
    cmp al, 0
    je .fim
    cmp al, 10
    je .poe_zero
    cmp al, 13
    je .poe_zero
    inc rsi
    dec ecx
    jnz .enquanto
    
.poe_zero: 
    mov byte [rsi],0
 
.fim:
    ret

;Verifica a quantidade de letras
qtdLetras:
    mov rsi, frase 
    mov dword [qletras], 0 
    
.enquanto:
    ;verifica se o dígito é 0 (fim)
    mov al, [rsi]
    cmp al, 0
    je .fim
    
    ;verifica se é espaço
    cmp al, ' '
    je .prox
    
    inc dword [qletras]
    
.prox:
    ;pula pra próxima letra
    inc rsi
    jmp .enquanto
    
.fim:
    ret

;verifica a quantidade de palavras
qtdPalavras:
    mov  rsi, frase
    mov bl, 1               ;1 = inicio da palavra
    mov dword [qpalavras], 0
    
.enquanto:
    ;verifica se o dígito é 0 (fim)
    mov al, [rsi]
    cmp al, 0
    je .fim
    
    ;vê se é espaço
    cmp al, ' '
    je .espaco
    
    ; se nn for 1 então verifica o próximo digito
    cmp bl, 1
    jne .prox
    
    ;encontrou uma palavra
    inc dword [qpalavras]
    mov bl, 0
    jmp .prox
    
.espaco:
    ;faz bl = 1 e segue pro próximo
    mov bl, 1
    
.prox:
    ;próximo dígito
    inc rsi
    jmp .enquanto

.fim:
    ret
    
extrairAsm:
    mov rsi, frase

.extrair_loop:
    ;se nn for igual pula pro próximo
    cmp byte [rsi], 'a'
    jne .extrair_proximo
    cmp byte [rsi+1], 's'
    jne .extrair_proximo
    cmp byte [rsi+2], 's'
    jne .extrair_proximo
    cmp byte [rsi+3], 'e'
    jne .extrair_proximo
    cmp byte [rsi+4], 'm'
    jne .extrair_proximo
    cmp byte [rsi+5], 'b'
    jne .extrair_proximo
    cmp byte [rsi+6], 'l'
    jne .extrair_proximo
    cmp byte [rsi+7], 'y'
    jne .extrair_proximo
   
    ;se executou tudo significa q achou assembly e rdi indica o começo e ecx o tamanho
    mov rdi, palavra
    mov ecx, 8

;copia os dígitos para palavra
.extrair_copiar:
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec ecx
    cmp ecx, 0
    jg .extrair_copiar

    mov byte [rdi], 0
    ret

.extrair_proximo:
    ;vê se é 0 (fim)
    cmp byte [rsi], 0
    je .extrair_nao_encontrou
    ;avança um dígito
    inc rsi
    jmp .extrair_loop

.extrair_nao_encontrou:
;não encontrou assembly na frase
    mov byte [palavra], 0
    ret
    
        
    
palavraMaiuscula:
    mov rsi, palavra
    
.enquanto:
    mov al, [rsi]
    ;verfica se é 0 (fim)
    cmp al, 0
    je .fim
    
    ;subtrai 32 para transformar em maiuscula
    sub byte [rsi], 32
    
.prox:
    ;vai pro próximo dígito
    inc rsi
    jmp .enquanto
    
.fim:
    ret
    
copiar:
    mov rsi, frase
    mov rdi, frase1
    mov bl, 1       ;indica ser o ínicio de uma palavra

.enquanto:
    mov al, [rsi]

    ;verifica se é 0 (fim)
    cmp al, 0
    je .fim

    ;verifica se é espaço 
    cmp al, ' '
    je .espaco
    
    ; se nn for 1 então apenas copia
    cmp bl, 1
    jne .grava

    ; se for 1 então deixa maiuscula e grava
    sub al, 32
    mov bl, 0
    jmp .grava

.espaco:
    mov bl, 1

.grava:
    mov [rdi], al
    inc rsi
    inc rdi
    jmp .enquanto

.fim:
    ;finaliza com 0
    mov byte [rdi], 0
    ret

;procura a maior palavra da frase  
procurar_maior:
    mov rsi, frase
    mov dword [qmaior], 0
    mov byte [maior],0
    
.enquanto: 
    ;guarda o começo da palavra
    mov rbx, rsi
    ;zera o contador
    xor ecx, ecx
    
.maior_conta:
    mov al, [rsi]
    
    ;verifica o espaço - fim da palavra
    cmp al, ' '
    je .compara
    
    ;Verifica se termina em 0 (fim) - fim da palavra
    cmp al, 0
    je .compara
    
    ;incrementa o contador e pula pro próximo dígito
    inc ecx
    inc rsi
    jmp .maior_conta
    
.compara:
    ;verifica se encontrou uma palavra maior
    cmp ecx, [qmaior]
    jle .prox
    
    mov [qmaior], ecx
    mov rdi, maior  ;aponta onde a palavra será copiada
    mov rsi, rbx    ;inicio da palavra
    
    mov edx, ecx    ; quant de letras a serem copiadas
    
.copia:
    cmp edx, 0      ; vê se tem mais letras a serem copiadas
    je .termina
    ;pega o dígito e envia para maior
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec edx
    jmp .copia
 
.termina:
    ;coloca 0 no final
    mov byte[rdi], 0
    mov rsi, rbx
    add rsi, rcx
   
.prox:
    cmp byte [rsi],0
    je .fim
    inc rsi
    jmp .enquanto
    
.fim:
    ret

;verifica qual a menor palavra
procurar_menor:
    mov rsi, frase
    mov dword [qmenor], 999
    mov byte [menor],0
    
.enquanto: 
    ;guarda o começo da palavra
    mov rbx, rsi
    xor ecx, ecx
    
.menor_conta:
    mov al, [rsi]
    
    ;verifica se é espaço
    cmp al, ' '
    je .compara
    
    ;verifica se é o fim da frase
    cmp al, 0
    je .compara
    
    ;incrementa o contador
    inc ecx
    inc rsi         ;vai pro próximo caractere
    jmp .menor_conta
    
.compara:
    ;compara o tamanho atual com o da palavra
    cmp ecx, [qmenor]
    jge .prox       ;se maior vai pro próximo
    
    mov [qmenor], ecx
    mov rdi, menor  ;aponta pra onde deve ser atualizado
    mov rsi, rbx    ;volta pro inicio da palavra atual
    
    mov edx, ecx    ;letras q serão copiadas
    
.copia:
    cmp edx, 0
    je .termina     ;se o contador chegou a 0 ent termina
    
    ;copia o dígito para menor
    mov al, [rsi]
    mov [rdi], al
    
    ;atualiza o dígito e o contador
    inc rsi
    inc rdi
    dec edx
    jmp .copia
 
.termina:
    ;finaliza com 0
    mov byte[rdi], 0
    mov rsi, rbx    ;volta pro início da palavra
    add rsi, rcx    ;avança até o final
   
.prox:
    cmp byte [rsi],0
    je .fim
    inc rsi
    jmp .enquanto
    
.fim:
    ret
      
section .note.GNU-stack