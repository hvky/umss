org 100h

muestra macro aux
    mov dx,offset aux
    mov ah,9
    int 21h

endm


    
inicio: 
    mov si,offset almacenar
    mov cx,5
repetir:  
    muestra nom
    call captura
    call salto
    
    muestra ape
    call captura
    call salto
    
    muestra ci
    call captura
    call salto
    mov [si],','
    inc si
loop repetir
    call mostrar
    


fin:int 20h

nom db 'Nombre:$'
ape db 'Apellido:$'
ci db 'CI:$'
almacenar db 200 dup('$')

captura proc

ciclo:    
    mov ah,1
    int 21h
    cmp al,13
    je terminar
    mov [si],al
    inc si
    jmp ciclo
terminar:
    mov [si],'-'
    inc si 
    ret 
    endp

salto proc
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    ret
    salto endp

mostrar proc
mov si,offset almacenar
ciclar:
    
    mov dl,[si]
    mov ah,2
    cmp dl,'$'
    je  finalizar
    cmp [si]+2,'$'
    je finalizar
    cmp [si]+1,','
    je  saltar
    cmp dl,','
    je saltar
    int 21h
    inc si
    jmp ciclar
finalizar:    
     ret
    mostrar endp 
saltar:
mov dl,13
int 21h
mov dl,10
int 21h
inc si
jmp ciclar