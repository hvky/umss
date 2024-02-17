; Realizar un programa que solo permita el ingreso de numeros (N) de hasta dos digitos cada uno.
; Mostrar todos los primos, el promedio de todos.

macro    saltoLinea      
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl,13
    int 21h

endm    saltoLinea

org 100h
inicio:
   mov dx, offset etiq
   mov ah, 9
   int 21h
   ;mov dx, offset memDatos
   mov cx, 0 
ciclo:
   call ingNumValidos
   
   terminoRecibir:
   saltoLinea
   ;operamos 
   mov dx, offset et2
   mov ah, 9
   int 21h
   
   mov bl, 0
   push cx; para despuesXD ya que almacena el numero de datos
   mov si, offset memDatos
cicloP:
   mov al, (si)
   call esPrimo
   cmp bl, 1
   je ePrimo
   ; no es primo
   jmp cont
   ePrimo:
   call impAl
   mov ah, 2
   mov dl, ','
   int 21h
   mov dl, ' '
   int 21h
   cont:
   inc si
   mov bl, 0
   loop cicloP:
   ; ----ya mostramos los primos------------- 
   saltoLinea
   mov dx, offset etiq3
   mov ah, 9
   int 21h
   pop cx 
   mov bl, cl; copia del dato
   mov si, offset memDatos
   mov ax, 0
   cicloS:
   add al, (si)
   inc si
   loop cicloS
   div bl
   ;---imp result con decimales mas....
   cmp ah, 0
   jne mostDecimal
   ; no existe decimal
   call impAl
   jmp fin
   mostDecimal:
   push ax
   call impAl
   mov ah, 2
   mov dl, '.'
   int 21h
   pop ax
   xchg ah, al
   call impAl
fin: 
   int 20h

ret

etiq db "Ingrese los numeros: $"
etiq3 db "El Promedio total es: $"
et2 db " Los numeros primos son: $"
memDatos db 100 dup(0)

ingNumValidos proc 
    mov si, offset memDatos
    mov bl, 0
    mov ax, 0
    reingresar:
    mov ah, 7
    int 21h
    cmp al, 0
    je reingresar
    cmp al, 20h
    je  terminar
    cmp al, 13
    je enter
    cmp al, '1'
    jb reingresar
    cmp al, '9'
    ja reingresar
    cmp bl, 0
    ja DigDos
    ; un solo digito
    mov dh, al
    sub dh, 30h
    inc bl
    jmp reingresar
    DigDos:
    sub al, 30h
    xchg al, dh
    mov ah, 0
    mov dl, 10
    mul dl
    add dh, al
    enter: 
    mov bl, 0
    xchg al, dh; dato en al
    mov (si), al
    call impAl
    inc si
    inc cx
    mov ah, 2
    mov dl, ','
    int 21h
    mov dl, ' '
    int 21h
    mov al, 0
    jmp reingresar
    terminar:
    ret
ingNumValidos endp

impAl proc
    cmp al,10
    jb unDig
    ;dos digitos
    mov dl, 10
    mov ah, 0
    div dl
    mov dh, ah
    mov dl, al
    add dl, 30h
    mov ah, 2
    int 21h
    mov al, dh
    
    unDig:
    add al, 30h
    mov dl, al
    mov ah, 2
    int 21h
    ret
impAl endp

esPrimo proc
    push cx
    mov cx, 0
    mov al, (si)
    cmp al, 2
    jb noesPrimo
    mov ah, 0
    mov dl, 2
    div dl
    mov cl, al
    
    mov al, (si)
    mov bh, al;copia
    operamos:
    mov ah, 0
    div cl
    cmp ah, 0
    jne segBusDiv
    cmp cl, 2
    jb esprimox
    jmp noesPrimo
    segBusDiv:
    dec cl
    mov al, bh
    jmp operamos
    esprimox:
    mov bl, 1
    jmp finPrimo
    noesPrimo:
    mov bl, 255
    
    finPrimo:
    mov al, (si)
    pop cx
    ret
esPrimo endp