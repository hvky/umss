;Programa para ingresar datos de un estudiante por teclado
  
mostrar macro c1
    mov dx,offset c1
    mov ah,9
    int 21h
    mov dx,0
endm  

org 100h
inicio:
    mostrar msg0
    call salto

    nombre1:
    mostrar msg1
    mov di, offset nombree1
    call ingresarL
    call salto  

    nombre2:
    mostrar msg11
    mov di, offset nombree2
    call ingresarL
    call salto

    apellido1:
    mostrar msg2
    mov di, offset apellidoo1
    call ingresarL
    call salto 

    apellido2:
    mostrar msg22
    mov di, offset apellidoo2
    call ingresarL
    call salto   

    codsis:
    mostrar msg3
    mov di,offset codsiss
    call ingresarN
    call salto

    ci:
    mostrar msg4
    mov di,offset cii
    call ingresarN
    call salto

    carrera: 
    mostrar msg5
    mov di, offset carreraa
    add di,11
    call ingresarL
    call salto  

    imprimir:
    call salto 
    mostrar msg6  
    call salto
    mostrar msg7
    mostrar nombree1
    call salto
    mostrar msg8
    mostrar nombree2
    call salto
    mostrar msg9
    mostrar apellidoo1
    call salto
    mostrar msg10
    mostrar apellidoo2
    call salto
    mostrar msg111
    mostrar codsiss
    call salto
    mostrar msg12
    mostrar cii
    call salto
    mostrar msg13
    mostrar carreraa 
    call salto

fin:
    int 20h

ret  

msg0 db 'Ingrese datos de estudiante$'
msg1 db 'Ingrese el primer nombre:$'
msg11 db 'Ingrese el segundo nombre:$'
msg2 db 'Ingrese el primer apellido:$'
msg22 db 'Ingrese el segundo apellido:$'
msg3 db 'Ingrese codigo sis:$'
msg4 db 'Ingrese numero de ci:$'
msg5 db 'Ingrese carrera:$'
msg6 db  'Datos ingresados:$'
msg7 db  'Primer nombre: $'
msg8 db  'Segundo nombre: $'
msg9 db  'Primer apellido: $'
msg10 db 'Segundo apellido: $'
msg111 db 'Codigo SIS: $'
msg12 db 'Numero de CI: $'
msg13 db 'Carrera: $'

;cadenas de control
nombree1 db '$$$$$$$$$$'
nombree2 db '$$$$$$$$$$'
apellidoo1 db '$$$$$$$$$$'
apellidoo2 db '$$$$$$$$$$'
codsiss db '$$$$$$$$$$'
cii db '$$$$$$$$$$'
carreraa db 'Ingenieria $$$$$$$$$$$$' 

;procesos auxiliares

;control de ingreso de letras
ingresarL proc
    mov ah,1
    mov cx,20
    ingreso:
    int 21h
    cmp al,13
    je finp:
    cmp al,'A'
    jb ingreso
    cmp al,'Z'
    ja ingreso2
    continua:
    mov [di],al
    inc di
    loop ingreso
    ingreso2:
    cmp al,'a'
    jb ingreso
    cmp al,'z'
    ja ingreso
    jmp continua
    finp:
    ret
ingresarL endp 

;control de ingreso de numeros
ingresarN proc
    mov ah,1
    mov cx,10
    ingresoo:
    int 21h
    cmp al,13
    je finpp
    cmp al,'0'
    jb ingresoo
    cmp al,'9'
    ja ingresoo
    mov [di],al
    inc di
    loop ingresoo
    finpp:
    ret
ingresarN endp

;da espacios entre lineas para la consola       
salto proc
    mov dl,10
    mov ah,2 
    int 21h
    mov dl,13
    int 21h
    ret
salto endp


ret




