;EJERCICIO:
;Realizar un programa que capture la informacion de una factura, 
;  -Nit 
;  -Nro factura 
;  -Nro autorizacion 
;  -Nombre cliente 
;  -Monto 
;  -Fecha 
;Se debe generar el codigo de control de factura que tendra 3 componentes. 
;El primer componente sera el promedio de las letras del nombre del cliente,
;el segundo componente sera la sumatoria de los digitos de la fecha, 
;y el tercer componente los dos primeros digitos del NIT.

org 100h
inicio:        
    mov ah,9
    mov dx,offset nit
    int 21h     
    mov si,offset nitIng
    call ingresoNum
    
    call saltoLin
    mov ah,9
    mov dx,offset nro
    int 21h    
    mov si,offset panada
    call ingresoNum
    
    call saltoLin
    mov ah,9
    mov dx,offset nroAuto
    int 21h 
    mov si,offset panada                 
    call ingresoNum
            
    call saltoLin 
    mov ah,9
    mov dx,offset nom
    int 21h  
    mov cx,0
    mov si,offset nomIng
    call ingresoLit
    
    call saltoLin 
    mov ah,9
    mov dx,offset mon
    int 21h  
    mov cx,0
    mov si,offset panada
    call ingresoNum
    
    call saltoLin 
    mov ah,9
    mov dx,offset fecha
    int 21h  
    mov cx,0
    mov si,offset fecIng
    call ingresoNum
     
    mov ah,9
    mov dx,offset codigo
    int 21h
    
    mov si,offset nomIng
    mov bx,0 
ciclo1er:     
    cmp [si],'$'
    je sacar1ro
    sub [si],60h
    add bh,[si] 
    inc si
    inc bl
    jmp ciclo1er    

sacar1ro:     
    mov ax,0
    mov al,bh  
    div bl        
    add al,60h
    mov dl,al
    mov ah,2
    int 21h
    
    mov si,offset fecIng
    mov bx,0
ciclo2do:      
    cmp [si],'$'
    je sacar2do
    cmp [si],'/'
    je saltar   
    sub [si],30h
    add bh,[si] 
    inc si
    jmp ciclo2do
saltar:
    inc si
    jmp ciclo2do    
               
sacar2do: 
    mov dl,bh
    cmp dl,10
    jb unDig
    jmp mostrarDos 

unDig:         
    mov ah,2
    add dl,30h
    int 21h
    jmp ultimo
    
mostrarDos:     
    mov ch,10  
    mov ax,0
    mov al,dl
    div ch 
    mov dx,ax
    mov ah,2
    add dl,30h
    int 21h
    mov dl,dh 
    add dl,30h
    int 21h  

ultimo:                
    mov si,offset nitIng
    mov dl,[si]
    mov ah,2
    int 21h
    inc si
    mov dl,[si]
    int 21h
    
;///////////////////    
fin: int 20h
;///////////////////
nit db "Nit: $" 
nro db "Nro de factura: $"
nroAuto db "Nro de autorizacion: $"
nom db "Nombre (minusculas): $"
mon db "Monto: $"
fecha db "Fecha(dd/mm/aaaa): $" 
codigo db 10,13, "Codigo resultante: ",'$'

panada db 40 dup(' ')
nitIng db 30 dup('$')
nomIng db 40 dup('$')   
fecIng db 11 dup('$')

proc saltoLin
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    ret
saltoLin endp            
    
proc ingresoLit
cicloLetras:   
    mov ah,7
    int 21h    
    cmp al,13
    je finIng1
    cmp al,' '
    je imprimir    
    cmp al,'a'
    jb cicloLetras
    cmp al,'z'
    ja cicloLetras        
imprimir: 
    mov [si],al 
    inc ch
    inc si  
    mov dl,al
    mov ah,2
    int 21h
    jmp cicloLetras 
finIng1:
    ret
    ingresoLit endp 

proc ingresoNum
ciclo:
    mov ah,7
    int 21h
    cmp al,13
    je finIng
    cmp al,'/'
    je guardar
    cmp al,'0'
    jb ciclo
    cmp al,'9'
    ja ciclo
guardar:
    mov ah,2 
    mov [si],al
    inc si
    inc cl
    mov dl,al
    int 21h
    jmp ciclo
finIng:
    ret
    ingresoNum endp