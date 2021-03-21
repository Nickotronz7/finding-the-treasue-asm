
%include "linux64.inc"

section .data
    filename db "lab.txt", 0
    space db " ", 10, 0
    alien db "@", 10, 0
    nl db "", 10, 0
 
 section .bss
    lab resb 1273
 
section .text
    global _start
 
_start:

    mov r8, 99
    writefilemac space, r8
    mov r8, 197
    writefilemac alien, r8

    exit

_closefile:
    mov rax, SYS_CLOSE
    mov rdi, filename
    syscall
    ret

_readLab:    
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall
   
    push rax
    mov rdi, rax
    mov rax, SYS_LSEEK
    mov rsi, 0 ; Se lee desde el inicio
    mov rdx, 0
    syscall
 
    mov rax, SYS_READ
    mov rsi, lab
    mov rdx, 1273
    syscall

    mov rax, SYS_CLOSE
    pop rdi
    syscall

    ret
    
   