section .data
    msg db 'UNIFEI', 0

section .text
    global _start

_start:
    mov esi, msg
    xor ebx, ebx

    enquanto:
    cmp byte [esi], 0
    je fim_enquanto

        cmp byte [esi], 'I'
        jne fim_se
            inc ebx

        fim_se:
        inc esi
        jmp enquanto

    fim_enquanto:

    mov eax, 1
    int 0x80


