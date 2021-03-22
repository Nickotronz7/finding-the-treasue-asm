%include "linux64.inc"

section .data
    l1 db "level1.txt", 0
    l2 db "level2.txt", 0
    game db "lab.txt", 0
    space db " ", 10, 0
    alien db "@", 10, 0
    floor db "¯", 10, 0
    wall db "*", 10, 0
    nl db "", 10, 0
    MnsPlay db "Elija la accion a realizar",10,0
    MnsDif db "Elija la dificultad del juego",10,0
    MnsDif1 db "'d' para dificil 'f' para facil :",10,0
    MnsError db "Selecione una opcion valida",10,0
    MnsReinicio db "Desea Reiniciar el juego?",10,0
    MnsYN db "Para confirmar s para declinar n",10,0
    MnsFin db "Desea Finalizar el juego?",10,0
    MnsFin1 db "Gracias por jugar!",10,0
    MnsDer db "Perdistes maldito insecto!",10,0
    MnsAgain db "Desea volver a jugar!",10,0
    MnsWin db "Ganaste maldito insecto!",10,0

 section .bss
    lab resb 1368
    char resb 1
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

_end:
    print MnsFin
    print MnsYN
    getAction
    mov rax,[action]
    cmp rax,2675
    je _end1
    cmp rax,2670
    je _Play
    print MnsError
    cmp rax,2670
    jne _end

_end1:
    print MnsFin1
    exit

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
    cmp rax,2670
    jne _reset
_exit:
    exit
_Init:
    mov r15, 99
    writefilemac lab, 0, game, 1368
    call _Play
_lose:
    print MnsDer
    print MnsAgain
    print MnsYN
    getAction
    mov rax, [action]
    cmp rax, 2675
    je _start
    cmp rax, 2670
    je _exit
    print MnsError
    cmp rax, 2670
    jne _lose
_Win:
    print MnsWin
    print MnsAgain
    print MnsYN
    getAction
    mov rax, [action]
    cmp rax, 2675
    je _start
    cmp rax, 2670
    je _exit
    print MnsError
    cmp rax, 2670
    jne _Win

_moveDown:
    mov r8, r15
    add r8, 98

    readChar r8
    mov r8, [char]
    cmp r8, 42
    je _Play
    cmp r8, 175
    je _Play

    mov r8, r15
    add r8, 98
    writefilemac alien, r8, game, 1
    writefilemac space, r15, game, 1
    add r15, 98
    load_Lab game

    call _Play

_moveUp:
    mov r8, r15
    sub r8, 98

    readChar r8
    mov r8, [char]
    cmp r8, 42
    je _Play
    cmp r8, 95
    je _Play

    mov r8, r15
    sub r8, 98
    writefilemac alien, r8, game, 1
    writefilemac space, r15, game, 1
    sub r15, 98
    load_Lab game

    call _Play

_moveL:
    mov r8, r15
    sub r8, 2

    readChar r8
    mov r8, [char]
    cmp r8, 42
    je _Play
    cmp r8, 97
    je _Play

    mov r8, r15
    sub r8, 2
    writefilemac alien, r8, game, 1
    writefilemac space, r15, game, 1
    sub r15, 2
    load_Lab game

    call _Play

_moveR:
    mov r8, r15
    add r8, 2

    readChar r8
    mov r8, [char]
    cmp r8, 42
    je _Play
    cmp r8, 97
    je _Play

    mov r8, r15
    add r8, 2
    writefilemac alien, r8, game, 1
    writefilemac space, r15, game, 1
    add r15, 2
    load_Lab game

    call _Play

_Play:
    print lab
    print nl
    print MnsPlay
    getAction;comparacion para realizar mov o r o f o l
    mov rax,[action]

    cmp rax,2674 ;r
    je _reset

    cmp rax,2662 ;f
    je _end

    cmp rax, 2675 ;s
    je _moveDown

    cmp rax, 2679
    je _moveUp

    cmp rax, 2657
    je _moveL

    cmp rax, 2660
    je _moveR

    call _Play

    exit