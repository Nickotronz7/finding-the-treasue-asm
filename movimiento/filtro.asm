%include "linux64.inc"

section .data
    Msn1 db "Introduzca las Columnas ",0
	filename db "Matix.txt",0
    Msn2 db "Introduzca las Filas ",0
    filename1 db "MatixS.txt",0
    filename2 db "MatixOS.txt",0
section .bss
    Filas resb 64
    Columnas resb 64
    V1 resb 64
    V2 resb 64
    V3 resb 64
    V12 resb 64
    V14 resb 64
    Fa resb 64
    Ca resb 64
    Vpm resb 64
    text1 resb 64

section .text
	global _start
_start:
    call _creatFile
    print Msn1
    call _getColumnas
    print Msn2
    call _getFilas
    mov rax,Columnas
    call atoi
    mov [Columnas],rax
    mov rax,Filas
    call atoi
    mov [Filas],rax
    call _convolutionAS
    call _convolutionAOS
    _exit:
	exit
_getColumnas: ;imput del usuario
    mov rax, 0
    mov rdi, 0
    mov rsi, Columnas
    mov rdx, 64
    syscall
    ret
_getFilas:;imput del usuario
    mov rax, 0
    mov rdi, 0
    mov rsi, Filas
    mov rdx, 64
    syscall
    ret
_convolutionAOS:
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,1
    mov [Fa],rax
    mov rax,1
    mov [Ca],rax
    _loopCono:
    mov rax, [Ca]
    mov r12, [Columnas]
    add r12,1
    cmp rax, r12
    je _loopConAo
    mov rax, [Fa]
    mov r12, [Filas]
    add r12,1
    cmp rax, r12
    je _loopConBo
    mov rax,0
    mov [V1],rax
    call _convolutionOS
    mov rax,[V1]
    cmp rax,0
    jl _bo
    cmp rax,255
    jg _b1o
    jmp _b2o
    _bo:
        mov rax,[Ca]
        add rax,1
        mov [Ca],rax
        mov rax,0
        call _IntToBin8o
        mov rax,","
        mov[V2],rax
        call _writeAuxo
        mov rax," "
        mov[V2],rax
        call _writeAuxo
        jmp _loopCono

        
    _b1o:
        mov rax,[Ca]
        add rax,1
        mov [Ca],rax
        mov rax,255
        call _IntToBin8o
        mov rax,","
        mov[V2],rax
        call _writeAuxo
        mov rax," "
        mov[V2],rax
        call _writeAuxo
        jmp _loopCono
    _b2o:
        mov rax,[Ca]
        add rax,1
        mov [Ca],rax
        mov rax,[V1]
        call _IntToBin8o
        mov rax,","
        mov[V2],rax
        call _writeAuxo
        mov rax," "
        mov[V2],rax
        call _writeAuxo
        jmp _loopCono
    _loopConAo:
        mov rax,1
        mov [Ca],rax
        mov rax, [Fa]
        add rax, 1
        mov [Fa], rax
        jmp _loopCono
    _loopConBo:
        mov rax,"1"
        mov[V2],rax
        call _writeAuxFo
        ret
