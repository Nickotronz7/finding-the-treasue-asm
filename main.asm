%include "linux64.inc"

section .data
    l1 db "level1.txt", 0
    l2 db "level2.txt", 0
    game db "lab.txt", 0
    space db " ", 10, 0
    alien db "@", 10, 0
    nl db "", 10, 0
 
 section .bss
    lab resb 1368
 
section .text
    global _start
 
_start:
    load_Lab l1
    
    writefilemac lab, 0, game, 1368

    exit