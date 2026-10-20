%include "io64.inc"         
default rel                  

section .bss
    n resd 1    ;n
    
section .text
    global main                  

main:
    GET_DEC 4, n        
    
    mov ecx, [n]             ;guarda quantos faltam para imprimir
    mov ebx, 1               ; 1

    enquanto:
    cmp ecx, 0               ;vê se tem números para imprimir          
    jle fim_enquanto         
    
        mov eax, ebx             ;copia o ultimo impar
        PRINT_DEC 4, eax         ; imprime

        dec ecx                  ; decrementa do contador
    
        PRINT_STRING msg         ;imprime o espaço
        add ebx, 2               ;adicona 2 para ir pro próximo número
        jmp enquanto             ;volta pro começo
        
    fim_enquanto:
    xor rax, rax            
    ret                    


section .note.GNU-stack

