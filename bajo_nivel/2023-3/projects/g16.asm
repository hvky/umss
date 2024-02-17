; Parte 1 ------------------------------------------------------------------------------------------------------------

org 100h
impri macro
     
     mov ah,09h
     int 21h
     mov ah,2
     mov dl,13
     int 21h
     mov dl,10
     int 21h
endm 

;mov dx, offset bienvenida
 lea dx, bienvenida
impri


Inicio:  

   lea dx, control
   impri
   lea dx, operaciones
   impri
   mov ah,7                       
   int 21h  
   cmp al,31h
   je Suma
   cmp al,32h
   je Resta
   cmp al,33h
   je Multiplicacion
   cmp al,34h
   je Division
   lea dx, textError
   impri
   jmp Inicio

; Parte 2 -------------------------------------------------------------------------------------------------------------------        
            
ObtenerNumero: 
   
   mov ah,7
   int 21h
   cmp al,0dh 
   je FormatearNumero      
   cmp al,'0'
   jb error
   cmp al,'9'
   jbe saltoerror
   error:
   lea dx,textErrorNum
   mov ah,9
   int 21h
   jmp inicio
   saltoerror: 
   mov dx,0  
   mov bx,1
   sub ax,30h
   call MostrarNumero 
   mov ah,0 
   push ax 
   inc cx  
   jmp ObtenerNumero 
               
   
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
       
Suma:   
   mov ah,9 
   lea dx,esc1
   int 21h
   lea dx,  text2 
   int 21h
   mov cx,0 
   call ObtenerNumero 
   push dx
   mov ah,9
   lea dx, text3
   int 21h 
   mov cx,0
   call ObtenerNumero
   pop bx
   add dx,bx
   push dx 
   mov ah,9
   lea dx, textResultado
   int 21h
   mov cx,10000
   pop dx
   call Mostrar 
   jmp Salida 
 
; Parte 3 -------------------------------------------------------------------------------------------------------------------
            
Resta: 
        
   mov si,offset signonegativo
   mov ah,9
   lea dx, esc2 
   int 21h
   mov dx, offset text2
   int 21h
   mov cx,0
   call ObtenerNumero
   push dx
   mov ah,9
   mov dx, offset text3
   int 21h 
   mov cx,0
   call ObtenerNumero
   pop bx
   cmp bx,dx
   ja salto
   xchg bx,dx
   mov [si],'V'
   salto:
   sub bx,dx
   mov dx,bx
   push dx 
   mov ah,9
   mov dx, offset textResultado
   int 21h
   cmp [si],'F'
   je salto2
   mov ah,2
   mov dl,'-'
   int 21h
   salto2:    
   mov cx,10000
   pop dx
   call Mostrar 
   jmp Salida 

Multiplicacion:   
   mov ah,9
   lea dx,esc3
   int 21h
   lea dx,  text2
   int 21h
   mov cx,0
   call ObtenerNumero
   push dx
   mov ah,9
   lea dx,  text3
   int 21h 
   mov cx,0
   call ObtenerNumero
   pop bx
   mov ax,dx
   mul bx 
   mov dx,ax
   push dx 
   mov ah,9
   mov dx, offset textResultado
   int 21h
   mov cx,10000
   pop dx
   call Mostrar 
   jmp Salida 

; Parte 4 -------------------------------------------------------------------------------------------------------------------   
    
Division:    
   mov ah,9 
   lea dx,esc4
   int 21h
   mov dx, offset text2
   int 21h
   mov cx,0
   call ObtenerNumero
   push dx
   mov ah,9
   mov dx, offset text3
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
   mov dx, offset textResultado
   int 21h
   mov cx,10000
   pop dx
   call Mostrar
   pop bx
   cmp bx,0
   je Salida 
   jmp Salida
                       
                      
; Parte 5 -------------------------------------------------------------------------------------------------------------------     

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
   lea dx, textFinal1
   impri
   lea dx, textFinal2 
   impri
   mov ah, 0
   int 16h
   cmp al, 'S'
   je Finalizar
   cmp al, 0Dh
   jne Finalizar
   jmp Inicio

Finalizar:
   mov ah, 4Ch
   int 21h

text2:    db      0dh,0ah,"Ingresa el primer numero: $"
text3:    db      0dh,0ah,"Ingresa el segundo numero: $"
textError:    db      0dh,0ah,"Error de eleccion $" 
textResultado:    db      0dh,0ah,"Resultado : $" 
textFinal1:    db      0dh,0ah ,'Presiona "S" para salir ', 0Dh,0Ah, '$'
textFinal2:    db      0dh,0ah ,'Presiona "ENTER" para continuar ', 0Dh,0Ah, '$' 
textErrorNum: db 0dh,0ah,'Error de ingreso de datos, solo se permite numeros', 0dh,0ah, '$'
bienvenida db 'BIENVENIDO YO LO RESUELVO POR TI ',0dh,0ah,'$',
control db 'Para que te ayude elige un numero :','$'
operaciones db '1:Suma',0dh,0ah,"2:Resta",0dh,0ah,"3:Multiplicacion",0dh,0ah,"4:Division", '$'
signonegativo db 'F','$'
esc1 db 'Usted escogio la Suma:',10,13,'$'    
esc2 db 'Usted escogio la Resta:',10,13,'$'
esc3 db 'Usted escogio la Multiplicacion:',10,13,'$'
esc4 db 'Usted escogio la Divicion:',10,13,'$'