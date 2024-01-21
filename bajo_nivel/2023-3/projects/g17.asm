include 'emu8086.inc'
 
printCharjh macro
    push ax
    mov ah, 2
    int 21h
    pop ax
endm
 
salto macro
    push ax
    push dx
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    pop dx
    pop ax        
endm

printj macro string
    push ax
    push dx
    mov ah, 9
    lea dx, string
    int 21h
    pop dx
    pop ax    
endm

num8bToBin macro mem ;el numero tiene que estar en al
    local for    
    pusha
    mov cx, 8
    lea di, mem
    for:     ;00110000b '0'
    mov [di], 00011000b
    rol al, 1
    rcl [di], 1
    inc di
    loop for 
    popa 
endm

num8bToOct macro mem ;el numero tiene que estar en al
    local for, shr3, skip 
    pusha
    lea di, mem
    mov bl, al  ;11000000b
    shr bl, 6   ;00000011b
    add bl, '0'
    mov [di], bl

    inc di
    mov dl, 00111000b
    mov bl, al
    and bl, dl
    shr bl, 3
    add bl, '0'
    mov [di], bl

    inc di
    shr dl, 3 ;00000111b
    mov bl, al
    and bl, dl
    add bl, '0'
    mov [di], bl
    popa        
endm


num8bToHex macro mem ;el numero tiene que estar en al
    pusha
    xor bx, bx
    lea si, hex_alphabet
    lea di, mem
    mov cx, 2
    mov dl, 11110000b
    mov bl, al      ;copiamos el numero
    and bl, dl
    shr bl, 4
    mov bl, [si+bx] ;obtenemos digito hex
    mov [di], bl    ;guardamos en mem 
    inc di

    shr dl, 4       ;00001111b
    mov bl, al      ;copiamos el numero    
    and bl, dl
    mov bl, [si+bx] ;obtenemos digito hex
    mov [di], bl    ;guardamos en mem   
    popa        
endm
   
mostrarLista macro
    local lista_for, lista_end
    mov cx, [SIZE]
    lea di, ARRAY 
    mov dl, '['
    printCharjh
    lista_for:
        mov al, [di]
        print8bitDec 
        inc di
        
        cmp cx, 1 ;se mostro el ultimo elemento
        jz lista_end
        mov dl, ','
        printCharjh 
        mov dl, ' '
        printCharjh
        loop lista_for
    lista_end:
    mov dl, ']'
    printCharjh    
endm

print8bitDec macro ;mover el numero en al
    local dividir, mostrar_digitos 
    push ax
    push cx
    push dx
    xor ah, ah
    xor cx, cx
    dividir: 
        mov  dl, 10  ;se dividira el numero entre 10
        div  dl	 ;AH=resto, AL=cociente 
        mov  bx, ax  ;se respalda AX
        
        shr  ax, 8
        add al, '0'
        push ax
        inc  cx	;se cuenta los numeros
        
        cmp  bl, 0  ;cociente 0
        jz	 mostrar_digitos
        mov  al, bl
    jmp  dividir

    mostrar_digitos:
        pop  dx
        printCharjh
    loop mostrar_digitos
    pop dx
    pop cx
    pop ax    
endm
   
org 100h
X DB 5
Y DB 5 
MOV AX, 0      
MOV SI, 0
MOV DI, 0
MOV CX, 0
               
CALL CLEAR_SCREEN
GOTOXY X,Y
CALL PTHIS
DB 'INTRODUCE EL TAMANIO DE LA LISTA A ORDENAR: ',0 
CALL SCAN_NUM        
MOV SIZE, CX  
PUSH SIZE       
       
LLENAR_ARRAY:
    CALL MOVER_CURSOR
    CALL PTHIS
    DB 'NUMERO: ',0
    CALL SCAN_NUM
    MOV ARRAY[SI], CL
    INC SI
    CMP SI, SIZE
    JB LLENAR_ARRAY
                    
CALL CLEAR_SCREEN 
CALL RESET_CURSOR 

;-----------------------mostrar lista y bin------------------------
salto
printj introc
mostrarLista
 
call ORDENAR

salto  
salto

printj ordenada
mostrarLista

                    
salto
salto

printj outputBin
;binariooooo 
mov cx, [SIZE] ;largo de la lista
lea di, ARRAY  ;cargamos la lista
mov dl, '['
printCharjh
bin_for:
    mov al, [di] 
    num8bToBin bin_number8b
    printj bin_number8b
    inc di

    cmp cx, 1 ;se mostro el ultimo elemento
    jz exit_bin_for
    mov dl, ','
    printCharjh 
    mov dl, ' '
    printCharjh
loop bin_for
exit_bin_for:
mov dl, ']'
printCharjh

salto
salto
printj outputOct 

;-----------------------mostrar en octal y hexadecimal------------------------
;octaaaaal  -_-
mov cx, [SIZE]
lea di, ARRAY 
mov dl, '['
printCharjh
oct_for:
    mov al, [di] 
    num8bToOct oct_number8b
    printj oct_number8b
    inc di

    cmp cx, 1 ;se mostro el ultimo elemento
    jz exit_oct_for
    mov dl, ','
    printCharjh 
    mov dl, ' '
    printCharjh
    loop oct_for
exit_oct_for:
mov dl, ']'
printCharjh

;hexadecimal
salto
salto
printj outputHex  
mov cx, [SIZE]
lea di, ARRAY 
mov dl, '['
printCharjh
hex_for:
    mov al, [di] 
    num8bToHex hex_number8b
    printj hex_number8b
    inc di

    cmp cx, 1 ;se mostro el ultimo elemento
    jz exit_hex_for
    mov dl, ','
    printCharjh 
    mov dl, ' '
    printCharjh
    loop hex_for
exit_hex_for:
mov dl, ']'
printCharjh




jmp end
  
;-----------------------------PROCS----------------------------
MOVER_CURSOR PROC
    INC Y
    INC Y
    GOTOXY X,Y
RET    
ENDP  
;----------
RESET_CURSOR PROC
    MOV X,5
    MOV Y,5
    GOTOXY X,Y       
RET
ENDP
;----------                    
PRINT_LISTA PROC 
    MOV AX,0
    MOV DI,0
    PRINT_L:
        MOV AL, ARRAY[DI]
        CALL PRINT_NUM 
        PUTC 32 
        INC DI
        CMP DI, SIZE
        JB PRINT_L 
    RET    
ENDP
;---------- 
ORDENAR PROC
    mov cx,size
    sub cx,1  

    CICLO1:
        PUSH CX
        MOV SI, 0
        MOV DI, 0

    CICLO2:
        INC DI
        MOV AL, ARRAY[SI]
        CMP AL, ARRAY[DI]
        JA INTERCAMBIO
        JB MENOR

    INTERCAMBIO:
        MOV AH, ARRAY[DI]
        MOV ARRAY[DI], AL
        MOV ARRAY[SI], AH

    MENOR:
        INC SI
        LOOP CICLO2
        POP CX
        LOOP CICLO1  
   
RET
ENDP

end:

int 20h 


DEFINE_PTHIS
DEFINE_CLEAR_SCREEN
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS


SIZE DW 0
ARRAY DB 100 DUP(?)
bin_number8b db 8 dup(?), '$'
oct_number8b db 3 dup(?), '$'

hex_number8b db 2 dup(?), '$'

hex_alphabet db '0123456789ABCDEF'

outputBin   db 'La lista en binario es: $'
outputOct   db 'La lista en octal es: $'
outputHex   db 'La lista en hexadecimal es: $'
introc      db 'La lista que introduciste es: $'
ordenada    db 'La lista ordenada es: $'     