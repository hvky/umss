; realizar un programa que solicite una fecha, la componga en un solo registro
; y posterior mente se muestre al registro en binario

org 100h

inicio:    
    mov ah,9 ; recorre autmatico de la ram hasta encontrar signo de dolar
    
    mov dx, OFFSET ejemplo
    int 21h; interupcion sistema/muestra en pantalla
    call saltolinea
    
    mov ah,9
    mov dx, OFFSET yearM
    int 21h
    mov ah,2
    mov dl,'2'
    int 21h
    mov dl,'0'
    int 21h
    mov dl,'2'
    int 21h
    mov dl,'3'
    int 21h
    call saltolinea
    
    mov ah,9
    mov dx, OFFSET mothM
    int 21h
    mov ah,2
    mov dl,'0'
    int 21h
    mov dl,'1'
    int 21h
    call saltolinea
    
    mov ah,9
    mov dx, OFFSET dayM
    int 21h
    mov ah,2
    mov dl,'1'
    int 21h
    mov dl,'4'
    int 21h
    call saltolinea
    
    mov ah,9
    mov dx, OFFSET ingresar
    int 21h
    call saltolinea
    
    mov ah,9
    mov dx, OFFSET yearM;/////
    int 21h
    mov cx,4
    call anios       ;  ////
    mov ax,0                  ;
    mov ax,bx
    mov cx,bx
    push bx
    mov bx,4
    mov dx,0
    div bx
    cmp dl,0                   
    je candidato:              ;verifica si el anio es biciesto
    jmp verificarMes:
candidato:
    mov ax,0
    mov bx,100
    mov ax,cx
    mov dx,0
    div bx
    cmp dl,0
    jne esViciesto:
    mov ax,0
    mov bx,400
    mov ax,cx
    mov dx,0
    div bx
    cmp dl,0
    je esViciesto:
    jmp verificarMes:
    
esViciesto:
    mov si , OFFSET esViciestoMem
    mov [si],1
    jmp verificarMes:

noValido1:
    call saltolinea
    mov ax,0
    mov ah,9
    mov dx, OFFSET noValidomes
    int 21h
verificarMes:
    call saltolinea
    mov bl,0
    mov ah,9    
    mov dx, OFFSET mothM
    int 21h
    mov cx,2
    call DiaMes
    cmp bl,12
    ja noValido1:
    mov bh,bl
    jmp verificarDia:
    
noValido2:
    call saltolinea
    mov ax,0
    mov ah,9    
    mov dx, OFFSET noValidodia
    int 21h
verificarDia:
    call saltolinea
    mov bl,0    
    mov ah,9
    mov dx, OFFSET dayM
    int 21h
    mov cx,2
    call DiaMes
    cmp bh,1
    je verificar31:
    cmp bh,3
    je verificar31:
    cmp bh,5
    je verificar31:
    cmp bh,7
    je verificar31:
    cmp bh,8
    je verificar31:
    cmp bh,10
    je verificar31:
    cmp bh,12
    je verificar31:
    cmp bh,4
    je verificar30:
    cmp bh,6
    je verificar30:
    cmp bh,9
    je verificar30:
    cmp bh,11
    je verificar30:
    mov cl,[si]
    cmp cl,1 ;  1 es viciestp /0 no es viciesto
    je verificar29:
verificar28:
    cmp bl,28
    ja noValido2:
    jmp quitar:
verificar29: 
    cmp bl,29
    ja noValido2
    jmp quitar:
verificar30:
    cmp bl,30
    ja noValido2
    jmp quitar:
verificar31:
    cmp bl,31
    ja noValido2    
    call saltolinea

quitar:    
    pop ax
    mov dx,0
    mov dl,bh
    push bx
    push dx
                    ; en 16 puedne entrar dia mes y anio
    mov dx,0
    mov cx,1000
    div cx
    mov ax,dx
    mov dx,0
    mov cx,100
    div cx
    
    pop ax
    pop bx
    shl dx,9 ; izquierda anio
    shl ax,5 ; izaquierd mes
    or dx,ax  ;juntar
    or dx,bx  ;juntar
    
    ;jmp fin:
    mov ax,dx
    mov bx,2     ; mueve 2
    mov cx,16    ; dividir 16 veces
    mov dx,0
convertirEnBinario:
    div bx
    push dx       ; empuja a la pila el reciduo de la dividsion de 2 entre ax
    mov dx,0
    loop convertirEnBinario:

imprimir:
    mov cx,16
    call Saltolinea
    mov ah,2          ; muevea a ah ,2 
cicloImprecion:    
    pop dx
    add dl,30h           ;imprime en pantalla
    int 21h
    loop cicloImprecion:

   
fin: 
    int 20h
    
yearM db "Introdusca el a�o: $"
mothM db "Introdusca el mes: $"
dayM  db "Introdusca el dia: $"
noValidomes db "--Intodusca un mes valido--$"
noValidodia db "--Introdusca un dia valido--$"
ejemplo db "----Ejemplo de como ingresar Fecha----$"
ingresar db "----------Ingrese la fecha-----------$"
esViciestoMem db 0

proc saltolinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    ret
saltolinea endp

proc DiaMes 
    ciclo:
        mov ah,7
    verificar:
        int 21h
        cmp al,'0'
        jb ciclo:
        cmp al,'9'
        ja ciclo:
        mov dl,al
        mov ah,2
        int 21h
        sub al,30h
        cmp cx,2
        jb seguirCiclo:
        mov dl,10
        mul dl
    seguirCiclo:
        add bl,al     
        loop ciclo:
    ret
DiaMes endp

proc anios 
    ciclo1:
        mov ah,7; mostrar en pantalla
    verificar1:
        int 21h
        cmp al,'0'
        jb ciclo:
        cmp al,'9'
        ja ciclo:
        mov dl,al
        mov ah,2
        int 21h
        sub al,30h
        mov ah,0
        cmp cx,4
        je mult:
        cmp cx,3
        je mult2:
        cmp cx,2
        jb seguirCiclo1:
        mov dl,10
        mul dl
        jmp seguirCiclo1:
    mult:
        mov dx,1000
        mul dx
        jmp seguirCiclo1:
    mult2:
        mov dx,100
        mul dx
    seguirCiclo1:
        add bx,ax     
        loop ciclo1:
    ret   ; guarda en bx
anios endp




