;Propusimos realizar un programa para introducir los datos de personas para brindar servicios de
;fibra Óptica en Entel, debe registrar Nombre, Apellidos, Ci, Teléfono y Barrio. Verificar 
;el numero ingresado si concuerda con la región telefónica y el barrio sea de Cochabamba 
;cercado, si es correcto mostrar el mensaje “Factible” caso contrario mostrar “No Factible”.
macro salto 

macro salto 
    mov ah, 2
    mov dl, 0Ah
    int 21h
    mov dl, 0Dh
    int 21h
        
endm

; barrios
;   -ceigo      44XXXXXX
;   -loreto     46XXXXXX
;   -mayorazgo  48XXXXXX

org 100h
inicio:
    registrarNombre:
        mov ah, 9
        mov dx, offset cadIngrNom
        int 21h
    
        mov si, offset nombre
        mov cx, 20
        call capturarLetras
    
    salto
    
    registrarApellidoPa:
        mov ah, 9
        mov dx, offset cadIngrApPa
        int 21h
    
        mov si, offset apellidoPa
        mov cx, 20
        call capturarLetras
    
    salto
    
    registrarApellidoMa:
        mov ah, 9
        mov dx, offset cadIngrApMa
        int 21h
    
        mov si, offset apellidoMa
        mov cx, 20
        call capturarLetras
    
    salto      
        
    registrarCI:
        mov ah, 9
        mov dx, offset cadIngrCi
        int 21h
    
        mov si, offset ci
        mov cx, 10
        call capturarNumeros
        
    salto 
    
    registrarTelefono:
        mov ah, 9
        mov dx, offset cadIngrTefl
        int 21h
    
        mov si, offset telefono
        mov cx, 15
        call capturarNumeros
        
    salto
    
    registrarBarrio:
        mov ah, 9
        mov dx, offset cadIngrBarrio
        int 21h
    
        mov si, offset barrio
        mov cx, 30
        call capturarLetras
    
    salto
    
    VerificarSiEsFactible:
        verificarTelefono:
            mov si, offset telefono
            mov al, [si]
            cmp al, '4'
            je siguienteDig
            jmp mostrarNoEsFactible
        
        siguienteDig:
            mov cx, 0
            inc si
            mov al, [si]
            cmp al, '4'
            je verificarBarrio
            inc cx
            cmp al, '6'
            je verificarBarrio
            inc cx
            cmp al, '8'
            je verificarBarrio
             
        verificarBarrio:
            mov dx, offset barrio
            mov si, offset barrios
            
            ciclo01:
                cmp cl, 0
                je salto01
                mov al, [si]
                cmp al, '$'
                je salto02
                inc si
                jmp ciclo01
                
                salto02:
                loop ciclo01
            
            salto01:    
            mov bx, si
            
            compararBarrios:
                mov si, bx
                mov ah, [si]
                inc bx
                mov si, dx
                mov al, [si]
                inc dx
                cmp al, '$'
                je mostrarEsFactible
                cmp al, ah
                je compararBarrios
                jmp mostrarNoEsFactible  
                     
                
            
    mostrarEsFactible:
        salto
        
        mov ah, 9
        mov dx, offset cadFact
        int 21h
        
        jmp fin
         
    mostrarNoEsFactible:
        salto
        
        mov ah, 9
        mov dx, offset cadNoFact
        int 21h
                
fin: int 20h

cadFact db 'FACTIBLE $'
cadNoFact db 'NO FACTIBLE $'


nombre db 20 dup('$')
cadIngrNom db 'Ingrese Nombre: $'

apellidoPa db 20 dup('$')
cadIngrApPa db 'Ingrese apellido paterno: $'

apellidoMa db 20 dup('$') 
cadIngrApMa db 'Ingrese apellido Materno: $'

ci db 10 dup('$')
cadIngrCi db 'Ingrese CI: $'

telefono db 15 dup('$')
cadIngrTefl db 'Ingrese telefono: $'


barrio db 30 dup('$')
cadIngrBarrio db 'Ingrese Barrio: $'

barrios db 'ceigo$mayorazgo$loreto$'

capturarNumeros proc
    capturarN:
    mov ah, 7
    int 21h
    cmp al, 0Dh   
    je terminarN
    cmp al, '0'
    jb capturarN
    cmp al, '9'
    ja capturarN
    
    mov [si], al
    mov dl, al
    mov ah, 2
    int 21h
    inc si
    loop capturarN
    
    terminarN:
    ret
    
    ret
capturarNumeros endp
capturarLetras proc
    capturarL:
    mov ah, 7
    int 21h
    cmp al, 0Dh
    je terminarL
    cmp al, 'a'
    jb capturarL
    cmp al, 'z'
    ja capturarL
    
    mov [si], al
    mov dl, al
    mov ah, 2
    int 21h
    inc si
    loop capturarL
    
    terminarL:
    ret
capturarLetras endp