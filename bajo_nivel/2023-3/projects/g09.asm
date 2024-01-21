; Problema grupo 9: Creacion de una calculadora simple que presenta un men� con opciones 
; 1-Sumar 
; 2-Multiplicar
; 3-Restar 
; 4-Dividir
; Los usuarios eligen una opci�n, ingresan dos n�meros positivos enteros y el programa realiza la operaci�n seleccionada, 
;mostrando el resultado despues de mostrar el resultado se puede presionar cualquier tecla para finalizar el programa

org 100h 
; SECCION 1 ------------------------------------------------------------------------------------------------------------
Inicio:  
        mov ah,9
        mov dx, offset Mensaje
        int 21h
        mov ah,0                       
        int 16h  
        cmp al,31h
        je Sumar
        cmp al,32h
        je Multiplicar
        cmp al,33h
        je Restar
        cmp al,34h
        je Dividir
        mov ah,09h
        mov dx, offset MensajeError
        int 21h
        mov ah,0
        int 16h
        jmp Inicio
        
            
ObtenerNumero:    
            mov ah,0
            int 16h      
            mov dx,0  
            mov bx,1 
            cmp al,0dh 
            je FormatearNumero
            sub ax,30h
            call MostrarNumero 
            mov ah,0 
            push ax 
            inc cx  
            jmp ObtenerNumero 
               
   
; SECCION 2 -------------------------------------------------------------------------------------------------------------------

FormatearNumero:     
            pop ax
            push dx      
            mul bx
            pop dx
            add dx,ax
            mov ax,bx    
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne FormatearNumero
            ret   
       
Sumar:   
            mov ah,9 
            mov dx, offset Mensaje2 
            int 21h
            mov cx,0 
            call ObtenerNumero 
            push dx
            mov ah,9
            mov dx, offset Mensaje3
            int 21h 
            mov cx,0
            call ObtenerNumero
            pop bx
            add dx,bx
            push dx 
            mov ah,9
            mov dx, offset MensajeResultado
            int 21h
            mov cx,10000
            pop dx
            call Mostrar 
            jmp Salida 
 ; SECCION 3 -------------------------------------------------------------------------------------------------------------------
            
Restar:   
            mov ah,9
            mov dx, offset Mensaje2
            int 21h
            mov cx,0
            call ObtenerNumero
            push dx
            mov ah,9
            mov dx, offset Mensaje3
            int 21h 
            mov cx,0
            call ObtenerNumero
            pop bx
            sub bx,dx
            mov dx,bx
            push dx 
            mov ah,9
            mov dx, offset MensajeResultado
            int 21h
            mov cx,10000
            pop dx
            call Mostrar 
            jmp Salida 


                                               
Multiplicar:   
            mov ah,9
            mov dx, offset Mensaje2
            int 21h
            mov cx,0
            call ObtenerNumero
            push dx
            mov ah,9
            mov dx, offset Mensaje3
            int 21h 
            mov cx,0
            call ObtenerNumero
            pop bx
            mov ax,dx
            mul bx 
            mov dx,ax
            push dx 
            mov ah,9
            mov dx, offset MensajeResultado
            int 21h
            mov cx,10000
            pop dx
            call Mostrar 
            jmp Salida 



 ; SECCION 4 -------------------------------------------------------------------------------------------------------------------   
    
Dividir:    
            mov ah,9
            mov dx, offset Mensaje2
            int 21h
            mov cx,0
            call ObtenerNumero
            push dx
            mov ah,9
            mov dx, offset Mensaje3
            int 21h 
            mov cx,0
            call ObtenerNumero
            pop bx
            mov ax,bx
            mov cx,dx
            mov dx,0
            mov bx,0
            div cx
            mov bx,dx
            mov dx,ax
            push bx 
            push dx 
            mov ah,9
            mov dx, offset MensajeResultado
            int 21h
            mov cx,10000
            pop dx
            call Mostrar
            pop bx
            cmp bx,0
            je Salida 
            jmp Salida
                       
                      
 ; SECCION 5 -------------------------------------------------------------------------------------------------------------------     
Mostrar:  
       mov ax,dx 
       mov dx,0
       div cx 
       call MostrarNumero
       mov bx,dx 
       mov dx,0
       mov ax,cx 
       mov cx,10
       div cx
       mov dx,bx 
       mov cx,ax
       cmp ax,0
       jne Mostrar
       ret

MostrarNumero:    
           push ax 
           push dx
           mov dx,ax 
           add dl,30h 
           mov ah,2
           int 21h
           pop dx  
           pop ax
           ret

Salida:   
        mov dx,offset MensajeFinal
        mov ah, 9
        int 21h  
        mov ah, 0
        int 16h
        ret     
      

Mensaje:    db      "1-Sumar",0dh,0ah,"2-Multiplicar",0dh,0ah,"3-Restar",0dh,0ah,"4-Dividir", 0Dh,0Ah, '$'
Mensaje2:    db      0dh,0ah,"Ingresa el primer numero: $"
Mensaje3:    db      0dh,0ah,"Ingresa el segundo numero: $"
MensajeError:    db      0dh,0ah,"Error de eleccion $" 
MensajeResultado:    db      0dh,0ah,"Resultado : $" 
MensajeFinal:    db      0dh,0ah ,'Presiona cualquier tecla para salir... ', 0Dh,0Ah, '$' 
