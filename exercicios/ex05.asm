section .data
    a dd 7
    x dd 3
    y dd 20

section .text  
    global _start

_start:
    mov eax,[a]
    cmp eax,10
    jle else
        ;b = a - 5
        mov ebx, eax
        sub ebx, 5
        ;c = x + b
        mov ecx, [x]
        add ecx, ebx
        jmp fim_se
    else:
        ;b = a + 3
        mov ebx, eax
        add ebx,3
        ;c = y - b
        mov ecx, [y]
        sub ecx,ebx
    fim_se:

    mov ebx, ecx
    mov eax, 1
    int 0x80