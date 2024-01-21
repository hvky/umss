; capturar un numero y mostrar su tabla de suma  (retorno de carro=13 (lleva al inicio de la fila)
; retorno de linea = 10 (enter) para int 21h)
; ej.	2+1=3
;		2+2=4
;		...
;		2+10=12                    
                     
org 100h

inicio:          
    mov ax,0
    mov ah,1      
    int 21h       
    cmp al,'0'
    jb  inicio
    cmp al,'9'
    ja  inicio
    mov bx,0
    mov bl,al
    mov cx,0
           r1:
            mov dl,13
            mov ah,2 
            int 21h
            mov dl,10
            mov ah,2 
            int 21h
            mov dl,bl
            mov ah,2 
            int 21h 
            mov dl,'+'
            int 21h
            inc cx
            mov dl,cl
            add dl,30h
            cmp dl,3ah
            je  dig
            int 21h
            mov dl,'='
            int 21h
            jmp suma
       suma:
            mov bh,bl   
            sub bh,30h
            add bh,cl
            mov dl,bh 
            add dl,30h 
            cmp dl,39h
            ja  suma2digitos
            int 21h
            jmp r1:
         
     suma2digitos:
            mov dh,bl
            mov ax,0
            mov al,bh
            mov bl,10
            div bl
            mov bx,ax
            mov ax,0
            mov ah,2
            mov dl,bl
            add dl,30h
            int 21h
            mov dl,bh
            add dl,30h
            int 21h 
            mov bl,dh  
            cmp cx,10
            jne  r1
        dig:
            sub dl,30h
            mov ax,0
            mov al,dl
            mov bh,10
            div bh 
            mov bx,ax
            mov ax,0
            mov ah,2
            mov dl,bl
            add dl,30h
            int 21h
            mov dl,bh 
            add dl,30h
            int 21h
            mov dl,'='
            int 21h
            sub dh,30h
            add bh,dh
            mov ax,0
            mov ah,2
            mov dl,bl
            add dl,30h
            int 21h
            mov dl,bh 
            add dl,30h
            int 21h

   cmp cx,10
   jne  r1
   fin: int 20h
