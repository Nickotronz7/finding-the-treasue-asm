%include "linux64.inc"

section .data
    laberinto db "Laberinto.txt",0
    a db "a.txt",0
    alien db "@",0
    espacio db " ",0
    Msn1 db "Introduzca las Columnas ",0

 section .bss
    text resb 1370
    action resb 64

section .text
    global _start
 
_start:
    call _open
    mov r15, 99;pos original de @
    call _getAction
    mov rax, [action] ;2657:a 2675:s 2679:w 2660:d 2592:' ' 2668:l 2674:r 
    cmp rax, 2657
    je _a1
    jne _a2
    exit
   ; call _movAlienA
   ; call _movAlienB

_a1:
    print Msn1
    exit

_a2:
    print alien
    exit
    
_getAction:;imput del usuario
    mov qword [action], 0
    mov rax, 0
    mov rdi, 0
    mov rsi, action
    mov rdx, 64
    syscall
    ret

_open:;abre el laberinto original
    mov rax, SYS_OPEN
    mov rdi, laberinto
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall
   
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, 0 ; DESDE DONDE LOS TOMO 
	mov	rdx, 0
	syscall

    mov rax, SYS_READ
    mov rsi, text
    mov rdx, 1370;cuantos tomo
    syscall
    mov rax, SYS_CLOSE
    pop rdi
    syscall
    ret

_movAlienA:;escribe de txt
    mov rax, SYS_OPEN
	mov rdi, laberinto
	mov rsi, O_WRONLY
	mov rdx, 0644o
	syscall
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, 197 ; DESDE DONDE LOS TOMO 
	mov	rdx, 0
	syscall
    mov rax,SYS_WRITE
    mov rsi,alien
    mov rdx,1
    syscall
    mov rax,SYS_CLOSE
    pop rdi
    syscall
    ret
_movAlienB:;escribe de txt
    mov rax, SYS_OPEN
	mov rdi, laberinto
	mov rsi, O_WRONLY
	mov rdx, 0644o
	syscall
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, 99 ; DESDE DONDE LOS TOMO 
	mov	rdx, 0
	syscall
    mov rax,SYS_WRITE
    mov rsi,espacio
    mov rdx,1
    syscall
    mov rax,SYS_CLOSE
    pop rdi
    syscall
    ret