_convolutionAS:;loop para realizar la convolucion
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,1
    mov [Fa],rax
    mov rax,1
    mov [Ca],rax
    _loopCon:
    mov rax, [Ca]
    mov r12, [Columnas]
    add r12,1
    cmp rax, r12
    je _loopConA
    mov rax, [Fa]
    mov r12, [Filas]
    add r12,1
    cmp rax, r12
    je _loopConB
    mov rax,0
    mov [V1],rax
    call _convolutionS
    mov rax,[V1]
    cmp rax,0
    jl _b
    cmp rax,255
    jg _b1
    jmp _b2
    _b:
        mov rax,[Ca]
        add rax,1
        mov [Ca],rax
        mov rax,0
        call _IntToBin8
        mov rax,","
        mov[V2],rax
        call _writeAux
        mov rax," "
        mov[V2],rax
        call _writeAux
        jmp _loopCon

        
    _b1:
        mov rax,[Ca]
        add rax,1
        mov [Ca],rax
        mov rax,255
        call _IntToBin8
        mov rax,","
        mov[V2],rax
        call _writeAux
        mov rax," "
        mov[V2],rax
        call _writeAux
        jmp _loopCon
    _b2:
        mov rax,[Ca]
        add rax,1
        mov [Ca],rax
        mov rax,[V1]
        call _IntToBin8
        mov rax,","
        mov[V2],rax
        call _writeAux
        mov rax," "
        mov[V2],rax
        call _writeAux
        jmp _loopCon
    _loopConA:
        mov rax,1
        mov [Ca],rax
        mov rax, [Fa]
        add rax, 1
        mov [Fa], rax

        jmp _loopCon
    _loopConB:
        mov rax,"1"
        mov[V2],rax
        call _writeAuxF
        ret
_convolutionS:
    mov rax,[Ca]
    sub rax, 1
    mov [Ca],rax
    mov rax,[Fa]
    sub rax, 1
    mov [Fa],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a1
    mov rax,[Fa]
    cmp rax,0
    je _a1
    jne _a11
    _a1:
        mov rax,0
        mov [Vpm],rax
        jmp _a111
    _a11:
        call _convolutionCmp
    _a111:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a2
    mov rax,[Fa]
    cmp rax,0
    je _a2
    jne _a21
    _a2:
        mov rax,0
        mov [Vpm],rax
        jmp _a211
    _a21:
        call _convolutionCmp
    _a211:
    call _convolutionMn1
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a3
    mov rax,[Fa]
    cmp rax,0
    je _a3
    jne _a31
    _a3:
        mov rax,0
        mov [Vpm],rax
        jmp _a311
    _a31:
        call _convolutionCmp
    _a311:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    sub rax, 2
    mov [Ca],rax
    mov rax,[Fa]
    add rax, 1
    mov [Fa],rax   

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a4
    mov rax,[Fa]
    cmp rax,0
    je _a4
    jne _a41
    _a4:
        mov rax,0
        mov [Vpm],rax
        jmp _a411
    _a41:
        call _convolutionCmp
    _a411:
    call _convolutionMn1
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a5
    mov rax,[Fa]
    cmp rax,0
    je _a5
    jne _a51
    _a5:
        mov rax,0
        mov [Vpm],rax
        jmp _a511
    _a51:
        call _convolutionCmp
    _a511:
    call _convolution5
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax
    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a6
    mov rax,[Fa]
    cmp rax,0
    je _a6
    jne _a61
    _a6:
        mov rax,0
        mov [Vpm],rax
        jmp _a611
    _a61:
        call _convolutionCmp
    _a611:
    call _convolutionMn1
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    sub rax, 2
    mov [Ca],rax
    mov rax,[Fa]
    add rax, 1
    mov [Fa],rax   

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a7
    mov rax,[Fa]
    cmp rax,0
    je _a7
    jne _a71
    _a7:
        mov rax,0
        mov [Vpm],rax
        jmp _a711
    _a71:
        call _convolutionCmp
    _a711:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a8
    mov rax,[Fa]
    cmp rax,0
    je _a8
    jne _a81
    _a8:
        mov rax,0
        mov [Vpm],rax
        jmp _a811
    _a81:
        call _convolutionCmp
    _a811:
    call _convolutionMn1
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    
    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _a9
    mov rax,[Fa]
    cmp rax,0
    je _a9
    jne _a91
    _a9:
        mov rax,0
        mov [Vpm],rax
        jmp _a911
    _a91:
        call _convolutionCmp
    _a911:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    sub rax, 1
    mov [Ca],rax
    mov rax,[Fa]
    sub rax, 1
    mov [Fa],rax
    ret

