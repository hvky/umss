.MODEL SMALL
.STACK 100H

.DATA
    ; Definir la cadena de entrada
    cadenaEntrada DB '@la visita de nikita jruchev a eeuu, en la guerra fria--.,%', 0

.CODE
    MAIN PROC
        ; Inicializar los registros y el �ndice
        MOV AX, @DATA
        MOV DS, AX
    ;------------------------------------------------------
        
        MOV SI, 0 ; �ndice de la cadena de entrada

    imprimirVocales:
        ; Obtener el car�cter actual de la cadena de entrada
        MOV AL, cadenaEntrada[SI]

        ; Verificar si es el car�cter de terminaci�n ('$')
        CMP AL, '$'
        JE finDelPrograma
        
       ;-----------------------------------------------------------------------
        ; Verificar si el car�cter es una vocal (may�scula o min�scula)
        CMP AL, 'A'
        JE esVocal
        CMP AL, 'E'
        JE esVocal
        CMP AL, 'I'
        JE esVocal
        CMP AL, 'O'
        JE esVocal
        CMP AL, 'U'
        JE esVocal
        CMP AL, 'a'
        JE esVocal
        CMP AL, 'e'
        JE esVocal
        CMP AL, 'i'
        JE esVocal
        CMP AL, 'o'
        JE esVocal
        CMP AL, 'u'
        JE esVocal

        ; Si no es vocal, continuar con el siguiente car�cter
        JMP siguienteCaracter
                 
       ;----------------------------------------------------
    esVocal:
        ; Imprimir la vocal
        MOV AH, 02H ; Funci�n para imprimir un car�cter
        MOV DL, AL  ; Car�cter a imprimir
        INT 21H

    siguienteCaracter:
        ; Incrementar el �ndice de la cadena de entrada
        INC SI

        ; Saltar al siguiente car�cter
        JMP imprimirVocales
      ;------------------------------------------------------
    finDelPrograma:
        ; Tu c�digo aqu� para finalizar el programa

        ; Finalizar el programa
        MOV AH, 4CH
        INT 21H
    MAIN ENDP

END MAIN