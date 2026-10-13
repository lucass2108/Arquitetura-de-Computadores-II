section .bss
    a 

section .text
    global _start

_start:
    ;se (a > 10)
    cmp[a],10
    jle fim_se      ;jump less equal
        mov ax,[a]
        sub ax,5
        mov [b],ax  
        add ax,[x]
        mov [c],ax
    fim_se: