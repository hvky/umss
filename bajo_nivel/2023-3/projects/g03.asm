

mostrarEtiqueta macro a
    ;push ax
    ;push dx
    mov dx, offset a        ; 16 bits devuelve offest, siempre al registro de datos
    mov ah,9h ;Configura la función AH para la interrupción DOS (int 21h)   
    int 21h ; Llama a la interrupción DOS para imprimir la cadena en pantalla.
    ;pop dx
    ;pop ax
endm 

mostrarResultado macro a
local dividirhasta0 mostrar
    ;push ax
    ;push bx
    ;push cx
    ;push dx
    
    mov cx,0
    mov dx,0
    mov ax,bx
    mov bx,a
    
dividirhasta0:
    ;div bx
    ;inc cl
    ;push dx
    ;cmp ax,0
    ;je mostrar
    ;mov dx,0    
    ;jmp dividirhasta0
mostrar:
    mov ah,2
    pop dx
    add dl,30h
    int 21h
    loop mostrar
    
    pop dx
    pop cx    
    pop bx
    pop ax
        
endm

org 100h 

  mov cx,0
    mostrarEtiqueta ingresoNumero1
primero:
    mov ah,7
    int 21h
    cmp al,2Fh
    jng primero
    cmp al,39h
    jg primero
    mov bl,al
    sub bl,30h
    mov ah,2
    mov dl,al
    int 21h
    
    call salto
    mostrarEtiqueta ingresoNumero2
    segundo:    
    mov ah,7
    int 21h
    cmp al,2Fh
    jng segundo
    cmp al,39h
    jg segundo
    mov cl,al
    sub cl,30h
    mov ah,2
    mov dl,al
    int 21h
    
    call salto    
    mostrarEtiqueta operacion 
    
    inicioOperacion:    
    mov ah,7
    int 21h
    cmp al,'+'
    je suma
    cmp al,'-'
    je resta
    cmp al,'*'
    je multiplicacion
    cmp al,'/'
    je division
    jmp inicioOperacion

suma:
    mov ah,2
    mov dl,al
    int 21h
    add bl,cl
    mov bh,0
    jmp inicioSistema
   
resta:
    mov ah,2
    mov dl,al
    int 21h
    
    cmp cl,bl
    jng restar
    xchg cl,bl
    mov dx,'-'
    mov si,dx
restar:
    mov di,bx    
    sub bx,cx
    mov dx,di
    sub cx,dx
    mov di,cx    
    jmp inicioSistema
    
multiplicacion:    
    mov ah,2
    mov dl,al
    int 21h
    
    mov ax,0
    mov al,bl
    mul cl
    mov bl,al
    mov bh,0
   jmp inicioSistema
    
division:    
    mov ah,2
    mov dl,al
    int 21h;interrupcion paar mostrar el contenido
    
    mov ax,0
    mov al,bl
    div cl
    mov bl,al
    mov bh,0
    jmp inicioSistema 
   
   
inicioSistema:            
    
call salto    
   ; mostrarEtiqueta sistemaNumerico 
   decimal:

    mov ah,2
    mov dl,al
    int 21h
    
    call salto    
    mostrarEtiqueta resultado
    
    cmp si,'-'
    jne normalDec
    mov ah,2
    mov dl,'-'
    int 21h 
    
    normalDec:    
    
    mostrarResultado 10
    
    jmp fin
    
 fin:int 20h 
 


proc salto
    ;push ax
    ;push dx
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    ;pop dx
    ;pop ax
    ret
salto endp
 
    
 ingresoNumero1 db 'ingresar primer numero: $' 
 ingresoNumero2 db 'ingresar segundo numero: $'
 operacion db 'ingreso de operacion(+,-,*,/): $'
 resultado db 'resultado: $'



