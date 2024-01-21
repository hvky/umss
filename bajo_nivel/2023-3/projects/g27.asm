
;Realizar un programa que reciba 5 nombres y 5 edades y
;Se pueda ordenar de cualquiera de las 2 formas


;######################
;#####   MACROS   #####
;######################  

; ---Control de lectura de edades de la cadena---

unDigitoAX macro
  local remplazo,termino
  cmp AH,'-'
  JE remplazo
  JMP termino
  remplazo:
    MOV AH, AL
    MOV AL,'0'
  termino:   
endm 

unDigitoDX macro
  local remplazo,termino
  cmp DH,'-'
  JE remplazo
  JMP termino
  remplazo:
    MOV DH, DL
    MOV DL,'0'
  termino:   
endm

; ---Macros utilitarios---

mostrar macro arg
  lea dx, arg
  call show
endm

imprimir macro arg
    push dx
    push ax
    mov dx, arg
    mov ah, 9
    int 21h
    push dx
    pop dx
endm 
imprimirVar macro arg
    push dx
    push ax
    mov dx, offset arg
    mov ah, 9
    int 21h
    pop ax
    pop dx
endm

imprimirNum macro arg
  push dx
  push ax
  
  xor dx,dx
  mov ah,2
  mov dl,arg
  add dl,30h
  int 21h
  
  pop ax
  pop dx
endm

imprimirChar macro arg
  push dx
  push ax
  
  xor dx,dx
  mov ah,2
  mov dl,arg
  int 21h
  
  pop ax
  pop dx
endm  

; --- macros de ordenacion por nombre ---  

encontrarSeparador macro arg
    local loopSep,salir
    push ax
    
loopSep:
    mov ax, [arg]
    cmp al, '-' 
    je salir
    inc arg
    jmp loopSep
salir:
    pop ax
    inc arg 
endm 

; --- macro de lectura de edades de la cadena ---
   
encontrarNumero macro arg
    local salir
    push ax     

    mov ax, [arg]

    jmp salir
salir:
    pop ax
endm


;--------------------------------------
;             INTERCAMBIAR            |
;--------------------------------------

intercambiar macro arg1, arg2
    pusha

    loopIntercambiar:    
        cmp cl, 0
        je finIntercambiar              
        jmp verificarFinIntercambio
      
      continuarLoop: 
        
        mov dl, [arg1]
        mov bl, [arg2]
        
        mov [arg1], bl
        mov [arg2], dl
        inc arg1
        inc arg2
        dec cl
    jmp loopIntercambiar
    
    verificarFinIntercambio:
        cmp dl,'$'
        jne continuarLoop
        cmp bl,'$'
        je finIntercambiar
    
    
finIntercambiar:
    popa
endm 


; --- macro de listado de nombres ---

imprimirNombresOrdenados macro
  local ciclo,retornar
  
  push cx
  
  xor cx,cx
  mov cx,5
  lea si,nombres
  
  mov bh,1
  
  imprimirVar salto
  
  imprimirChar tab
  imprimirChar '#'  
  imprimirChar tab
  imprimirVar edadh
  imprimirChar tab
  imprimirVar nombreh   
  
  imprimirVar salto
    
  ciclo:      
    imprimirChar tab
    imprimirNum bh
    imprimirChar tab
    imprimir si
    imprimirVar salto
    
    inc bh
    add si,separador
  loop ciclo
  
  retornar:
  pop cx
endm

replaceChar macro argdb,argc1,argc2
  local ciclo,retornar,nocambiar
   
  push cx
  xor cx,cx
  mov cx,200 
  lea si,argdb
  
  ciclo:
    cmp [si],argc1
    jne nocambiar
    mov [si],argc2
    nocambiar:
    inc si
  loop ciclo:
  retornar:
  pop cx
endm

;###################################
;##########  PROGRAMA  #############
;###################################

