
;REPETICION DE INSTRUCCIONES
;CON EL USO DE CICLO (LOOP)

org 100h

;numero de veces que
;se repetira el ciclo
mov CX, 10

ciclo1: 

    mov DL, 'N'
    mov AH, 02h ;imprimir un caracter
    int 21h	;imprime DL

loop ciclo1

;fin del programa
int 20h