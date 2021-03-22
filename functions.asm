_open:;abre el laberinto original
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

    call _closefile

    ret

;-------------------------------------------------------------------------------
_getAction:;imput del usuario
    mov qword [action], 0
    mov rax, 0
    mov rdi, 0
    mov rsi, action
    mov rdx, 64
    syscall
    
    ret

;-------------------------------------------------------------------------------


;-------------------------------------------------------------------------------