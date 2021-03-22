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
    MnsReinicio db "Desea Reiniciar el juego?",10,0
    MnsYN db "Para confirmar s para declinar n"
    MnsFin db "Desea Finalizar el juego?",10,0
    MnsFin1 db "Gracias por jugar!",10,0

 section .bss
    lab resb 1368
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
_facil:
    load_Lab l1
    call _Init
    ;macrifacil
_dificil:
    load_Lab l2
    call _Init
    ;macro en dificil
_reset:
    print MnsReinicio
    print MnsYN
    getAction
    mov rax,[action]
    cmp rax,2675
    je _start
    cmp rax,2670
    je _Play
    print MnsError
    jne _reset
_Init: 
    writefilemac lab, 0, game, 1368
_Play:
    getAction;comparacion para realizar mov o r o f o l
    mov rax,[action]
    cmp rax,2674
    je _reset
    exit