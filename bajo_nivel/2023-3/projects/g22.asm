;Verificar si un numero de 3 digitos es capicua o no

;--------------------------------------------------------
org 100h


inicio:
    mov cx,31
    mov si,offset text 
   
   ;Imprimiendo Mensaje 1 
   imprimirMsg:
    mov ah,2
    mov dl,[si]
    int 21h
    inc si
    loop imprimirMsg
    
   ;Capturando Primer digito y validando 
    mov ah,1
    int 21h
    cmp al,'0'
    jb noNumero   
    cmp al,'9'
    ja noNumero    
    mov bl,al         
    
   ;Capturando Segundo digito y validando     
    mov ah,1
    int 21h
    cmp al,'0'
    jb noNumero   
    cmp al,'9'
    ja noNumero
    mov bh,al  
    
   ;Capturando Terce digito y validando     
    mov ah,1
    int 21h
    cmp al,'0'
    jb noNumero   
    cmp al,'9'
    ja noNumero
    mov dh,al
     
 ;------------
   
   ;Impresion salto de linea y retorno de carro   
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    ;validar si es capicua o no?
    cmp bl,dh
    je esCapicua
    jmp noCapicua
    
 ;-----------
 
 esCapicua:
    mov cx,21   
    mov si,offset text2     
   
   ;Impresion de Mensaje de Confirmacion
    imprimir:
    mov dl,[si]
    int 21h
    inc si
    loop imprimir
  
   ;Impresion del Numero  
    mov dl,bl
    int 21h
    mov dl,bh
    int 21h
    mov dl,dh
    int 21h
    jmp fin 
    
 ;-----------
 
 noCapicua:
    mov cx,23   
    mov si,offset text3
    
    ;Impresion de Mensaje de No confirmacion 
    imprimir2:
    mov ah,2
    mov dl,[si]
    int 21h
    inc si
    loop imprimir2
    jmp fin
    
 ;---------
    
 noNumero:
   ;Impresion salto de linea y retorno de carro        
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    ;Impresion de que no es un caracter valido
    mov cx,37   
    mov si,offset text4     
    imprimir3:
    mov dl,[si]
    int 21h
    inc si
    loop imprimir3
    
   ;Impresion salto de linea y retorno de carro       
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    jmp inicio

fin:int 20h


text db 'Ingrese un numero de 3 digitos:'
text2 db 'El numero es Capicua:'
text3 db 'El numero no es Capicua:'
text4 db 'El caracter ingresado no es un numero'