org 100h
inicio:
   
  mostrar saludo
  mov si, offset nombres
  mov di, si
  mov ch,6
     
  mostrar salto
  
;Loop para ingresar nombres y edades
  
  
  mostrarEdad:  
   dec ch
   cmp ch,0
   je seleccionarOP 
   mostrar edad
  
  llenarArreglo: 
  call leerEdad
  cmp al, 13 
  je separar
  mov [si], al
  inc si
  jmp llenarArreglo 
  
  separar:
  mostrar nombre
  mov [si], '-'  
  inc si
  jmp anadirNombre 
  
  anadirNombre:
  call leerNombre
  cmp al,13
  je separarNombre
  mov [si], al
  inc si
 
  jmp anadirNombre
   
  separarNombre:
  mostrar salto
  add di, 12
  mov si, di
  jmp mostrarEdad
  

; +++ SELECCION DE ORDENAMIENTO +++   
    
proc seleccionarOP
   mostrar op1
   mostrar opcion
   mov ah,7
   int 21h
   cmp al, '1'
   je iniciarOrdenacionEdad
   cmp al, '2'
   je iniciarOrdenacionNombre
   jmp seleccionarOP
ret
    
       
iniciarOrdenacionNombre:
    mov ah,2
    mov dl, al
    int 21h
    mostrar salto
    mostrar salto
    mostrar sel2
    mostrar salto
    call ordenarNombres
    
    replaceChar nombres,'-',9
    imprimirNombresOrdenados
    JMP fin
    
iniciarOrdenacionEdad: ; ORDENAMIENTO POR EDADES
    mov ah,2
    mov dl, al
    int 21h
    mostrar salto
    mostrar salto
    mostrar sel1
    mostrar salto
    call ordenarEdades
    
    replaceChar nombres,'-',9
    imprimirNombresOrdenados
    JMP fin


fin: int 20h



;######################
;### PROCEDIMIENTOS ###
;###################### 

proc show
   mov ah,9
   int 21h
ret 

; *** CONTROL DE ENTRADAS ***
                                   
proc leerNombre
 bucle2:
 mov ah,7
 int 21h 
 cmp al, 13
 je salir2
 cmp al, 'z'
 ja bucle2
 cmp al, 'a'
 jb bucle2
 mov ah,2
 mov dl,al
 int 21h
 salir2:
 ret
ret

proc leerEdad
 bucle:
 mov ah,7
 int 21h 
 cmp al, 13
 je salir
 cmp al, '9'
 ja bucle
 cmp al, '0'
 jb bucle
 mov ah,2
 mov dl,al
 int 21h
 salir:
 ret


; *** CAMBIO DE ELEMENTOS *** (REFACTORIZACION) 
proc cambio
    intercambiar si, di
ret

;-----------------------------------------
; ----------- ORDENAR POR NOMBRES
;----------------------------------------- 

;++++PROCESO DE COMPARACION++++


compararNombres:
    push si 
    push di
    encontrarSeparador si
    encontrarSeparador di
    mov bx, 0
        
    loopComparar:
        mov al, [si]
        mov dl, [di]
        cmp al, dl
        jne definirMayor
        
        cmp al, dl
        je finCompararNombres
        
        inc si
        inc di
        
    jmp loopComparar
        
    definirMayor:
        cmp al, dl 
        ja primeroMayor
        jmp finCompararNombres
    
    primeroMayor:
        mov bx, 1
        jmp finCompararNombres
    
finCompararNombres:
    pop di
    pop si
   
ret 


;++++CICLO DE ORDENAMIENTO++++
ordenarNombres:
    mov ch, 4    
    mov cl, offset separador   
    mov si, offset nombres
    mov di, si
    
