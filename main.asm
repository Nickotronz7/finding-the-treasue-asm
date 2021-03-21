%include "linux64.inc"

section .data
    l1 db "level1.txt", 0
    l2 db "level2.txt", 0
    game db "lab.txt", 0
    space db " ", 10, 0
    alien db "@", 10, 0
    nl db "", 10, 0
    MnsDif db "Elija la dificultad del juego",10,0
    MnsDif1 db "'d' para dificil 'f' para facil :",10,0
    MnsError db "Selecione una opcion valida",10,0

 section .bss
    lab resb 1368
 
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
_facil:
    load_Lab l1
    ;macrifacil
_dificil:
    load_Lab l2
    ;macro en dificil
_Init: 
    writefilemac lab, 0, game, 1368
    exit