_convolution5:
    ;;;realiza y guarda convolucion 
    mov rax,[Vpm]
    mov r13,5
    mul r13
    mov r13,rax
    mov rax,[V1]
    add rax,r13
    mov [V1],rax
    ret
_convolution0:
    ;;;realiza y guarda convolucion 
    mov rax,[Vpm]
    mov r13,0
    mul r13
    mov r13,rax
    mov rax,[V1]
    add rax,r13
    mov [V1],rax
    ret
_convolution9:
    ;;;realiza y guarda convolucion 
    mov rax,[Vpm]
    mov r13,9
    mul r13
    mov r13,rax
    mov rax,[V1]
    add rax,r13
    mov [V1],rax
    ret
_convolutionMn2:
    ;;;realiza y guarda convolucion 
    mov rax,[Vpm]
    mov r13,-2
    mul r13
    mov r13,rax
    mov rax,[V1]
    add rax,r13
    mov [V1],rax
    mov rax,[V1]
    ret
_convolutionMn1:
    ;;;realiza y guarda convolucion 
    mov rax,[Vpm]
    mov r13,-1
    mul r13
    mov r13,rax
    mov rax,[V1]
    add rax,r13
    mov [V1],rax
    ret
    
_convolutionCmp:
    ;calcula la posicion en la que tiene que buscar en la matriz
    mov rax,0
    mov [Vpm],rax
    mov rax,[Fa]
    mov r15,rax
    sub r15,1
    mov rax,[Filas]
    mul r15
    mov r15,rax
    mov rax,[Ca]
    add rax,r15
    mov r13, rax
    mov rax, 0
    mov [V3],rax
    call _getNum
    mov rax,text1
    call atoi
    mov [Vpm],rax
    ret
         
_writeAux:;escribe de txt
    mov rax, SYS_OPEN
	mov rdi, filename1
	mov rsi, O_WRONLY
	mov rdx, 0644o
	syscall
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, 0 
	mov	rdx, 2
	syscall
    mov rax,SYS_WRITE
    mov rsi,V2
    mov rdx,1
    syscall
    mov rax,SYS_CLOSE
    pop rdi
    syscall
    ret
_writeAuxo:
    mov rax, SYS_OPEN
	mov rdi, filename2
	mov rsi, O_WRONLY
	mov rdx, 0644o
	syscall
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, 0 ; DESDE DONDE LOS TOMO 
	mov	rdx, 2
	syscall
    mov rax,SYS_WRITE
    mov rsi,V2
    mov rdx,1
    syscall
    mov rax,SYS_CLOSE
    pop rdi
    syscall
    ret
_writeAuxF:
    mov rax, SYS_OPEN
	mov rdi, filename1
	mov rsi, O_WRONLY
	mov rdx, 0644o
	syscall
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, 0 ; DESDE DONDE LOS TOMO 
	mov	rdx, 2
	syscall
    mov rax,SYS_WRITE
    mov rsi,V2
    mov rdx,1
    syscall
    mov rax,SYS_CLOSE
    pop rdi
    syscall
    ret
_writeAuxFo:
    mov rax, SYS_OPEN
	mov rdi, filename2
	mov rsi, O_WRONLY
	mov rdx, 0644o
	syscall
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, 0 ; DESDE DONDE LOS TOMO 
	mov	rdx, 2
	syscall
    mov rax,SYS_WRITE
    mov rsi,V2
    mov rdx,1
    syscall
    mov rax,SYS_CLOSE
    pop rdi
    syscall
    ret
_seekFileReadNB: ;lee en txt desde una pos dada y una cantidad de bits dada
    mov r12,[V12]
    mov r14,[V14]

    sub r12,r14
    sub r14,1
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall
   
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, r12 ; DESDE DONDE LOS TOMO 
	mov	rdx, 0
	syscall

    mov rax, SYS_READ
    mov rsi, text1
    mov rdx, r14
    syscall
    mov rax, SYS_CLOSE
    pop rdi
    syscall
    ret
