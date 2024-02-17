;ESCRITURA DE UN STRING EN PANTALLA
 
org 100h  

;escribe texto1
mov AH, 09h 
mov DX, offset texto1
int 21h  

;escribe texto2
mov AH, 09h 
mov DX, offset texto2
int 21h

;fin del programa
int 20h

texto1 DB 'Hola',13,10,'$'
texto2 DB 'Mundo',13,10,'$'