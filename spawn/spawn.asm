%include "linux64.inc"

section .data
    MnsError db "Selecione una opcion valida",10,0
    filename db "lab.txt", 0
    MnsDif db "Elija la dificultad del juego",10,0
    MnsDif1 db "'d' para dificil 'f' para facil :",10,0
 section .bss
    lab resb 1273
    action resb 64 
 
section .text
    global _start
 
_start:
    print MnsDif
    print MnsDif1
    getAction
    mov rax,[action]
    cmp rax,2660;2660:d  2662:f
    je _dificil
    cmp rax,2662
    je _facil
    jne _Merror
_Merror:
    print MnsError
    call _start
    exit
_facil:
    print MnsDif1
    exit
    ;macrifacil
_dificil:
    print MnsDif
    exit
    ;macro en dificil







