;Problema:calculadora hexadecimal

org 100h
    mov dx,offset bienvenida  
    call mostrar
    
    mov cx,2 ;
inicio:
    call saltoL
    
    mov dx,offset aux1  
    call mostrar
    
    mov bx,0 ;aux guardar digito de un numero
    
registro:
    call captura
    cmp al,13    ;es enter?
    je operacion 
       
    cmp al,'0'
    jnae inicio  ;s� no es mayor igual 
                 ;no hacemos la pregunta contraria para continuar
    cmp al,'9'
    jbe esHexa   ;s� es menor igual
    
    cmp al,'A' 
    jnae inicio  ;s� no es mayor igual
    
    cmp al,'F'
    jbe  esHexaLetra ;s� es menor igual
    jmp inicio
    
esHexa:  
    sub al,30h
    cmp bl,0
    je  primeracifra
    add bl,al  
    jmp esDosdigitos
    
    
esHexaLetra:
    sub al,55
    cmp bl,0
    je  primeracifra
    add bl,al
    jmp esDosdigitos
    
primeracifra:
    mov bl,16
    mov ah,0
    mul bl
    mov bl,al 
    jmp registro   
    
operacion:
    cmp bl,0  ;el numero tiene digitos?
    je inicio 
    
    cmp al,13 ;hay un digito,luego presiono(enter)
    jne esDosdigitos
    mov al,bl  ;
    mov bl,16
    mov ah,0
    div bl
    mov bl,al
esDosdigitos:
    
    call saltoL
    push bx
    
    cmp cx,2   
    jb calcular 
    
    mov dx,offset aux2
    call mostrar
    
    call captura;capturar operacion(+-*/)
    mov ah,0
    push ax
    
    loop inicio    

calcular:
    pop bx
    mov cl,bl
    pop bx
    mov al,bl
    pop bx
    mov ah,0 
    ;analisis de operaciones
    cmp al,'+'
    je suma
    cmp al,'-'
    je resta
    cmp al,'*'
    je multiplicacion
    cmp al,'/'
    je division
    jmp invalido
    
suma:    
    add bx,cx
    mov ax,bx
    jmp visualizar
    
resta:
    sub bl,cl
    mov al,bl
    jmp visualizar
     

multiplicacion:
    mov ah,0
    xchg ax,bx  
    mul cx
    jmp visualizar

division:
    xchg ax,bx
    mov ah,0
    div cl
    mov ah,0

visualizar: 
    mov dx,offset aux4
    call mostrar
    
visualizarHexa:
    mov bx,16
    mov cx,0
seguirdividiendo:
    mov dx,0
    div bx
    push dx
    inc cx
    cmp ax,0
    je desapilar
    jmp seguirdividiendo
    
desapilar:
    pop ax
    cmp al,9
    ja incrementoLetras 
    add al,30h
    call ver
    loop desapilar
    jmp fin
incrementoLetras:
    add al,55
    call ver 
    loop desapilar     
    
    jmp fin
     
invalido:
    mov dx, offset aux3
    call mostrar
    
    ;jmp fin    
    
fin: int 20h 

;**Procedimientos**

mostrar proc ;argumento debe estar en dx
    push ax
    mov ah,09h
    int 21h
    mov dx,0;limpiarselo
    pop ax
    ret
mostrar endp  

ver proc 
    mov ah,2
    mov dl,al
    int 21h
    ret
ver endp  

captura proc
    mov ah,1
    int 21h
    ret
captura endp

saltoL proc
    push ax
    push dx
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    pop dx
    pop ax 
    ret
saltoL endp


;**Variables** 
bienvenida db 10,13,'***************************************************',
           db 10,13,'*             Calculadora Hexadecimal             *',
           db 10,13,'***************************************************',
           db 10,13,'*Nota:                                            *',
           db 10,13,'*  Max Digitos por Numero: 2                      *',
           db 10,13,'*  Numeros HEX: [0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F, *',
           db 10,13,'*  Operaciones permitidas: [+,-,*,/]              *',
           db 10,13,'*Ejemplo1: F+E=1D                                 *',
           db 10,13,'*Ejemplo2: A8+5B=E5                               *',
           db 10,13,'*Ejemplo3: FD-BD=40                               *',
           db 10,13,'***************************************************$'
aux1 db 'Ingrese un numero hexadecimal valido: $'
aux2 db 'Ingrese una de las 4 operaciones disponibles (+,-,*,/): $'
aux3 db 'Operacion invalida.$'
aux4 db 'El resultado es: $'   

;3 digitos
;oct,binal,decimal
;controlar ingreso de numeros
;