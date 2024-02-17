;Programa que permita el ingreso de N caracteres, numeros y letras, 
;se debe contabilizar las repeticiones de cada uno y 
;mostrar los que mas se repiten y los que menos se repiten.


org 100h

print macro r
    mov dl,r
    call uni
endm

mensaje macro m
    lea dx, m
    call men
endm

;_____1.Captura_____
inicio: mensaje m1

captura:
    lea si,let_num_carac      
    call captura_teclado
    
    cmp al,13
    je encontrar_mayor_menor:
    
    cmp al,21h
    jb captura
    cmp al, 7Eh
    ja captura
    
    print al

buscar:
    cmp [si],' '
    je agregar
    cmp [si],al
    je incrementar
    inc si
    jmp buscar

incrementar:
    dec si
    mov bh,[si]
    inc bh
    mov [si],bh
    jmp captura

agregar:
    mov [si],1
    inc si
    mov [si],al
    jmp captura 
    
    
;_____2.Mayor y Menor_____

encontrar_mayor_menor:
    mensaje m2
    mov bx, 0
    lea si, let_num_carac
    call actualizar

;_____2.1.Mayor_____
mayor:
    cmp [si], ' '
    je imprimir_mayor
    cmp [si], bh
    ja actualizar_mayor
    add si,2
    jmp mayor

actualizar_mayor: 
    call actualizar
    jmp mayor
    
imprimir_mayor:
    call imprimir_repetidos

;_____2.2.Menor_____    
mensaje m3
mov bx,0
lea si, let_num_carac
call actualizar

menor: 
    cmp [si],' '
    je impri_menor
    cmp [si], bh
    jb actualizar_menor
    add si,2
    jmp menor

actualizar_menor:
    call actualizar
    jmp menor

impri_menor:
    call imprimir_repetidos

fin: int 20h

let_num_carac db 200 dup (' ') 


m1 db 'Ingrese Caracteres, Numeros, Letras: $'
m2 db 10,13,'Los mas repetidos: $'
m3 db 10,13,'Los menos repetidos: $'
m4 db 'veces $'


men proc 
    mov ah, 9
    int 21h 
ret
men endp 

uni proc 
    mov ah,2
    int 21h 
ret
uni endp 

captura_teclado proc 
    mov ah,7
    int 21h 
ret
captura_teclado endp

salto proc    
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h    
ret
salto endp 

espacio proc
    mov ah, 2 
    mov dl, 20h
    int 21h
ret
espacio endp 
          
actualizar proc
    mov bh, [si]
    add si, 2   
ret
actualizar endp 


;_____3. Impresion_____ 
imprimir_repetidos proc
    lea bp, let_num_carac
    
    ciclo_imprimir:
        cmp [bp], ' '
        je fin_imprimir
        cmp [bp], bh
        je imprimir_repetido
        add bp, 2 
        jmp ciclo_imprimir
        
    imprimir_repetido:
        call salto
        mov bl, [bp]
        add bl, 30h
        print bl 
        call espacio
        mensaje m4
        call espacio
        inc bp
        print [bp]
        inc bp
        jmp ciclo_imprimir
                  
fin_imprimir: 
ret
imprimir_repetidos endp