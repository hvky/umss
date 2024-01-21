;Ejercisio :Capturar el resultado de la suma de los numeros capturados con los anteriores:
;ejemplo
;1 2 3  4 5
;9 7 5  3 1

org 100h
inicio:
    mov cx,0 
    mov bx,0;para guardar valores 
inicio2:    
    mov ah,7
    int 21h
    cmp al,13
    je mostrar 
    cmp al,'0'
    jb inicio2
    cmp al,'9'
    ja inicio2
    mov dl,al
    mov ah,2
    int 21h
    push dx
    mov  dl,' '
    int 21h
    pop dx
    sub dl,30h
    mov bl,dl
    add bl,bh;resultado en bl
    push bx 
    mov bh,dl;para el numero anterior 
    inc cx
    jmp inicio2
mostrar:
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    cmp cx,0
    je fin 
mostrar1:
    pop dx;recordando que el resultado esta en la parte baja del registro 
    cmp dl,9
    ja progra
    add dl,30h
    mov ah,2
    int 21h
    jmp finmostrar1
progra:
    mov ax,0
    mov al,dl
    mov dl,10
    div dl 
    xchg ax,dx
    add dx,3030h
    mov ah,2
    int 21h
    mov dl,dh
    int 21h
finmostrar1:;con ah,2 
    mov dl,' '
    int 21h
    loop mostrar1
fin: int 20h
    