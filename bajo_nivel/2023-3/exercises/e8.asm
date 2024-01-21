; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'

print macro msg, x, cad
    PrintStr msg
    mov cl, x
    mov si, offset cad
    call printP
    jmp print_op
endm


; ##########     PROGRAMA     ##########
start:
    PrintStr msg_ingrese
    mov cx, 0

    input_cadena:
        call inputChar
        cmp al, 0Dh
        je procesar_cad

        push ax
        inc cl
        jmp input_cadena

    procesar_cad:
        mov si, offset cadena
        cmp cl, 0
        je print_op

        add si, cx
        dec si
        procesar_cad_loop:
            pop ax

            cmp al, 30h
            jb guardar_caracter
            cmp al, 39h
            jbe guardar_numero
            cmp al, 'A'
            jb guardar_caracter
            cmp al, 'Z'
            jbe guardar_mayuscula
            cmp al, 'a'
            jb guardar_caracter
            cmp al, 'z'
            jbe guardar_minuscula
            jmp guardar_caracter

            guardar_numero:
                push bx
                mov di, offset numeros
                shr bx, 8
                add di, bx

                pop bx
                inc bh
                jmp procesar_cad_loop_pass

            guardar_mayuscula:
                push dx
                mov di, offset mayusculas
                shr dx, 8
                add di, dx

                pop dx
                inc dh
                jmp procesar_cad_loop_pass

            guardar_minuscula:
                push dx
                mov di, offset minusculas
                mov dh, 0
                add di, dx

                pop dx
                inc dl
                jmp procesar_cad_loop_pass

            guardar_caracter:
                push bx
                mov di, offset caracteres
                mov bh, 0
                add di, bx

                pop bx
                inc bl

            procesar_cad_loop_pass:
                mov [di], al
                mov [si], al
                dec si
                loop procesar_cad_loop

    print_op:
        PrintStr menu
        PrintStr cadena
        PrintStr msg_opcion
        mov ch, 0

        call inputChar
        cmp al, 30h
        je end
        cmp al, 31h
        je print_op_numeros
        cmp al, 32h
        je print_op_mayusculas
        cmp al, 33h
        je print_op_minusculas
        cmp al, 34h
        je print_op_caracteres
        jmp error

        print_op_numeros:
            print msg_numeros, bh, numeros

        print_op_mayusculas:
            print msg_mayusculas, dh, mayusculas

        print_op_minusculas:
            print msg_minusculas, dl, minusculas

        print_op_caracteres:
            print msg_caracteres, bl, caracteres

error:
    PrintStr msg_error
    jmp print_op

end:
    int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'

printP proc
    add si, cx
    cmp cx, 0
    ja print_loop

    PrintStr msg_vacio
    jmp print_end

    print_loop:
        dec si
        PrintChar [si]
        loop print_loop

    print_end: ret
printP endp


; ##########     VARIABLES     ##########
msg_ingrese    db 0Ah, 0Dh, 'Ingrese una cadena: $'
msg_numeros    db 2 dup(0Ah, 0Dh), 'Numeros: $'
msg_mayusculas db 2 dup(0Ah, 0Dh), 'Mayusculas: $'
msg_minusculas db 2 dup(0Ah, 0Dh), 'Minusculas: $'
msg_caracteres db 2 dup(0Ah, 0Dh), 'Caracteres: $'
msg_vacio      db 'Sin elementos!$'
msg_error      db 2 dup(0Ah, 0Dh), 'Opcion no valida!', 2 dup(0Ah, 0Dh), 24h
menu           db 2 dup(0Ah, 0Dh), 29 dup('*')
               db 0Ah, 0Dh, '*', 27 dup(0), '*'
               db 0Ah, 0Dh, '*', 3 dup(0), '1. Mostrar numeros   ', 3 dup(0), '*'
               db 0Ah, 0Dh, '*', 3 dup(0), '2. Mostrar mayusculas', 3 dup(0), '*'
               db 0Ah, 0Dh, '*', 3 dup(0), '3. Mostrar minusculas', 3 dup(0), '*'
               db 0Ah, 0Dh, '*', 3 dup(0), '4. Mostrar Caracteres', 3 dup(0), '*'
               db 0Ah, 0Dh, '*', 3 dup(0), '0. Salir             ', 3 dup(0), '*'
               db 0Ah, 0Dh, '*', 27 dup(0), '*'
               db 0Ah, 0Dh, 29 dup('*')
               db 2 dup(0Ah, 0Dh), 'Cadena Actual: $'
msg_opcion     db 0Ah, 0Dh, 'Opcion: $'
cadena         db 255 dup('$')
numeros        db 255 dup(0)
minusculas     db 255 dup(0)
mayusculas     db 255 dup(0)
caracteres     db 255 dup(0)