loopElementosPorOrdenar:
    cmp ch, 0
    je finOrdenar
    
    push cx
    
    loopElementosPorComparar:
        cmp ch, 0 
        je ordenarSigElemento
        
        add di, offset separador
        
        call compararNombres
        
        cmp bl, 1
        je intercambiarElem
         
        dec ch
    jmp loopElementosPorComparar
        
                             
    intercambiarElem:
        push si
        push di
        call cambio
        pop di
        pop si
        
        dec ch
    jmp loopElementosPorComparar
ordenarSigElemento:
    pop cx
    dec ch
    add si, offset separador
    mov di, si
jmp loopElementosPorOrdenar

finOrdenar:
ret



;-----------------------------------------
; ----------- COMPARAR EDADES -----------|
;-----------------------------------------

;++++PROCESO DE COMPARACION++++     
compararEdades:
    push si 
    push di               ;avanza los elementos
    encontrarNumero si    ;consigue las edades de la cadena
    encontrarNumero di
    mov bx, 0
    
loopCompararE:
    
    mov ax, [si]
    unDigitoAX            ;Control de numeros
    mov dx, [di]
    unDigitoDX
    cmp ax, dx            ;Comparacion de edades
    
    jne definirEdadMayor     ;diferentes
    cmp al, dl
    je finCompararEdades     ;iguales
    inc si
    inc di
    jmp loopCompararE
    
    
definirEdadMayor:
    cmp al, dl
    je definirEdadMayor2 
    ja primeroEdadMayor
    jmp finCompararEdades

definirEdadMayor2:            ;compara el digito menor
    cmp ah, dh
    ja primeroEdadMayor
    jmp finCompararEdades


primeroEdadMayor:
    mov bx, 1                 ;Marca que la primera edad es mayor
    jmp finCompararEdades
    
finCompararEdades:
    mov ax, 0
    mov dx, 0                 
    pop di
    pop si
   
ret       

     
; ++++++CICLO DE ORDENAMIENTO++++++
                
ordenarEdades:
    mov ch, 4    ;Numero de elementos a ordenar -1
    mov cl, 12   ;Separacion de cadena entre un elemento y otro
    mov si, offset nombres    ;cadena
    mov di, si
    
loopOrdenarEdades2:
    cmp ch, 0
    je finOrdenarEdades
        
    push cx
    
loopOrdenarEdades:
    cmp ch,0 ; queda 1 elemento ya esta ordenado
    je siguienteIteracionE
    
    add di, offset separador  ;toma el siguiente elemento de la cadena
    
    call compararEdades
    cmp bl, 1                    ;revisa que sea mayor
    je intercambiarEdades
     
    dec ch                       ;pasa al siguiente elemento
    jmp loopOrdenarEdades
    
intercambiarEdades:  ;Intercambia elementos
    push si
    push di
    call cambio
    pop di
    pop si
    
    dec ch
    jmp loopOrdenarEdades
siguienteIteracionE:       ;repite el ciclo
    pop cx
    dec ch
    add si, offset separador
    mov di, si
    jmp loopOrdenarEdades2
finOrdenarEdades:
ret
     

    
;-----------------------------------------
; ----------- FIN ORDENAR POR EDADES
;-----------------------------------------  


;######################
;####  VARIABLES  #####
;###################### 


saludo db 10,13,'---- Bienvenido ---- $'
nombre db 10,13,'Ingrese un Nombre:$'
salto db 10,13,'$'
edad db 10,13,'Ingrese una Edad:$'
opcion db 10,13,'Seleccione una opcion:$'
op1 db 10,13, '[1] para ordenar por edad, [2] para ordenar por nombre$' 
sel1 db 10,13,'-------- SELECCION POR EDAD --------$'
sel2 db 10,13,'--------- SELECCION POR NOMBRE ---------$'
edadh db 'EDAD$'
nombreh db 'NOMBRE$'

prueba1 db 10,13,'(Ordenar por edad los registros)$'
prueba2 db 10,13,'(Ordenar por nombre los registros)$' 

nombres db 200 dup('$')

separador equ 12
tab equ 9
space equ 32
