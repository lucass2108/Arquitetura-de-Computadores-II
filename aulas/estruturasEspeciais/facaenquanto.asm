section .text
    global _start

_start:
;do while(a > 10)
    mov [a],10
    faca:
        dec [a];
        cmp [a],0
        jg faca     ;jump greater than