_seekFileRead1B: ;escribe en txt desde una pos dada y 1 bits 
    mov r12, [V12]
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall
   
    push rax
	mov	rdi, rax
	mov	rax, SYS_LSEEK
	mov	rsi, r12 
	mov	rdx, 0
	syscall

    mov rax, SYS_READ
    mov rsi, text1
    mov rdx, 1
    syscall
    mov rax, SYS_CLOSE
    pop rdi
    syscall
    ret

_creatFile:; crea los txt para sharpened y oversharpened
    mov rax, SYS_CREAT
    mov rdi, filename1
    mov rsi, 0900
    syscall
    mov rax, SYS_CREAT
    mov rdi, filename2
    mov rsi, 0900
    syscall
    ret
_getNum:; comparador de string para obtener la cantidad de bits y poscion de donde leer
    mov rax,0
    mov [V12],rax
    mov rax,0
    mov [V14],rax
    _getNumAux1:
    mov rax,[V14]
    add rax,1
    mov [V14],rax
    _getNumAux:
    call _seekFileRead1B 
    mov rax,[V12]
    add rax,1
    mov [V12],rax
    mov rsi, [text1]
    cmp rsi, "["
    je _getNumAux
    cmp rsi, " "
    je _getNumAux
    cmp rsi,","
    je _getNumAux2
    jne _getNumAux5
    _getNumAux5:
        cmp rsi,"]"
        je _getNumAux2
        jne _getNumAux1
    _getNumAux2:
 
        mov rax,[V3]
        add rax , 1
        mov [V3], rax
        mov rax, [V3]

        cmp rax,r13
        jne _getNumAux4
        je _getNumAux3
        _getNumAux4:
            mov rax,0
            mov [V14], rax
            call _getNumAux1 
        _getNumAux3:
            call _seekFileReadNB
            ret
atoi:; convierte de str a int
    push    rbx             ; preserve ebx on the stack to be restored after function runs
    push    rcx             ; preserve ecx on the stack to be restored after function runs
    push    rdx             ; preserve edx on the stack to be restored after function runs
    push    rsi             ; preserve esi on the stack to be restored after function runs
    mov     rsi, rax        ; move pointer in eax into esi (our number to convert)
    mov     rax, 0          ; initialise eax with decimal value 0
    mov     rcx, 0          ; initialise ecx with decimal value 0
 
.multiplyLoop:
    xor     rbx, rbx        ; resets both lower and uppper bytes of ebx to be 0
    mov     bl, [rsi+rcx]   ; move a single byte into ebx register's lower half
    cmp     bl, 48          ; compare ebx register's lower half value against ascii value 48 (char value 0)
    jl      .finished       ; jump if less than to label finished
    cmp     bl, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
    jg      .finished       ; jump if greater than to label finished
 
    sub     bl, 48          ; convert ebx register's lower half to decimal representation of ascii value
    add     rax, rbx        ; add ebx to our interger value in eax
    mov     rbx, 10         ; move decimal value 10 into ebx
    mul     rbx             ; multiply eax by ebx to get place value
    inc     rcx             ; increment ecx (our counter register)
    jmp     .multiplyLoop   ; continue multiply loop
 
.finished:
    mov     rbx, 10         ; move decimal value 10 into ebx
    div     rbx             ; divide eax by value in ebx (in this case 10)
    pop     rsi             ; restore esi from the value we pushed onto the stack at the start
    pop     rdx             ; restore edx from the value we pushed onto the stack at the start
    pop     rcx             ; restore ecx from the value we pushed onto the stack at the start
    pop     rbx             ; restore ebx from the value we pushed onto the stack at the start
    ret

_IntToBin8:;convierte de int a str
    mov r13,0
    _IntToBin8a:
    mov rdx,0
    mov rbx,10
    div rbx
    push rdx
    inc r13
    cmp rax,0
    jne _IntToBin8a
