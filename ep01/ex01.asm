%include "io64.inc" ; certifique que em CONFIGURÇÕES → COMPILADOR: X64 e NASM esteja marcado
default rel ; Declaração exigida pelo NASM, recomendada e moderna para 64 bits
section .data ; Declaração de variáveis inicializadas
msg1 db 'Resultado da operacao: ', 0
msg2 db 'Quociente: ', 0
msg3 db 'Resto: ', 0
msg4 db 'Produto: ', 0
section .bss ; Declaração de variáveis não inicializadas
x resd 1 ; Variáveis double word (32 bits)
y resd 1
w resd 1
section .text
global main
main:
    mov rbp, rsp; for correct debugging
; Leitura dos valores que deverão estar na janela "Entrada"
GET_DEC 4, x
GET_DEC 4, y
GET_DEC 4, w
; Cálculos
mov eax, [ x ]
xor edx, edx
mov ecx, [ y ]
sub ecx, [ w ]
se:
jle .else
mul DWORD [ y ]
PRINT_STRING msg1
NEWLINE
PRINT_STRING msg4
PRINT_DEC 4, edx
PRINT_CHAR ':'
PRINT_DEC 4, eax
jmp .fimse
.else:
div DWORD [ w ]
PRINT_STRING msg1
NEWLINE
PRINT_STRING msg2
PRINT_DEC 4, eax
NEWLINE
PRINT_STRING msg3
PRINT_DEC 4, edx
.fimse:
NEWLINE
xor rax, rax
ret
section .note.GNU-stack
