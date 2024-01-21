PrintStr MACRO str
    PUSH DX
    PUSH AX

    LEA DX, str
    MOV AH, 09H
    INT 21H

    POP AX
    POP DX
ENDM

PrintChar MACRO char
    PUSH DX
    PUSH AX

    MOV DL, char
    MOV AH, 02H
    INT 21H

    POP AX
    POP DX
ENDM
