section .text
    global _start

_start:
    ;do while (i<=10)
    mov [i],1
    para:
        mov ax,[a]
        sub ax,5
        mov [b],ax
        add ax,[x]
        mov [c], ax
        inc [i]
        cmp[i],10
        jle para    ;jump less equal
    fim_para: