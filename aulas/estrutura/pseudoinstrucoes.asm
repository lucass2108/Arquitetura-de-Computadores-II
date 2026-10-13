section .data 
;DB - define byte
    db 0x55             ;byte 0x55
    db 'a'              ;caractere 'a'
    db 0                ;inteiro 0
    db 255              ;maior inteiro
    db 'hello',13,10    ;string "hello" seguida de CR/LF

;DW - define word (16bits)
    dw 0x1234           ;bytes 0x34 e 0x12(little-endian)
    dw 'a'
    dw 'ab'
    dw 65535            ;maior valor numa word

;DD - define double word (32bits)
    dd 0x123456789      ;bytes 0x78 0x56 0x34 0x12
    dd 1.2345           ;ponto flutunate de precisão simples

section .bss
    ;buffer é um nome qualquer e os ":" indicam q é um label
    buffer: reab 64     ;reserva 64 * 1  byte
    wordvar: resw 1;    ;reserva 1 * word
    doublewordvar: resd 10  ;reserva 10 * double word
    ecran equ 1         ;deine uma costante "ecran" = 1

section .text   
    global _start

_start:
    ;os colchetes indicam ser o conteúdo
    mov ax, [ind1]      ;carrega em AX o conteúdo de ind1
    mov dx, ind2        ;carrega em dx o enderço de ind2
    mov [ind2],[ind1]

    ;ERRO: memória -> memória
    mov [ind2],[ind1]

    ;CORRETO: usar um registrador auxiliar
    mov ax, [ind1]      ;ax = conteúdo de ind1
    mov[ind2],ax        ;ind2 = ax

    ;enderço efetivo
    mov al, [msg]       ;1º de msg
    mov ah, [msg +1]    ;2º de msg
    mov bl, [msg+2]     ;3º de msg

    ;usando SI como registrador índice, pode armazenar um enderço
    ;incrmenta-lo permite percorrer bytes consecutivos
    mov si, msg         ;si: endereço de msg (n+6)
    mov al, [si]        ;al: conteúdo apontadob por si
    inc si              ;si = si+1 (n+6+1)
    mov al, [si]
    inc si              ;si = si + 1 (n+6+1+1)
    mov al, [si]        

    ;NASM não memoriza tipos de variáveis
    mov byte [buffer], 10   ;indica pra reservar 1 byte em buffer para 10
    