org 100h     

macro enter
    push ax
    push dx
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h

    pop dx
    pop ax
endm


inicio:
    mov bx,0
    mov cx,0
    mov dx,0
    mov bp,0
    
captura:
    mov ah,1
    int 21h
    cmp al,13
    je mostrar
    jmp esMayuscula

esMayuscula:
    cmp al,65
    jb esNumero
    cmp al,90
    ja esMinuscula
    mov si, offset mayusculas
    add si,bp
    mov [si],al
    inc bp
    jmp captura
esMinuscula:
    cmp al,97
    jb esNumero
    cmp al,122
    ja excepciones
    mov si, offset minusculas
    add si,bx
    mov [si],al
    inc bx
    jmp captura    
esNumero:
    cmp al,48
    jb excepciones
    cmp al,57
    ja excepciones
    mov si,offset numeros
    add si,cx
    mov [si],al
    inc cx
    jmp captura
excepciones:
    cmp al,7
    je inicio
    cmp al,8
    je inicio
    cmp al,9
    je inicio
    cmp al,32
    je inicio
    cmp al,0
    je inicio
    cmp al,255
    je inicio
    jmp esEspecial    
esEspecial:
    mov si,offset especiales
    add si,dx
    mov [si],al
    inc dx
    jmp captura

mostrar:
    enter
    enter
    mov dx,offset mayusculas
    jmp mostrarM

mostrarM:
    mov ah,9
    int 21h   
    mov dx,offset minusculas
    enter
    
mostrarmi:    
    mov ah,9
    int 21h
    mov dx,offset numeros
    enter

mostrarN:    
    mov ah,9
    int 21h
    mov dx,offset especiales 
    enter
    
mostrarE:
    mov ah,9
    int 21h

fin:int 20h

mayusculas db 200 dup ("$")
minusculas db 200 dup ("$")
numeros db 200 dup ("$")
especiales db 200 dup("$")