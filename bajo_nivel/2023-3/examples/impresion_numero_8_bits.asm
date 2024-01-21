
;IMPRESION DE UN NUMERO DE 8 BITS (0-255).

org 100h

MOV AL, 234 ;NUMERO 
MOV AH, 0
MOV CX, 0

dividir: 

    MOV  DL, 10  ;se dividira el numero entre 10
    DIV  DL	 ;AH=resto, AL=cociente 
    MOV  BX, AX  ;se respalda AX
    
    SHR  AX, 8	;se mueve el resto de AH hacia AL  10101010 01010101 ---- 01010101 10101010 ---- 01 10101010 010101
    PUSH AX	;se guarda en la pila solo el resto
    INC  CX	;se cuenta los numeros apilados
    
    CMP  BL, 0	;cociente = 0 ?
    JE	 imprimir_pila
    MOV  AL, BL ;el cociente BL se mueve a AL
    JMP  dividir

imprimir_pila:
    
    POP  DX
    ADD  DL, '0'
    MOV  AH, 02h
    INT  21h
    LOOP imprimir_pila
    
INT 20h 