_writeAux1:
    mov r14,0
    _writeAux2: 
    pop rax
    add rax,48
    mov [V2],rax
    call _writeAux
    inc r14
    cmp r14,r13
    jne _writeAux2
    ret
_IntToBin8o:
    mov r13,0
    _IntToBin8ao:
    mov rdx,0
    mov rbx,10
    div rbx
    push rdx
    inc r13
    cmp rax,0
    jne _IntToBin8ao
_writeAux1o:
    mov r14,0
    _writeAux2o: 
    pop rax
    add rax,48
    mov [V2],rax
    call _writeAuxo
    inc r14
    cmp r14,r13
    jne _writeAux2o
    ret
_convolutionOS:
    mov rax,[Ca]
    sub rax, 1
    mov [Ca],rax
    mov rax,[Fa]
    sub rax, 1
    mov [Fa],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c1
    mov rax,[Fa]
    cmp rax,0
    je _c1
    jne _c11
    _c1:
        mov rax,0
        mov [Vpm],rax
        jmp _c111
    _c11:
        call _convolutionCmp
    _c111:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c2
    mov rax,[Fa]
    cmp rax,0
    je _c2
    jne _c21
    _c2:
        mov rax,0
        mov [Vpm],rax
        jmp _c211
    _c21:
        call _convolutionCmp
    _c211:
    call _convolutionMn2
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c3
    mov rax,[Fa]
    cmp rax,0
    je _c3
    jne _c31
    _c3:
        mov rax,0
        mov [Vpm],rax
        jmp _c311
    _c31:
        call _convolutionCmp
    _c311:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    sub rax, 2
    mov [Ca],rax
    mov rax,[Fa]
    add rax, 1
    mov [Fa],rax   

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c4
    mov rax,[Fa]
    cmp rax,0
    je _c4
    jne _c41
    _c4:
        mov rax,0
        mov [Vpm],rax
        jmp _c411
    _c41:
        call _convolutionCmp
    _c411:
    call _convolutionMn2
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c5
    mov rax,[Fa]
    cmp rax,0
    je _c5
    jne _c51
    _c5:
        mov rax,0
        mov [Vpm],rax
        jmp _c511
    _c51:
        call _convolutionCmp
    _c511:
    call _convolution9
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax
    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c6
    mov rax,[Fa]
    cmp rax,0
    je _c6
    jne _c61
    _c6:
        mov rax,0
        mov [Vpm],rax
        jmp _c611
    _c61:
        call _convolutionCmp
    _c611:
    call _convolutionMn2
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    sub rax, 2
    mov [Ca],rax
    mov rax,[Fa]
    add rax, 1
    mov [Fa],rax   

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c7
    mov rax,[Fa]
    cmp rax,0
    je _c7
    jne _c71
    _c7:
        mov rax,0
        mov [Vpm],rax
        jmp _c711
    _c71:
        call _convolutionCmp
    _c711:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c8
    mov rax,[Fa]
    cmp rax,0
    je _c8
    jne _c81
    _c8:
        mov rax,0
        mov [Vpm],rax
        jmp _c811
    _c81:
        call _convolutionCmp
    _c811:
    call _convolutionMn2
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    add rax, 1
    mov [Ca],rax

    
    ;comparador de 0 en ca o fa y llamada a operacion
    mov rax,[Ca]
    cmp rax,0
    je _c9
    mov rax,[Fa]
    cmp rax,0
    je _c9
    jne _c91
    _c9:
        mov rax,0
        mov [Vpm],rax
        jmp _c911
    _c91:
        call _convolutionCmp
    _c911:
    call _convolution0
    ;-------------------------
    mov rax ,0
    mov [V2], rax
    mov [V3], rax
    mov [Vpm], rax
    mov [text1], rax
    mov rax,[Ca]
    sub rax, 1
    mov [Ca],rax
    mov rax,[Fa]
    sub rax, 1
    mov [Fa],rax
    ret