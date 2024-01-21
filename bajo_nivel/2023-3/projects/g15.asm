; VERIFICA SI DOS CADENAS SON IGUALES O NO

org 100h
inicio:
    mov ah, 9 
    mov dx, offset msg1     
    int 21h
                             
    mov cx, 199
    mov si, offset cad1
    mov ah, 1
    
c1:
    int 21h
    cmp al, 13
    je c2 
    mov [si] ,al
    inc si
    loop c1
    
c2:    
    mov ah, 2
    mov dl, 10      ;salto de linea y retorno de carro
    int 21h
    mov dl, 13
    int 21h
    
    mov ah, 9 
    mov dx, offset msg2     
    int 21h
                             
    mov cx, 199
    mov si, offset cad2
    mov ah, 1   
    
c3:
    int 21h
    cmp al, 13
    je comienzo: 
    mov [si] ,al
    inc si
    loop c3
    
comienzo: 
    mov si, x
    mov al, cad2[si]
    cmp cad1[si], al ;comparar letra por letra las cadenas, si uno no coincide manda directamente a fin y termina el programa
    jne mostrar2:
    cmp cad1[si], "$" ;si es el final y el programa llega aca, quiere decir que son iguales
    jz mostrar1
    inc x
    loop comienzo  
    
mostrar1:
    mov ah, 2
    mov dl, 10      ;salto de linea y retorno de carro
    int 21h
    mov dl, 13
    int 21h
    
    mov dx, offset msg3 
    mov ah, 9
    int 21h 
    jmp fin
mostrar2:
    mov ah, 2
    mov dl, 10      ;salto de linea y retorno de carro
    int 21h
    mov dl, 13
    int 21h
        
    mov dx, offset msg4 
    mov ah, 9
    int 21h
    
fin:int 20h
cad1 db 200 dup ('$') 
cad2 db 200 dup ('$') 
msg1 db 'Ingrese palabra 1: $'
msg2 db 'Ingrese palabra 2: $'
msg3 db 'Son iguales $'
msg4 db 'NO son iguales $'
x dw 0



