%include "io64.inc"         
default rel      

section .data
    i dd 1
    msg dd 'Erro',0
    
section .bss
    fat resd 1            

section .text
    global main
    
main:
    GET_DEC 4, fat
    
    mov ebx,[fat]
    
    .enquanto:
    cmp ebx, 20
    jg .maior20
    cmp ebx, 0
    j
    
    
    .maior20:
        PRINT_STRING msg
    jmp .fim
    
    .fim
    
    xor rax, rax
    ret
section .note.GNU-stack
     
  
    
