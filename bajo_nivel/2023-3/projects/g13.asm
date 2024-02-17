
;Realizar un programa que introducir los datos de una persona para su registro en Facebook, 
;Nombre, Apellidos, Ci, Celular y Ciudad. Verificar el correo ingresado sea válido, 
;la contraseña no debe ser visible y en su lugar mostrar “*”, 
;la contraseña debe contener al menos una letra en Mayúscula y al menos un Numero.
;Debe verificarse que el celular sea de Bolivia.


printstr macro str
    push ax
    push dx
    
    mov ah,9
    lea dx,str
    int 21h
    
    pop dx
    pop ax
    
    endm


org 100h

inicio: 
    printstr registrofb
    printstr menuNombre
    mov si,offset nombre
    mov bx,15
    call getTexto
    
    printstr menuApellido
    mov si,offset apellidoP
    mov bx,15
    call getTexto 
    
    printstr menuApellido2
    mov si,offset apellidoM
    mov bx,15
    call getTexto
    
    printstr menuCi
    mov si,offset ci
    mov cx,0
    
getCi:
    mov ah,7
    int 21h
    cmp al,'0'
    jb getCi
    cmp al,'9'
    ja getCi
    mov ah,2
    mov dl,al
    int 21h
    inc cx
    cmp cx,7
    jb getCi

getCelular:
    mov cx,0
    printstr menuCelular
    mov si,offset celular

cicloCelular:
    mov ah,7
    int 21h
    cmp al,8
    je delete
    cmp al,'0'
    jb cicloCelular
    cmp al,'9'
    ja cicloCelular
    mov dl,al
    mov ah,2
    int 21h
    mov [si],dl
    inc si
    inc cx
    cmp cx,10
    jbe cicloCelular
    jmp checkPhone

delete:
    call borrar
    jmp cicloCelular

checkPhone:
    mov si,offset celular
    cmp [si],'5'
    jne reiniciarCelular
    inc si
    cmp [si],'9'
    jne reiniciarCelular
    inc si
    cmp [si],'1'
    jne reiniciarCelular
    jmp getCiudad
    
reiniciarCelular:
    printstr errorCelular
    jmp getCelular

getCiudad:
    mov cx,0
    printstr menuCiudad
    mov si,offset ciudad

cicloCiudad:
    mov ah,7
    int 21h
    cmp al,13
    je checkCiudad
    cmp al,8
    je borrarCiudad
    mov dl,al
    mov ah,2
    int 21h
    inc cx
    mov [si],dl
    inc si
    jmp cicloCiudad
    
borrarCiudad:
    call borrar
    jmp cicloCiudad
    
checkCiudad:
    mov di,offset ciudades
    mov si,offset ciudad
    
cicloCheckCiudad:
    call compararCiudad
    
ciudadInvalida:
    printstr errorCiudad
    jmp getCiudad

getCorreo:
    printstr menuCorreo
    mov si,offset correo
    mov cx,0

cicloCorreo:
    mov ah,7
    int 21h
    cmp al,13
    je checkCorreo
    cmp al,8
    je borrarCorreo
    mov dl,al
    mov ah,2
    int 21h
    mov [si],dl
    inc si
    inc cx
    cmp cx,20
    je checkCorreo
    jmp cicloCorreo

borrarCorreo:
    call borrar
    jmp cicloCorreo 
    
checkCorreo:
    mov di, offset correoValidator
    mov si,offset correo
    cmp [si],'a'
    jb correoInvalido
    cmp [si],'z'
    jb cicloCheckCorreo
    cmp [si],'A'
    jb correoInvalido
    cmp [si],'Z'
    jb cicloCheckCorreo
    jmp correoInvalido

cicloCheckCorreo:
    cmp [si],'@'
    je checkTerminacion
    cmp [si],'$'
    je correoInvalido
    inc si
    jmp cicloCheckCorreo 
    
checkTerminacion:
    mov dl,[di]
    cmp [si],dl
    jne correoInvalido
    inc di
    inc si
    cmp [di],'$'
    je getPassword
    jmp checkTerminacion

correoInvalido:
    printstr errorCorreo
    jmp getCorreo

getPassword:
    printstr menuContrasenia
    mov cx,0
    mov si,offset contrasenia
    mov bx,0

