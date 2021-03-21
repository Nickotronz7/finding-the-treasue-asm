
%include "systemcalls.asm"

section .data
    laberinto db "lab.txt",0
 
 section .bss
    text resb 1274
 
section .text
    global _start
 
_start:
    mov rax, SYS_OPEN
    mov rdi, laberinto
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall
   
    push rax
    mov rdi, rax
    mov rax, SYS_LSEEK
    mov rsi, 0 ; DESDE DONDE LOS TOMO 
    mov rdx, 0
    syscall
 
    mov rax, SYS_READ
    mov rsi, text
    mov rdx, 1274
    syscall

    mov rax, SYS_CLOSE
    pop rdi
    syscall
 
    mov rax, text
    call print
    
    
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
   