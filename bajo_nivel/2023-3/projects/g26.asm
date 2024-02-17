;---------------------------------------------------------------------------
;                         CONVERSOR BINARIO
;---------------------------------------------------------------------------
;Este programa en ensamblador solicita al usuario dos numeros decimales(0-9)
;Este luego solicita la operacion que se desea realizar
;Y finalmente muestra el resultado en binario. 
;---------------------------------------------------------------------------


; ----------------------------------
;|           MACROS                 |
; ----------------------------------

saltito macro
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
endm

; Macro de impresion de 8 bits
printBits macro var
    push ax
    push bx
    push cx
    push dx

    mov ah, 2
    mov cx, 8
    mov al, var

    ciclo1:
    mov dl, 18h
    rol al, 1
    rcl dl, 1
    push ax
    int 21h
    pop ax
    loop ciclo1

    pop dx
    pop cx
    pop bx
    pop ax
endm


; ----------------------------------
;|       PROGRAMA PRINCIPAL         |
; ----------------------------------

org 100h
inicio: 

    ; Mensaje de bienvenida
    mov ah, 9
    mov dx, offset bienvenida1
    int 21h

    ; Ingresar el primer numero
    mov ah, 9
    mov dx, offset ingresoPrimer
    int 21h

    mov ah, 1
    int 21h
    sub al, 30h
    mov bh, al ; primer numero en bh

    saltito

    ; Ingresar el segundo numero
    mov ah, 9
    mov dx, offset ingresoSegundo
    int 21h

    mov ah, 1
    int 21h
    sub al, 30h
    mov bl, al ; segundo numero en bl

    saltito

repit:
    saltito

    ; Ingresar la operacion
    mov ah, 9
    mov dx, offset ingresoOper
    int 21h

    mov ah, 1
    int 21h

    cmp al, '+'
    je suma
    cmp al, '-'
    je resta
    cmp al, '*'
    je multi
    cmp al, '/'
    je division
    mov ah, 9
    mov dx, offset ingreseOpeCore
    int 21h
    jmp repit

division:
    mov ax, 0
    mov al, bh
    div bl
    mov bh, al
    jmp operacion
multi:
    mov ax, 0
    mov al, bh
    mul bl
    mov bh, al
    jmp operacion
resta:
    sub bh, bl
    jmp operacion
suma:
    add bh, bl

operacion:
    saltito
    mov ah, 9
    mov dx, offset mostrarRes
    int 21h

    mov cl, 'b'
    jmp sistema

sistema:
    saltito
    cmp cl, 'b'
    printBits bh

fin: int 20h

; ----------------------------------
;|              DATOS               |
; ----------------------------------

bienvenida1 db '-----------------------------------------', 13, 10
            db '       Bienvenido al conversor de Binario', 13, 10
            db '-----------------------------------------', 13, 10, '$' 
  
            
ingresoPrimer db 'Ingrese el primer numero decimal: $'
ingresoSegundo db 'Ingrese el segundo numero decimal: $'
ingreseOpeCore db 'Por favor, ingrese un operador valido.$'            
            
                         
ingresoOper db '-----------------------------------------', 13, 10
             db 'Operaciones:', 13, 10
             db '-----------------------------------------', 13, 10
             db 'Para la suma ingrese: "+"', 13, 10
             db 'Para la resta ingrese: "-"', 13, 10
             db 'Para la multiplicacion ingrese: "*"', 13, 10
             db 'Para la division ingrese: "/"', 13, 10
             db 'Ingrese la operacion que desea realizar: $'



mostrarRes  db '-----------------------------------------', 13, 10 
            db 'El resultado es : $'   