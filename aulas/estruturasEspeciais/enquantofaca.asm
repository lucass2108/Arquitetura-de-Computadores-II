;while

section .text
    global _start

_start:
    mov [a],10
    enquanto:
    ;while(a > 10)
    cmp [a],20
    jle fim_enquanto
        dec [a]
        jmp enquanto
    fim_enquanto: