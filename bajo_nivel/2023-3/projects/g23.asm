;*********************************
;Realizar un programa que permita el ingreso de N caracteres, deberan ser guardadas en 4 cadenas 
;finales donde se guarden numeros, mayusculas, minusculas y caracteres especiales. 
;Se debe mostrar las 4 cadenas resultantes en columnas de la misma forma que se almaceno.

;*********  MACROS *****************
enter macro
    push ax
    push dx 
    mov dx,offset nextl
    mov ah,9
    int 21h
    pop dx
    pop ax
endm 

;******* PROGRAMA PRINCIPAL ************
org 100h
inicio:
    mov ah,1
    mov cx,300
    mov si,offset datos_capturados
captura:    
    int 21h 
    cmp al,13
    je fin_captura 
    mov [si],al 
    inc si 
    loop captura
fin_captura:;datos capturados 
    call guarda_numeros
    enter
    mov dx,offset numeros
    mov ah,9
    int 21h 
    call guarda_mayusculas
    enter 
    mov dx,offset mayusculas
    mov ah,9
    int 21h
    call guarda_minusculas
    enter
    mov dx,offset minusculas 
    mov ah,9
    int 21h
    
    call guarda_caracteres
    enter 
    call imprime_caracteres
    enter
    call imprime_fila_mensaje 
    call imprime_datos
     
fin: int 20h
;********************** PROCEDIMIENTOS *****************
imprime_datos proc
    mov si,offset direcciones
    mov di,offset numeros 
    mov ax,di
    mov [si],ax
    add si,2h
    mov di,offset mayusculas
    mov ax,di
    mov [si],ax
    add si,2h
    mov di,offset minusculas
    mov ax,di
    mov [si],ax
    add si,2h
    mov di,offset caracteres
    mov ax,di
    mov [si],ax
    mov si,offset direcciones
    mov cl,0 
ciclo_datos:
    enter 
    mov ah,9                               
    mov dx,offset espacio4
    int 21h
parte_de_los_numeros:
    mov bx,[si]
    mov al,[bx]
    cmp al,'$' 
    je espacio_en_num
    mov dl,al
    mov ah,2
    int 21h
    inc bx
    mov [si],bx
    jmp aumenta_si 
espacio_en_num:
    inc cl
    mov dl,' '
    mov ah,2
    int 21h
aumenta_si:
    add si,2h
parte_de_las_mayusculas:
    mov dx,offset espacio9
    mov ah,9
    int 21h
    mov bx,[si];mayusculas
    mov al,[bx]
    cmp al,'$'
    je espacio_en_mayus
    mov dl,al
    mov ah,2
    int 21h
    inc bx
    mov [si],bx
    jmp aumenta_si_a_minus
espacio_en_mayus:
    mov dl,' '
    mov ah,2
    int 21h
    inc cl
aumenta_si_a_minus:
    add si,2h
parte_de_las_minusculas:
    mov dx,offset espacio11
    mov ah,9
    int 21h
    
    mov bx,[si]
    mov al,[bx]
    cmp al,'$'
    je espacio_en_minus
    mov dl,al
    mov ah,2 
    int 21h
    inc bx
    mov [si],bx
    jmp aumenta_si_a_caracteres
espacio_en_minus:
    mov ah,2
    mov dl,' '
    int 21h
    inc cl
aumenta_si_a_caracteres:
    add si,2h
partes_de_caracteres:
    mov dx,offset espacio11
    mov ah,9
    int 21h
    
    mov bx,[si]
    mov al,[bx]
    cmp al,0
    je verifica_fin_impresion
    mov dl,al
    mov ah,2
    int 21h 
    inc bx
    mov [si],bx
    jmp actualiza_datos_vuelve_bucle
verifica_fin_impresion:
    cmp cl,3
    je fin_ciclo_datos
    mov ah,2
    mov dl,' '
    int 21h 
actualiza_datos_vuelve_bucle:
    mov si,offset direcciones
    mov cx,0
    jmp ciclo_datos 

fin_ciclo_datos: 
    ret
imprime_datos endp 




imprime_fila_mensaje proc
    mov ah,2 
    mov dl,' '
    int 21h
    mov dx,offset message_numeros
    mov ah,9
    int 21h
    mov dx,offset doble_espacio 
    int 21h
    mov dx,offset message_mayusculas 
    int 21h
    mov dx,offset doble_espacio 
    int 21h
    mov dx,offset message_minusculas
    int 21h
    mov dx,offset doble_espacio 
    int 21h
    mov dx,offset message_caracteres
    int 21h 
    ret
imprime_fila_mensaje endp 




imprime_caracteres proc
    mov si,offset caracteres 
    mov ah,2
ciclo_im:
    cmp [si],0
    je fin_ciclo_im
    mov dl,[si]

    int 21h
    inc si
    jmp ciclo_im 
fin_ciclo_im: 
    ret
imprime_caracteres endp


guarda_caracteres proc
    mov si,offset datos_capturados 
    mov bx,si
    mov si,offset caracteres 
    mov cx,300
    mov dl,100
ciclo_car:
    cmp [bx],0
    je fin_ciclo_car
    cmp dl,0
    je fin_ciclo_car
    cmp [bx],'0'
    jb captura_car
    cmp [bx],'9'
    ja verificar_mayus 
    jmp siguiente_dato_car
verificar_mayus:
    cmp [bx],'A'
    jb captura_car
    cmp [bx],'Z'
    ja verificar_minus
    jmp siguiente_dato_car
verificar_minus:
    cmp [bx],'a'
    jb captura_car
    cmp [bx],'z'
    ja captura_car 
    jmp siguiente_dato_car
captura_car:
    mov al,[bx]
    mov [si],al
    inc si 
    dec dl 
    jmp siguiente_dato_car 
fin_ciclo_car:
    mov cx,1
siguiente_dato_car:
    inc bx
    loop ciclo_car       
    ret
guarda_caracteres endp 



 
guarda_minusculas proc 
    mov si,offset datos_capturados
    mov bx,si
    mov si,offset minusculas
    mov cx,300
    mov dl,100
ciclo_minus:
    cmp [bx],0
    je fin_ciclo_minus
    cmp dl,0
    je fin_ciclo_minus 
    cmp [bx],'a'
    jb siguiente_dato_minus
    cmp [bx],'z'
    ja siguiente_dato_minus
    mov al,[bx]
    mov [si],al
    inc si 
    dec dl
    jmp siguiente_dato_minus
fin_ciclo_minus:
    mov cx,1
siguiente_dato_minus:
    inc bx
    loop ciclo_minus 
    
    ret
guarda_minusculas endp 



guarda_mayusculas proc
    
    mov si, offset datos_capturados 
    mov bx,si
    mov si,offset mayusculas
    mov cx,300
    mov dl,100
ciclo_mayus:
    cmp [bx],0
    je fin_ciclo_mayus
    cmp dl,0
    je fin_ciclo_mayus
    cmp [bx],'A'
    jb siguiente_dato_mayus
    cmp [bx],'Z'
    ja siguiente_dato_mayus
    mov al,[bx]
    mov [si],al
    dec dl
    inc si 
    jmp siguiente_dato_mayus 
fin_ciclo_mayus:
    mov cx,1
siguiente_dato_mayus: 
    inc bx
    loop ciclo_mayus   
    ret 
guarda_mayusculas endp 



guarda_numeros proc 
    mov si,offset datos_capturados 
    mov bx,si
    mov si,offset numeros 
    mov cx,300
    mov dl,100
ciclo:
    cmp [bx],0
    je fin_ciclo
    cmp dl,0
    je fin_ciclo 
    cmp [bx], '0'
    jb siguiente_dato
    cmp [bx], '9'
    ja siguiente_dato 
    mov al,[bx]
    mov [si],al
    inc si
    dec dl
    jmp siguiente_dato
fin_ciclo:
    mov cx,1
siguiente_dato:
    inc bx
    loop ciclo
    ret
guarda_numeros endp 
;************ variables *************
numeros db 100 dup ('$')           
mayusculas db 101 dup ('$')
minusculas db 101 dup ('$')
caracteres db 101 dup (0)
datos_capturados db 300 dup (0)
nextl db 10,13,'$'

message_numeros db 'NUMEROS$'
message_mayusculas db 'MAYUSCULAS$'
message_minusculas db 'MINUSCULAS$'
message_caracteres db 'CARACTERES$'
doble_espacio db '  $'
espacio4 db ' ',' ',' ',' ','$'
espacio9 db ' ',' ',' ',' ',' ',' ',' ',' ',' ','$' 
espacio11 db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','$'
direcciones dw 0,0,0,0 