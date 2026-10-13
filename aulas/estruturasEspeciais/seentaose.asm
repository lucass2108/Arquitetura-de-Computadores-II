section .text
    global _start

_start:
    ;se (a > 10), senão
    cmp [a],10
    jle else
        mov ax,[a]
        sub ax, 5
        mov [b],ax
        add ax,[x]
        mov [c],ax
        jmp fim_se
    else:
        mov ax,[a]
        add ax,3
        mov[b],ax
        mov ax,[y]
        sub ax, [b]
        mov [c],ax
    fim_se: