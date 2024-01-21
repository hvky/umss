;Un programa que solo permita el ingreso de 3 numeros de Hasta 3 digitos cada uno. 
;Sumar el medio y el menor y mostrar la tabla de suma de cada digito del resultado. Restar el 
;mayor y menor y mostrar la tabla de multiplicacion del primer y ultimo digito del resultado.
;como son numeros de 3 digitos tenemos que usar un registro de 16 bits 


org 100h
inicio:
    mov dx,offset ingrese_numeros 
    mov ah,9
    int 21h
    mov si, offset numeros
    mov cx,3
    mov bx,0
c1_main: 
    call captura_num 
    cmp al,13 
    je sig_num
    mov ah,0
    xchg ax,bx 
    call captura_num
    cmp al,13
    je sig_num 
    ;se tiene un numero de dos dig
    mov ah,0
    xchg ax,bx
    mov bh,0
    mov dl,10
    mul dl 
    add bx,ax
    call captura_num
    cmp al,13
    je sig_num 
    ;se tiene un numero de tres digitos 
    xchg ax,bx
    mov bh,0
    mov dx,10
    mul dx
    add bx,ax
sig_num: 
    mov [si], bx
    mov dl,' '
    mov ah,2 
    int 21h
    mov bx,0
    inc si
    inc si
    loop c1_main
    call enter 
    call ordenar;ordena los valores de mayor a menor en la memoria reservada  
    call suma ;hace la suma del medio con el menor y lo almacena en la memoria suma 
    call mostrar_tabla_suma ;muestra la tabla de la suma de los digitos en la memoria suma
    call restar
    call mostrar_tabla_mul
       
fin:
    int 20h
;******************* PROCESOS **********************
mostrar_tabla_mul proc
    mov si,offset resta_
    mov ax,[si]
    cmp ax,10
    jb undig_mul
    cmp ax,100
    jb dosdig_mul 
tresdig_mul:
    mov bx,100
    mov dx,0
    div bx 
    call enter
    call tabla_mul_al
    mov ax,dx
    mov bx,10
    div bl
    mov al,ah
    call tabla_mul_al
    jmp fin_tabla_mul
dosdig_mul:
    mov bx,10
    div bl
    mov dx,ax
    call tabla_mul_al
    mov al,dh
    call enter 
    call tabla_mul_al 
    jmp fin_tabla_mul
undig_mul:
    call tabla_mul_al
fin_tabla_mul:    
    ret
mostrar_tabla_mul endp


tabla_mul_al proc
    push dx
    mov bl,al
    mov bh,1
    mov cx,10
c1_mul_al:
    mov dl,bl
    add dl,30h
    mov ah,2
    int 21h
    mov dl,'*'
    int 21h
    mov dl,bh
    cmp dl,9
    jbe undig_bh
    mov ax,0
    mov al,dl
    mov dl,10
    div dl
    xchg dx,ax
    add dl,30h
    mov ah,2
    int 21h
    mov dl,dh
undig_bh:
    add dl,30h
    mov ah,2 
    int 21h
    
    mov dl,'='
    int 21h
    mov al,bl
    mov ah,0
    mul bh
    mov dl,al
    cmp dl,9
    jbe undig_res
    mov ax,0
    mov al,dl
    mov dl,10
    div dl
    xchg dx,ax
    add dl,30h
    mov ah,2 
    int 21h
    mov dl,dh
undig_res:
    add dl,30h
    mov ah,2
    int 21h
    call enter
    inc bh
    loop c1_mul_al
    pop dx  
    ret
tabla_mul_al endp
    
    

restar proc
    mov si, offset numeros 
    mov ax,[si];el mayor
    add si, 4h;con 2h estamos en el medio con otros 2h en el tercer numero
    mov bx,[si];tenemos el tercer numero
    sub ax,bx
    mov si,offset resta_
    mov [si],ax
    ret
restar endp




mostrar_tabla_suma proc
    mov si,offset suma_
    mov ax,[si]
    mov bx,10
    cmp ax,bx 
    jb undig_suma
    mov bx,100 
    cmp ax,bx
    jb dosdig_suma
    mov bx,1000 
    cmp ax,bx
    jb tresdig_suma
cuatrodig_suma:
    mov bx,1000
    mov dx,0
    div bx
    call tabla_en_al;imprime la tabla en al 
    mov ax,dx
    call enter
tresdig_suma:
    mov bx,100
    mov dx,0
    div bx
    call tabla_en_al
    mov ax,dx
    call enter
dosdig_suma:
    mov bl,10
    div bl
    mov dx,ax
    call tabla_en_al
    xchg al,dh
    mov ah,0
    call enter
undig_suma:
    call tabla_en_al
    call enter
    ret 
mostrar_tabla_suma endp




tabla_en_al proc
    push ax
    push dx
    mov bl,al
    mov bh,1        
    mov cx,10
    
c1_tabla:
    mov dl,bl
    add dl,30h
    mov ah,2
    int 21h
    mov dl,'+'
    int 21h
    mov dl,bh
    cmp dl,9
    jbe undig_tabla 
dosdig_tabla:
    mov al,dl
    mov ah,0
    mov dl,10
    div dl
    xchg ax,dx
    add dl,30h
    mov ah,2
    int 21h
    mov dl,dh
undig_tabla:
    add dl,30h
    mov ah,2
    int 21h
    mov dl,'='
    int 21h
    mov al,bl
    add al,bh;resultado
    cmp al,9
    jbe undig_resultado_tabla
    mov ah,0
    mov dl,10
    div dl
    xchg ax,dx
    add dl,30h
    mov ah,2
    int 21h
    ;mov dl,dh
    mov al,dh
undig_resultado_tabla:
    mov dl,al
    add dl,30h
    mov ah,2 
    int 21h
    
    call enter
    inc bh
    loop c1_tabla 
    pop dx
    pop ax
     
    ret
tabla_en_al endp

  
enter proc
    push ax
    push dx
    mov ah,9
    mov dx,offset enter_
    int 21h
    pop dx
    pop ax
    ret
enter endp


suma proc 
    mov si,offset numeros; dato, el mayor es el primer dato 
    inc si 
    inc si 
    mov ax,[si]
    inc si 
    inc si 
    mov bx,[si]
    add ax,bx
    mov si,offset suma_ 
    mov [si],ax
    ret 
suma endp  



ordenar proc 
    mov si,offset numeros
    mov ax,[si]
    add si,2h;si en 2
    cmp ax,[si];1vs2
    ja sig1_ordenar
    mov bx,[si]
    xchg ax,bx
    sub si,2h;si en 1
    mov [si],ax
    add si,2h;si en 2 
    mov [si],bx 
sig1_ordenar:;
    add si,2h;si en 3 
    cmp  ax,[si];1vs3
    ja sig2_ordenar
    mov bx,[si]
    xchg ax,bx
    sub si,4h;si en 1
    mov [si],ax 
    add si,4h;si en 3
    mov [si],bx
sig2_ordenar:
    sub si,2h;si en 2 
    mov ax,[si];
    add si,2h;si en 3 
    cmp ax,[si];1
    ja fin_ordenar 
    mov bx,[si]
    xchg ax,bx
    dec si
    dec si
    mov [si],ax
    inc si 
    inc si
    mov [si],bx    
fin_ordenar:    
    ret 
ordenar endp 



captura_num proc
c1_cap:
    mov ah,7
    int 21h
    cmp al,13
    je fin_captura_num
    cmp al,'0'
    jb c1_cap
    cmp al,'9'
    ja c1_cap 
    mov dl,al
    mov ah,2
    int 21h
    mov al,dl
    sub al,30h
fin_captura_num: 
    ret
captura_num endp
numeros dw 3 dup(0)
suma_ dw 0
ingrese_numeros db 'Ingrese numeros: $'
enter_ db 10,13,'$'
resta_ dw 0
