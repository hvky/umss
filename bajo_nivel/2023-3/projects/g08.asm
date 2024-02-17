;Calculadora

INCLUDE EMU8086.INC
org 100h  

;1

inicio:
    mov si, offset aux1
    mov ah, 9
    mov dx, offset aux1
    int 21h

ciclo:
    mov ah,7
    int 21h
    cmp al, 30h
    jb ciclo
    cmp al, 39h
    ja ciclo

    mov bh, al          ; guardar numero1
    mov ah, 2
    mov dl, al
    int 21h  
    printn

    mov si, offset aux2
    mov ah, 9           ;imprimir cadena de texto
    mov dx, offset aux2
    int 21h                      
                
;2

ciclo2:
    mov ah, 7
    int 21h
    cmp al, '+'
    je operar
    cmp al, '-'
    je operar
    cmp al, '*'
    je operar
    cmp al, '/'
    je operar
    jmp ciclo2

operar:
    mov ah, 2
    mov dl, al
    int 21h
    mov bl, al          ; guardar operador   
    printn

    mov si, offset aux3
    mov ah, 9
    mov dx, offset aux3
    int 21h          
    
;3 

ciclo3:
    mov ah, 7
    int 21h
    cmp al, 30h
    jb ciclo
    cmp al, 39h
    ja ciclo3

    mov dl, al
    mov ah, 2
    int 21h
    mov ch, al          ; guardar numero2

    sub bh, 30h
    sub ch, 30h       
    printn

    mov si, offset aux4
    mov ah, 9
    mov dx, offset aux4
    int 21h

    cmp bl, '+'
    je sumar
    cmp bl, '-'
    je restar
    cmp bl, '*'
    je multiplicar
    cmp bl, '/'
    je dividir 
    
;4 

sumar:
    add bh, ch
    cmp bh, 9
    ja suma1
    add bh, 30h
    mov dl, bh
    mov ah, 2
    int 21h
    jmp Fin

suma1:
    mov bl, 10
    mov dl, 13
    mov al, bh
    mov ah, 0
    div bl
    mov dl, al
    add dl, 30h
    mov bh, ah
    mov ah, 2
    int 21h
    mov dl, bh
    add dl, 30h
    int 21h
    jmp Fin

restar:
    cmp bh, ch
    ja verificado
    jb cambiar

verificado:
    sub bh, ch
    mov ah, 2
    mov dl, bh
    add dl, 30h
    int 21h
    jmp Fin

cambiar:
    mov ah, 2
    mov dl, '-'
    int 21h
    xchg bh, ch
    jmp verificado  
    
;5

multiplicar:
    mov al, ch
    mul bh
    cmp al, 9
    ja mult1
    mov dl, al
    add dl, 30h
    int 21h
    jmp Fin

mult1:
    mov bl, 10
    div bl
    mov bh, ah
    mov ah, 2
    mov dl, al
    add dl, 30h
    int 21h
    mov dl, bh
    add dl, 30h
    int 21h
    jmp Fin

dividir:
    mov al, bh
    mov ah, 0
    div ch
    mov dl, al
    add dl, 30h
    mov ah, 2
    int 21h
    jmp Fin

Fin:
    int 20h


aux1 db '1.Numero 1: $'
aux2 db '2.Operacion: $'
aux3 db '3.Numero 2: $'
aux4 db 'Resultado: $'