cicloPassword:
    mov ah,7
    int 21h
    cmp al,13
    je checkPassword
    cmp al,8
    je borrarPassword
    mov [si],al
    inc si 
    inc cx
    mov dl,'*'
    mov ah,2
    int 21h
    cmp cx,19
    jb cicloPassword
    jmp checkPassword
    
borrarPassword:
    call borrar
    jmp cicloPassword
    
checkPassword: 
    cmp cx,6
    jb invalidPassword
    mov si,offset contrasenia
cicloCheckPassword:
    cmp [si],'$'
    je checkFlags
    cmp [si],'1'
    jb next1
    cmp [si],'9'
    ja next1
    mov bl,1
next1:
    cmp [si],'A'
    jb next2
    cmp [si],'Z'
    ja next2
    mov bh,1
next2:
    inc si
    jmp cicloCheckPassword
checkFlags:
    cmp bl,1
    jne invalidPassword
    cmp bh,1
    jne invalidPassword 
    printstr accedido
    jmp fin

invalidPassword:
    printstr errorContrasenia
    jmp getPassword
    
fin:
    int 20h
 
 
proc getTexto
    mov cx,0
primeraLetra:
    mov ah,7
    int 21h
    cmp al,'A'
    jb primeraLetra
    cmp al,'Z'
    ja primeraLetra
    mov dl,al
    mov ah,2
    int 21h
    mov [si],dl
    inc si
    inc cx

cicloGetTexto:
    mov ah,7
    int 21h
    cmp al,13
    je finGetTexto
    cmp al,8
    je borrarTexto
    cmp al,'a'
    jb cicloGetTexto
    cmp al,'z'
    ja cicloGetTexto
    mov dl,al
    mov ah,2
    int 21h
    mov [si],dl
    inc si
    inc cx
    cmp cl,bl
    jb cicloGetTexto
    jmp finGetTexto

borrarTexto:
    call borrar
    cmp cx,0
    je primeraLetra
    jmp cicloGetTexto

finGetTexto:
    cmp cx,3
    jbe cicloGetTexto
ret
getTexto endp

proc borrar
    mov dl,8
    mov ah,2
    int 21h
    mov dl,0
    int 21h
    mov dl,8
    int 21h
    dec si
    mov [si],'$'
    dec cx
ret
borrar endp

proc compararCiudad
    inc di
    cmp [di],'X'
    je ciudadInvalida
    comparar:

        mov dh,[di]
        cmp dh,[si]
        jne recorrerCiudad
        inc di
        inc si
        cmp [di],'$'
        je getCorreo
        jmp comparar
    recorrerCiudad:
        cmp [di],'$'
        je cicloCheckCiudad
        inc di
        jmp recorrerCiudad
ret
compararCiudad endp 

registrofb  db 10,13,"**********************"
			db 10,13,"*    BIENVENIDO      *"
			db 10,13,"**********************$"
menuNombre db 13,10,'Ingrese su nombre: $'
menuApellido db 13,10,'Apellido Paterno: $'
menuApellido2 db 13,10,'Apellido Materno: $'
menuCi db 13,10,'Carnet de Identidad: $'
menuCelular db 13,10,'Celular: +$'
menuCiudad db 13,10,'Ciudad (minusculas): $'
menuCorreo db 13,10,'Correo electronico: $'
menuContrasenia db 13,10,'Contrasenia: $'
accedido db 13,10,'REGISTRADO CORRECTAMENTE$'

ciudades db '$cochabamba$','santa cruz$','oruro$','la paz$','tarija$','sucre$','beni$','potosi$','pando$','X'

errorCiudad db 13,10,'Ciudad no valida intentelo de nuevo$'
errorContrasenia db 13,10,'Contrasenia no valida intentelo de nuevo$'

errorCelular db 13,10,'Numero de celular no valido porfavor vuelve a intentarlo$'

errorCorreo db 13,10,'Correo no valido intentenlo de nuevo$'

nombre db 16 dup ('$')
apellidoP db 16 dup ('$')
apellidoM db 16 dup ('$')

ci db 8 dup ('$')
celular db 11 dup ('$')
ciudad db 25 dup ('$')
correo db 21 dup ('$')
contrasenia db 20 dup ('$')

correoValidator db '@gmail.com$'
