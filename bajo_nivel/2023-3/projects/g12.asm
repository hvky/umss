
;   Realizar un programa que solo permita el ingreso de n
;   solo caracteres, se debe cantabilizar las repeticiones
;   de cada cada caracter, mostrar el caracter que mas se
;   repite y el caracter ue menos se repite
                                             
org 100h 

;======================Codigo principal========================   
    
inicio:
 
    call salto
    mov dx,offset cad0   
    call mostrar_cadena
    call salto 
    call salto 
    mov bl,200
    mov bh,1

;-----------------Parte 2---------------------
     
ingresar:

    call ingresar_caracter   
    cmp al,13
    je mostrar
    call guardar_en_cadena;------importante   
    inc bp
    jmp ingresar

;-----------------Parte 3---------------------
     
mostrar:   

    call salto
    mov si,0
    mov cx,di
  
buscar_repetido_primera_vez:  

    mov al,repetidos[si]
    mov dh,al
    cmp bh,dh
    ja siguiente_valor
    xchg bh,dh  
         
siguiente_valor: 

    mov al,repetidos[si] 
    mov dh,al
    cmp bl,dh
    jb siguiente_valor1
    xchg bl,dh
        
siguiente_valor1: 
   
   inc si
   loop buscar_repetido_primera_vez   
   mov cx,bp

;-----------------Parte 4---------------------

mostrar_menos_repetidos:

    call salto 
    mov dx,offset cad1
    call mostrar_cadena
    mov si,0
    mov bp,0
    mov cx,di 
    
mostrar_menos_repetido:

    mov dh,repetidos[si] 
    cmp dh,bl
    jne siguiente2
    inc bp
    cmp bp,1
    je siguiente22
    mov ah,2 
    mov dl,44
    int 21h
   
siguiente22:  

   mov dl,caracteres[si]
   mov ah,2
   int 21h
  
siguiente2:

   inc si 
   loop mostrar_menos_repetido 

;-----------------Parte 5---------------------
  
mostrar_mas_repetidos:

   call salto 
   mov dx,offset cad2
   call mostrar_cadena
   mov si,0
   mov bp,0
   mov cx,di
   
mostrar_mas_repetido: 

   mov dh,repetidos[si] 
   cmp dh,bh
   jne siguiente3
   inc bp
   cmp bp,1
   je siguiente33
   mov ah,2 
   mov dl,44
   int 21h
   
siguiente33:  

   mov dl,caracteres[si]
   mov ah,2
   int 21h

siguiente3:

   inc si 
   loop mostrar_mas_repetido       
     
fin: 

   int 20h    

;======================Procedimientos========================   

salto proc
        
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
ret        
salto endP

;---------------------------------------------

mostrar_cadena proc 
    
    mov ah,9
    int 21h
    
ret              
mostrar_cadena endP  

;---------------------------------------------

ingresar_caracter proc
    
    mov ah,1
    int 21h
     
ret
ingresar_caracter endP 

;---------------------------------------------
                                              
guardar_en_cadena proc 
    
    mov si,0
    cmp di,0
    jne buscar_repetido
    mov caracteres[di],al 
    mov repetidos[di],1
    inc di
    jmp siguiente1
        
buscar_repetido: 

    mov cx,di   
     
busca_repetido:  

    cmp al,caracteres[si]
    je repite  
    inc si 
    loop busca_repetido
                 
    mov caracteres[di],al
    mov repetidos[di], 1 
    inc di
    jmp siguiente1
         
repite: 

    mov al,repetidos[si]
    add al,1 
    mov repetidos[si],al 
   
siguiente1:

    ret 
            
guardar_en_cadena endP   


;======================Variables========================
    
  caracteres db 100 dup ('$')
  repetidos db 100 dup ('$') 
  cad0 db '_BIENVENIDO INTRODUZCA N CARACTERES_$'
  cad1 db '..:: las letras que menos se repiten -> $'
 cad2 db '..:: las letras que mas se repiten -> $' 
   
 
;==============Funcion del proc guardar_en_cadena==============  
   
;   a b c d t r e    cadena caracteres
;   1 2 5 3 3 2 2    cadena repetidos